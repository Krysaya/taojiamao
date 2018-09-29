//
//  TJAgentPromoteController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAgentPromoteController.h"
#import "TJMyAgentsModel.h"

@interface TJAgentPromoteController ()<iCarouselDelegate,iCarouselDataSource,ShareBtnDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageC;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJAgentPromoteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是代理";
    self.carousel.type  = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
    self.pageC.currentPage = 0;
    [self loadAgentPic];
}
- (void)loadAgentPic{
    WeakSelf
    self.dataArr = [NSMutableArray array];
    [KConnectWorking requestNormalDataParam:nil withRequestURL:MyAgentLevel withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        
        DSLog(@"--%@",responseObject);
        weakSelf.dataArr = [TJMyAgentsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [weakSelf.carousel reloadData];
        weakSelf.pageC.numberOfPages = weakSelf.dataArr.count;
        
    } withFailure:^(NSError * _Nullable error) {
    }];
}
#pragma mark - icarouseldelegte
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.dataArr.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view==nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(10, 15, S_W-50, carousel.yj_height)];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
        TJMyAgentsModel *model = self.dataArr[index];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W-50, carousel.yj_height)];
        [img sd_setImageWithURL: [NSURL URLWithString:model.image]];
        [view addSubview:img];
        
    }
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    return value*1.04;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    //    切换index
    self.pageC.currentPage = carousel.currentItemIndex;
}

- (IBAction)saveImagePic:(UIButton *)sender {
}

- (IBAction)sharePIC:(UIButton *)sender {
    TJInvitationView *iview = [TJInvitationView invitationView];
    iview.backgroundColor = RGBA(1, 1, 1, 0.2);
    iview.frame = CGRectMake(0, 0, S_W, S_H);iview.delegate = self;
    [self.view addSubview:iview];
}
#pragma mark - share
- (void)shareButtonClick:(NSInteger)sender{
    //创建分享参数
    TJMyAgentsModel *model = self.dataArr[self.pageC.currentPage];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@""
                                     images:[NSURL URLWithString:model.image] //传入要分享的图片
                                        url:[NSURL URLWithString:model.image]
                                      title:@""
                                       type:SSDKContentTypeImage];
    
    if (sender==140) {
        //        朋友圈
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else  if (sender==141) {
        //        好友
        [ShareSDK share:SSDKPlatformSubTypeWechatSession //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else  if (sender==144) {
        //sms
        //短信
        [shareParams SSDKSetupSMSParamsByText:@"" title:@"" images:[NSURL URLWithString:model.image] attachments:nil recipients:nil type:SSDKContentTypeImage];
        
        [ShareSDK share:SSDKPlatformTypeSMS //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else  if (sender==145) {
        //link
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.image;
        if (pasteboard == nil) {
            [SVProgressHUD showInfoWithStatus:@"复制失败"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"已复制"];
        }
    }else if (sender==142){
        //       qq
        [ShareSDK share:SSDKPlatformSubTypeQQFriend //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else if(sender==143){
        //        qqarz
        [ShareSDK share:SSDKPlatformSubTypeQZone //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }
}
@end
