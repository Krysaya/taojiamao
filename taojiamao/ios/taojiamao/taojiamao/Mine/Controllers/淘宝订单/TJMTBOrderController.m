

//
//  TJMTBOrderController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMTBOrderController.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibcTradeSDK/AlibcTradePageFactory.h>
#import <AlibcTradeSDK/AlibcTradeService.h>
@interface TJMTBOrderController ()

@end

@implementation TJMTBOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self openTaoBaoOrder];
    // Do any additional setup after loading the view.
}
- (void)openTaoBaoOrder{
    [SVProgressHUD show];
    [SVProgressHUD dismissWithDelay:3];
    UIWebView *webV = [[UIWebView alloc]initWithFrame:S_F];
    [self.view addSubview:webV];
    //打开我的订单页
    WeakSelf
    id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeH5;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:weakSelf webView:webV page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            //            [SVProgressHUD dismiss];
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            //            [SVProgressHUD dismiss];
            
        }];
    });
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
