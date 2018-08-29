//
//  TJLaunchAdManager.m
//  taojiamao
//
//  Created by yueyu on 2018/5/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJLaunchAdManager.h"
#import "TJLaunchModel.h"
#import "TJWebController.h"
#import "UIViewController+Nav.h"

#define DuratioN  6

@interface TJLaunchAdManager()<XHLaunchAdDelegate>

@end

@implementation TJLaunchAdManager

+(void)load{
    [self shareManager];
}

+(TJLaunchAdManager *)shareManager{
    static TJLaunchAdManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[TJLaunchAdManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            [self setupXHLaunchAd];
        }];
    }
    return self;
}

-(void)setupXHLaunchAd{
    
    /** 1.图片开屏广告 - 网络数据 */
    [self example01];
    
}

#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)example01{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    
//    [XDNetworking postWithUrl:LaunchImage refreshRequest:NO cache:NO params:nil progressBlock:nil successBlock:^(id response) {
//        //广告数据转模型
//        TJLaunchModel * model = [TJLaunchModel yy_modelWithDictionary:response[@"data"]];
////        //配置广告数据
//        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//        广告停留时间
//        imageAdconfiguration.duration = DuratioN;
////        //广告frame
//        imageAdconfiguration.frame = CGRectMake(0, 0, S_W, S_H);
////        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//        imageAdconfiguration.imageNameOrURLString = model.content;
////        //设置GIF动图是否只循环播放一次(仅对动图设置有效)
////        imageAdconfiguration.GIFImageCycleOnce = NO;
////        //缓存机制(仅对网络图片有效)
////        //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
////        //图片填充模式
//        imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
////        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        imageAdconfiguration.openModel = model.url;
////        imageAdconfiguration.openModel = @"www.baidu.com";//test
////        //广告显示完成动画
//        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
////        //广告显示完成动画时间
//        imageAdconfiguration.showFinishAnimateTime = 0.8;
////        //跳过按钮类型
//        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
////        //后台返回时,是否显示广告
//        imageAdconfiguration.showEnterForeground = YES;
////
////        //图片已缓存 - 显示一个 "已预载" 视图 (可选)
////        if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]]){
////            //设置要添加的自定义视图(可选)
////            imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
////
////        }
//        //显示开屏广告
//        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//    } failBlock:^(NSError *error) {
//        
//    }];

}

#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    DSLog(@"广告点击事件");
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel==nil) return;
    
    TJWebController *VC = [[TJWebController alloc] init];
    NSString *urlString = (NSString *)openModel;
    if (urlString.length==0) return;
    VC.URL = urlString;
    //此处不要直接取keyWindow
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.myNavigationController pushViewController:VC animated:YES];
    
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
    DSLog(@"图片下载完成/或本地图片读取完成回调");
}

/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL{
//    
//    DSLog(@"video下载/加载完成 path = %@",pathURL.absoluteString);
//}

/**
 *  视频下载进度回调
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current{
//
//    DSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
//}

/**
 *  广告显示完成
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    
    DSLog(@"广告显示完成");
}

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理(注意:实现此方法后,图片缓存将不受XHLaunchAd管理)
 
 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url
//{
//    [launchAdImageView sd_setImageWithURL:url];
//
//}

@end


















