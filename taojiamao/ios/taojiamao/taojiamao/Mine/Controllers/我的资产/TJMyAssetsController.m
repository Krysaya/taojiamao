
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
#import "TJUserDataModel.h"
@interface TJMyAssetsController ()<TJButtonDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UILabel *lab_wdjfb;
@property (weak, nonatomic) IBOutlet UILabel *lab_zsjfb;
@property (weak, nonatomic) IBOutlet UILabel *lab_dhjfb;
@property (weak, nonatomic) IBOutlet UIButton *btn_ti;
@property (weak, nonatomic) IBOutlet UILabel *lab_min;

@property (nonatomic, strong) NSString *minstr;
@end

@implementation TJMyAssetsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = KBGRGB;

}
-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资产";
    WeakSelf
    [KConnectWorking requestNormalDataParam:nil withRequestURL:MembersBalance withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        weakSelf.minstr = responseObject[@"data"][@"min_money"];
        weakSelf.lab_min.text = [NSString stringWithFormat:@"每次提现金额不得少于%@元",weakSelf.minstr];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
    TJUserDataModel *model = [TJAppManager sharedTJAppManager].userData;
    if ([model.is_ti intValue]==0) {
        [self.btn_ti setTitle:@"提现" forState:UIControlStateNormal];
        [self.btn_ti setBackgroundColor:KALLRGB];
        self.btn_ti.userInteractionEnabled = YES;
    }else{
        self.btn_ti.userInteractionEnabled = NO;
        [self.btn_ti setTitle:@"提现审核中" forState:UIControlStateNormal];
        [self.btn_ti setBackgroundColor:RGB(151, 151, 151)];
    }
    NSString *str = [NSString stringWithFormat:@"%@",model.balance];
    CGFloat i = [str floatValue]/100;
    NSString *money = [NSString stringWithFormat:@"%.2f",i];
    self.lab_money.text = money;
    TJButton *right = [[TJButton alloc]initWith:@"明细" delegate:self font:15 titleColor:RGB(51, 51, 51) backColor:nil tag:1289];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

- (IBAction)withdrawalClick:(UIButton *)sender {
//    提现
    TJDrawMoneyController *vc = [[TJDrawMoneyController alloc]init];
    vc.moneyNum = self.lab_money.text;
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
    vc.type_mx = @"put";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
