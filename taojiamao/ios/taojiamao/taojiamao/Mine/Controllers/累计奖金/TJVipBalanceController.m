//
//  TJVipBalanceController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/22.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJVipBalanceController.h"
#import "TJBalanceDetailsController.h"
#import "TJDrawMoneyController.h"

#define BalanceDetailsButton  3571
#define VipDrawMoneyButton    3572

@interface TJVipBalanceController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)TJLabel * intro;
@property(nonatomic,strong)TJLabel * BalanceNum;

@property(nonatomic,strong)UIView * middleView;
@property(nonatomic,strong)TJButton * balanceDetails;
@property(nonatomic,strong)TJButton * drawMoney;

@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)TJLabel * leftLabel;
@property(nonatomic,strong)TJLabel * numLabel;
@property(nonatomic,strong)TJLabel * rightLabel;

@end

@implementation TJVipBalanceController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"0.0";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户余额";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    
    DSLog(@"%@",self.balance);
    
    [self setUIhead];
    [self setUImiddle];
    [self setUIfoot];
}
-(void)setUIfoot{
    WeakSelf
    self.footView =[[UIView alloc]init];
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.middleView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(47);
    }];
    
    self.leftLabel = [TJLabel setLabelWith:@"您已累计获得奖励" font:14 color:RGB(51, 51, 51)];
    [self.footView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.centerY.mas_equalTo(weakSelf.footView);
    }];
    
    self.rightLabel = [TJLabel setLabelWith:@"集分宝" font:14 color:RGB(51, 51, 51)];
    [self.footView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.centerY.mas_equalTo(weakSelf.footView);
    }];
    
    self.numLabel = [TJLabel setLabelWith:@"1000" font:14 color:KALLRGB];
    [self.footView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.rightLabel.mas_left);
        make.centerY.mas_equalTo(weakSelf.footView);
    }];
    
}
-(void)setUImiddle{
    WeakSelf
    self.middleView = [[UIView alloc]init];
    self.middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headView.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.headView);
        make.height.mas_equalTo(95);
    }];
    
    self.balanceDetails = [[TJButton alloc]initWith:@"余额明细" delegate:self font:15 titleColor:KALLRGB backColor:[UIColor whiteColor] tag:BalanceDetailsButton cornerRadius:18 borderColor:[UIColor redColor] borderWidth:1.0 withBackImage:nil withSelectImage:nil];
    [self.middleView addSubview:self.balanceDetails];
    [self.balanceDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.middleView);
        make.left.mas_equalTo(40);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
    }];
    
    self.drawMoney = [[TJButton alloc]initWith:@"提现" delegate:self font:15 titleColor:[UIColor whiteColor] backColor:KALLRGB tag:VipDrawMoneyButton cornerRadius:18];
    [self.middleView addSubview:self.drawMoney];
    [self.drawMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.middleView);
        make.right.mas_equalTo(-40);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
    }];
    
}
-(void)setUIhead{
    WeakSelf
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 120+SafeAreaTopHeight)];
    self.headView.backgroundColor = KALLRGB;
    [self.view addSubview:self.headView];
    
    self.intro = [TJLabel setLabelWith:@"可用余额 0（元）" font:15 color:[UIColor whiteColor]];
    [self.headView addSubview:self.intro];
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.headView);
        make.top.mas_equalTo(28+SafeAreaTopHeight);
    }];
    
    self.BalanceNum =[TJLabel setLabelWith:self.balance font:40 color:[UIColor whiteColor]];
    [self.headView addSubview:self.BalanceNum];
    [self.BalanceNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.intro);
        make.top.mas_equalTo(weakSelf.intro.mas_bottom).offset(18);
    }];
}
-(void)buttonClick:(UIButton *)but{
    if (but.tag==BalanceDetailsButton) {
        TJBalanceDetailsController * bdvc = [[TJBalanceDetailsController alloc]init];
        bdvc.title = @"余额明细";
        [self.navigationController pushViewController:bdvc animated:YES];
    }else{
        TJDrawMoneyController * dmvc = [[TJDrawMoneyController alloc]init];
        dmvc.moneyNum = self.balance;
        [self.navigationController pushViewController:dmvc animated:YES];
    }
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
