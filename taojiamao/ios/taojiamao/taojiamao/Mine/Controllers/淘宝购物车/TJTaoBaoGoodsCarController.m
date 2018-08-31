
//
//  TJTaoBaoGoodsCarController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/31.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTaoBaoGoodsCarController.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibcTradeSDK/AlibcTradePageFactory.h>
#import <AlibcTradeSDK/AlibcTradeService.h>
@interface TJTaoBaoGoodsCarController ()
@property (weak, nonatomic) IBOutlet UIWebView *webV;

@end

@implementation TJTaoBaoGoodsCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝购物车";
    [self openTaoBaoOrder];
    // Do any additional setup after loading the view from its nib.
}
- (void)openTaoBaoOrder{
//    [SVProgressHUD show];
//    UIWebView *webV = [[UIWebView alloc]initWithFrame:S_F];
//    [self.view addSubview:webV];
    //打开我的购物车
    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeH5;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:self webView:self.webV page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
//            [SVProgressHUD dismiss];
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            
        }];
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
