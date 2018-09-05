
//
//  TJTaoBaoOrderController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTaoBaoOrderController.h"
#import "TJTBOrderContentController.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibcTradeSDK/AlibcTradePageFactory.h>
#import <AlibcTradeSDK/AlibcTradeService.h>
@interface TJTaoBaoOrderController ()

@end

@implementation TJTaoBaoOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝订单";
    self.view.frame = CGRectMake(0, 64, S_W, S_H);
    [self openTaoBaoOrder];
//    [self setControllers];
//淘宝订单
    // Do any additional setup after loading the view.
}
- (void)openTaoBaoOrder{
//    [SVProgressHUD show];
    UIWebView *webV = [[UIWebView alloc]initWithFrame:S_F];
    [self.view addSubview:webV];
    //打开我的订单页
    id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeH5;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:self webView:webV page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
//            [SVProgressHUD dismiss];
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
//            [SVProgressHUD dismiss];

        }];
    });
    
}


-(void)setControllers{
    
    self.titles = @[@"全部",@"待结算",@"已结算"];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.selectIndex = 0;
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 15;
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(51, 51, 51);
    self.progressColor = RGB(255, 71, 119);
    
    [self reloadData];
}

#pragma mark - deletage DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    TJTBOrderContentController *vc = [[TJTBOrderContentController alloc]init];
    vc.type = index;
    return vc;
    
}
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//        CGFloat width = [super menuView:menu widthForItemAtIndex:index];
//    return width;
//}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY+65, S_W - 2*leftMargin, 44*H_Scale);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
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
