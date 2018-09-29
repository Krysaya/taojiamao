
//
//  TJPublicURL.m
//  taojiamao
//
//  Created by yueyu on 2018/8/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPublicURL.h"
#import "TJHomeSignController.h"//签到
#import "TJNoticeController.h"

#import "TJHomeController.h"//女装--分类
#import "TJClassicController.h"//更多
#import "TJBargainController.h"//9.9
#import "TJProjectController.h"//专题--推荐好货

#import "TJSearchController.h"//搜索

#import "TJHPFindController.h"//发现


/***********会员中心************************************************/
#import "TJMyAssetsController.h"//资产
#import "TJMineOrderController.h"//订单
#import "TJCollectController.h"//收藏
#import "TJMyFootPrintController.h"//   我的足迹
#import "TJVipBalanceController.h"//   累计奖金
#import "TJVipFansController.h"//  我的粉丝
#import "TJVipPerformanceController.h"//   推广业绩
#import "TJMiddleClickController.h"// 热推top
#import "TJCourierTakeController.h"//快递代取
#import "TJKdTabbarController.h"//  快递sh==商户
#import "TJKdHomePageController.h"//商户-首页
#import "TJKdFabuController.h"//发布

#import "TJKdApplyAgrentController.h"//申请代理
#import "TJUpgradeAgentController.h"//升级代理
#import "TJAgentPromoteController.h"//我是代理

#import "TJOrderClaimController.h"//  订单认领
#import "TJRankingListController.h"//   排行榜
#import "TJAssistanceController.h"// 客服帮助
#import "TJTaoBaoGoodsCarController.h"//淘宝购物车
#import "TJMTBOrderController.h"//淘宝订单

#import "TJShareMoneyController.h"//  分享赚钱
//#import "TJInvitationView.h"//    邀请有奖
#import "TJInvitePrizeController.h"//    邀请有奖

//#import "<#header#>"

@implementation TJPublicURL


+(void)goAnyViewController:(UIViewController *)weakSelf withidentif:(NSString *)identifier withParam:(NSString *)param{
    if ([identifier isEqualToString: @"sign"]) {
//        签到
        TJHomeSignController *vc= [[TJHomeSignController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"messageNotification"]) {
        //=====通知
        TJNoticeController *vc= [[TJNoticeController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"recommendGoods"]) {
        //推荐好货
        TJProjectController *vc= [[TJProjectController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"primaryNavigatorDetail"]) {
        //首页--女装
        TJHomeController *vc= [[TJHomeController alloc]init];vc.index = param;
        [weakSelf.navigationController pushViewController:vc animated:YES];}
  
    if ([identifier isEqualToString: @"navigator"]) {//分类
        TJClassicController *vc= [[TJClassicController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];}
     if ([identifier isEqualToString: @"nine"]) {//9.9
        TJBargainController *vc= [[TJBargainController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"findGoods"]) {//9.9
        TJHPFindController *vc= [[TJHPFindController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    
    
    
    
    
    
    
    

     if ([identifier isEqualToString: @"asset"]) {//我的资产
         TJMyAssetsController *vc = [[TJMyAssetsController alloc]init];
         [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"order"]) {// 我的订单
        TJMineOrderController *vc = [[TJMineOrderController alloc]init];
        [TJAppManager sharedTJAppManager].myOrderVC = vc;
        [weakSelf.navigationController pushViewController:vc animated:YES];}
     if ([identifier isEqualToString: @"favorite"]) {//我的收藏
         TJCollectController *vc = [[TJCollectController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
     if ([identifier isEqualToString: @"track"]) {//我的足迹
         TJMyFootPrintController *vc = [[TJMyFootPrintController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    
    
    
     if ([identifier isEqualToString: @"bonus"]) {//累计奖金
         TJVipBalanceController *vc  = [[TJVipBalanceController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"fans"]) {// 我的粉丝
        TJVipFansController *vc = [[TJVipFansController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"memberPerformance"]) {//推广业绩
        TJVipPerformanceController *vc = [[TJVipPerformanceController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"hot"]) {//热推top
        TJMiddleClickController *vc = [[TJMiddleClickController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"takeDelivery"]) {//快递代取
        TJCourierTakeController *vc= [[TJCourierTakeController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"sendDelivery"]) {//发快递
        TJKdFabuController *vc= [[TJKdFabuController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    
    if ([identifier isEqualToString: @"kdMerchants"]) {//、 快递sh==商户
        TJKdTabbarController *tbc = [[TJKdTabbarController alloc]init];
//        tbc.delegate = weakSelf;
        [UIApplication  sharedApplication].keyWindow.rootViewController = tbc;
    }
    
    if ([identifier isEqualToString: @"upgradeforProxy"]) {//==升级代理
        TJUpgradeAgentController *vc = [[TJUpgradeAgentController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"myforProxy"]) {//==我是代理
        TJAgentPromoteController *vc = [[TJAgentPromoteController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"askforProxy"]) {//快递sh==申请代理
        TJKdApplyAgrentController *vc = [[TJKdApplyAgrentController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"orderClaim"]) {//订单认领
        TJOrderClaimController *vc= [[TJOrderClaimController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"makeMoney"]) {//分享赚钱
        TJShareMoneyController *vc= [[TJShareMoneyController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"leaderboard"]) {//排行榜
        TJRankingListController *vc= [[TJRankingListController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"serviceHelp"]) {//客服帮助
        TJAssistanceController *vc= [[TJAssistanceController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    
    if ([identifier isEqualToString: @"taobaoOrder"]) {//淘宝订单
        TJMTBOrderController *vc  = [[TJMTBOrderController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    
    if ([identifier isEqualToString: @"taobaoCar"]) {//购物车
        TJTaoBaoGoodsCarController *vc= [[TJTaoBaoGoodsCarController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];}
    if ([identifier isEqualToString: @"invitation"]) {//邀请有奖
//        TJInvitationView *iview = [TJInvitationView invitationView];
//        iview.frame = CGRectMake(0, 0, S_W, S_H);
//        [[UIApplication sharedApplication].keyWindow addSubview:iview];
        TJInvitePrizeController *vc= [[TJInvitePrizeController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }
    
}

//+(void)goAnyViewController:(UIViewController *)weakSelf withidentif:(NSString *)identifier withParam:(NSString *)param{
//    if ([identifier isEqualToString: @"asset"]) {//搜索
//        TJSearchController *vc= [[TJSearchController alloc]init];
//        vc.searchText = param;
//        [weakSelf.navigationController pushViewController:vc animated:YES];}
//    if ([identifier isEqualToString: @"primaryNavigatorDetail"]) {
//        //首页--女装
//        TJHomeController *vc= [[TJHomeController alloc]init];
//        vc.index = param;
//        [weakSelf.navigationController pushViewController:vc animated:YES];}
//
//}
@end
