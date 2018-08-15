
//
//  TJKdUserCenterController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//  快递--个人中心

#import "TJKdUserCenterController.h"
#import "TJKdMineHeadCell.h"
#import "TJKdMineClassicCell.h"
#import "TJKdMineMiddleCell.h"
#import "TJKdMineDefaultCell.h"

#import "TJKdMyMoneyController.h"
#import "TJKdMyTeamController.h"
#import "TKdMyOrderController.h"

#import "TJKdMyOpintionMyController.h"//意见

#import "TJTabBarController.h"

#define BackTag  4564


@interface TJKdUserCenterController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,SelectCellDelegate>

@end

@implementation TJKdUserCenterController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGB(81, 162, 249);
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBGRGB;

    TJButton *btn_left = [[TJButton alloc]initDelegate:self backColor:nil tag:BackTag withBackImage:@"kd_left_white" withSelectImage:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = KBGRGB;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJKdMineHeadCell" bundle:nil] forCellReuseIdentifier:@"KdMineHeadCell"];
    [tableView registerClass:[TJKdMineClassicCell class] forCellReuseIdentifier:@"KdMineClassicCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJKdMineMiddleCell" bundle:nil] forCellReuseIdentifier:@"KdMineMiddleCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJKdMineDefaultCell" bundle:nil] forCellReuseIdentifier:@"KdMineDefaultCell"];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buttonClick:(UIButton *)but{
    //    back
    TJTabBarController *tbs = [[TJTabBarController alloc]init];
    [UIApplication  sharedApplication].keyWindow.rootViewController = tbs;
}


#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        TJKdMineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMineHeadCell"];
        return cell;
    }else if (indexPath.row==1){
        TJKdMineClassicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMineClassicCell"];
        cell.mineCellDelegate = self;
        return cell;
    }else if (indexPath.row==2){
        TJKdMineMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMineMiddleCell"];
        return cell;
    }else{
        TJKdMineDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMineDefaultCell"];
        cell.type = [NSString stringWithFormat:@"%ld",indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 110;
    }else if (indexPath.row==1){
        return 80;
    }else if (indexPath.row==2){
        return 165;
    }else{
        return 49;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
//        邀请好友
    }else if (indexPath.row==4){
//        客服中心
    }else if (indexPath.row==5){
//        意见反馈
        TJKdMyOpintionMyController *vc = [[TJKdMyOpintionMyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - middleCellDelegate
- (void)collectionCell:(TJKdMineClassicCell *)cell didSelectItemIndexPath:(NSIndexPath *)indexPath{
    DSLog(@"qianbao===%ld",indexPath.row);

    switch (indexPath.row) {
        case 0:
        {
//            我的钱包
            DSLog(@"qianbao");
            TJKdMyMoneyController *vc = [[TJKdMyMoneyController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//全部订单
            DSLog(@"order");

            TKdMyOrderController *vc = [[TKdMyOrderController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break; case 2:
        {
//我的团队
            TJKdMyTeamController *vc = [[TJKdMyTeamController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break; case 3:
        {
//新手教程
        }
            break;
        default:
            break;
    }
}
@end
