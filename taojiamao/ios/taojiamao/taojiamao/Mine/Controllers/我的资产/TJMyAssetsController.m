
//
//  TJMyAssetsController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMyAssetsController.h"
#import "TJAssetsDetailController.h"
#import "TJDrawMoneyController.h"
#import "TJJFBExchangeController.h"
@interface TJMyAssetsController ()<TJButtonDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UILabel *lab_wdjfb;
@property (weak, nonatomic) IBOutlet UILabel *lab_zsjfb;
@property (weak, nonatomic) IBOutlet UILabel *lab_dhjfb;

@end

@implementation TJMyAssetsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = KBGRGB;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}
-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资产";
    
    TJButton *right = [[TJButton alloc]initWith:@"明细" delegate:self font:15 titleColor:RGB(51, 51, 51) backColor:nil tag:1289];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

- (IBAction)withdrawalClick:(UIButton *)sender {
//    提现
    TJDrawMoneyController *vc = [[TJDrawMoneyController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)exchangeClick:(UIButton *)sender {
// 兑换集分宝
    TJJFBExchangeController *vc = [[TJJFBExchangeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buttonClick:(UIButton *)but
{
    TJAssetsDetailController *vc = [[TJAssetsDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
