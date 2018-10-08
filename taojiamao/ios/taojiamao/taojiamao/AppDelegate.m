//
//  AppDelegate.m
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "AppDelegate.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "ViewController.h"
#import "TJLaunchAdManager.h"
#import "DHGuidePageHUD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
//    分享share
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeMail),
                                        @(SSDKPlatformTypeSMS),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;

             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {

         switch (platformType)
         {

             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxdd6702d275a50e3b"
                                       appSecret:@"b61472da8f8c33a18b4fb8e25daa4cf3"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105829331"
                                      appKey:@"c7394704798a158208a74ab60104f0ba"
                                    authType:SSDKAuthTypeBoth];
                 break;


             default:
                 break;
         }
     }];
//    注册微信
    [WXApi registerApp:@"wxdd6702d275a50e3b"];

    //1.使用默认配置初始化
    [TJLaunchAdManager load];
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
    } failure:^(NSError *error) {
//        NSLog(@"Init failed: %@", error.description);
    }];
//    [[ALBBSDK sharedInstance] setAuthOption:H5Only];
    [[ALBBSDK sharedInstance]setAuthOption:NormalAuth];
    [[ALBBSDK sharedInstance] setAppkey:@"25038195"];
    // 开发阶段打开日志开关，方便排查错误信息
    //默认调试模式打开日志,release关闭,可以不调用下面的函数
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
    // 配置全局的淘客参数
    //如果没有阿里妈妈的淘客账号,setTaokeParams函数需要调用
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"51786779_16868079_62182259"; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //设置全局状态栏字体颜色为白色
    // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    //TJOverallJudge
    [self doTJOverallJudge];
    //IQKeyboard
    [self setIQKeyboard];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setMaximumDismissTimeInterval:10];

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        [TJOverallJudge sharedJudge].netStatus = status;
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DSLog(@"-------未知网络");
                [SVProgressHUD showInfoWithStatus:@"未知网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DSLog(@"-------没有网络");
                [SVProgressHUD showInfoWithStatus:@"没有网络！"];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DSLog(@"------手机自带网络");
                [SVProgressHUD showInfoWithStatus:@"数据网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DSLog(@"--------WIFI");
                break;
        }
    }];
    
    //开始监控
    [manager startMonitoring];
    return YES;
}

-(void)doTJOverallJudge{
  
//    //是否第一次打开
    if ([[TJOverallJudge sharedJudge]judgeFirstOpen]) {
        DSLog(@"第一次打开");
        NSString * str = GetUserDefaults(ISFIRST);
        DSLog(@"%@",str);
        [self chooseControllersNoGuide];

        NSArray * imageArray = @[@"ydy_1.jpg",@"ydy_2.jpg",@"ydy_3.jpg"];
        DHGuidePageHUD * guidePage = [[DHGuidePageHUD alloc]dh_initWithFrame:S_F imageNameArray:imageArray buttonIsHidden:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:guidePage];

    }else{
        DSLog(@"不是第一次");
        [self chooseControllersNoGuide];
    }
    
    //md5加密Authcode
//    [[TJOverallJudge sharedJudge] judgeAuthcode];
    
}
-(void)setIQKeyboard{
    //键盘
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    
    keyboardManager.enable = YES;
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
#pragma mark controllers
-(void)chooseControllersNoGuide{
//    self.window = [[UIWindow alloc]initWithFrame:S_F];
    TJTabBarController * tbc = [[TJTabBarController alloc]init];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    TJLoginController *vc = [TJAppManager sharedTJAppManager].loginVC;
    return  [WXApi handleOpenURL:url delegate:vc];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 跳转= %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else{
        
        if ([[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
            return YES;
        }
        
        TJLoginController *vc = [TJAppManager sharedTJAppManager].loginVC;
        if ([WXApi handleOpenURL:url delegate:vc]) {
            return YES;
        }
        
        if ([TencentOAuth HandleOpenURL:url]) {
            return YES;
        }
    
        
    }
    
    
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result aaa = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else
    {
        if (@available(iOS 9.0, *)) {
            if ([[AlibcTradeSDK sharedInstance] application:app openURL:url options:options]) {
                return YES;
            }
        } else {
            // Fallback on earlier versions
        }
        
        TJLoginController *vc = [TJAppManager sharedTJAppManager].loginVC;
        if ([WXApi handleOpenURL:url delegate:vc]) {
            return YES;
        }
        
        if ([TencentOAuth HandleOpenURL:url]) {
            return YES;
        }
        
    }
    
    
    
    
    return YES;
}
@end
