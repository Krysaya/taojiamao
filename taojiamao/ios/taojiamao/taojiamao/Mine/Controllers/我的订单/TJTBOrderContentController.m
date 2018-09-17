
//
//  TJTBOrderContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTBOrderContentController.h"
#import "TJTBOrderInfoController.h"
#import "TJTBOrderContentCell.h"
#import "TJTabBarController.h"
#import "TJTaoBaoOrderModel.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibcTradeSDK/AlibcTradePageFactory.h>
#import <AlibcTradeSDK/AlibcTradeService.h>
static NSString * const TBOrderContentCell = @"TBOrderContentCell";

@interface TJTBOrderContentController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJTBOrderContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    DSLog(@"--%@--nav",self.navigationController);

    [self  requestTaoBaoOrder:self.type];
    [self setTableViewUI];
//    [self openTaoBaoOrderWithStatus:self.type];
}
//- (void)openTaoBaoOrderWithStatus:(NSInteger )status{
//
//    UIWebView *webV = [[UIWebView alloc]initWithFrame:S_F];
//    [self.view addSubview:webV];
//    //打开我的订单页
//    id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:status isAllOrder:YES];
//    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
//    showParam.openType = AlibcOpenTypeH5;
//    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[AlibcTradeSDK sharedInstance].tradeService show:self webView:webV page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
//
//        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
//
//        }];
//    });
//
//}

- (void)requestTaoBaoOrder:(NSString *)type{
    NSString *status;
    if ([type intValue]==0) {
        status = @"0";
    }
    if ([type intValue]==1) {
        status = @"3";
    } if ([type intValue]==2) {
        status = @"14";
    }
    self.dataArr = [NSMutableArray array];
    WeakSelf
    [KConnectWorking requestNormalDataParam:@{@"status":status,} withRequestURL:MyOrderList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
//        DSLog(@"-------orderre----%@",responseObject);
        weakSelf.dataArr = [TJTaoBaoOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        if (weakSelf.dataArr.count>0) {
        }else{
            weakSelf.tableView.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"nolist"]];
        }
        [weakSelf.tableView reloadData];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)setTableViewUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight-44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TJTBOrderContentCell class] forCellReuseIdentifier:TBOrderContentCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
    //    }
    TJTBOrderContentCell * cell = [tableView dequeueReusableCellWithIdentifier:TBOrderContentCell forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DSLog(@"dianle");
    TJTBOrderInfoController *avc = [[TJTBOrderInfoController alloc]init];
//    TJTaoBaoOrderModel *model = self.dataArr[indexPath.section];
//    avc.gid = model.id;
    UIViewController *order = (UIViewController *)[TJAppManager sharedTJAppManager].myOrderVC;
    [order.navigationController pushViewController:avc animated:NO];
}
- (UIViewController *)currentViewController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[TJNavigationController class]])
        {
            vc = [(TJNavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[TJTabBarController class]])
        {
            vc = [(TJTabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 172;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
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
