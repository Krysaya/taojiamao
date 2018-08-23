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
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.使用默认配置初始化
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
//    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
//    //配置广告数据
//    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
//    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = @"qdt.png";
//    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
////    imageAdconfiguration.openModel = @"http://www.it7090.com";
//    //显示图片开屏广告
//    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
//        NSLog(@"Init failed: %@", error.description);
    }];
    [[ALBBSDK sharedInstance]setAuthOption:NormalAuth];
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
    
//    配置请求类
//HYBNetworking updateBaseUrl:<#(NSString *)#>
    return YES;
}

-(void)doTJOverallJudge{
    //网络
    [TJOverallJudge judgeNet];
    
//    //是否第一次打开
    if ([[TJOverallJudge sharedJudge]judgeFirstOpen]) {
        DSLog(@"第一次打开");
        NSString * str = GetUserDefaults(ISFIRST);
        DSLog(@"%@",str);
        ViewController * vc = [[ViewController alloc]init];
        self.window.rootViewController = vc;
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
    self.window = [[UIWindow alloc]initWithFrame:S_F];
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


@end
