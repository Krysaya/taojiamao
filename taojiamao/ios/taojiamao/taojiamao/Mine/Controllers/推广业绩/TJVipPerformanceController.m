//
//  TJVipPerformanceController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/22.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJVipPerformanceController.h"

#define VipPopularizeButton  9523

@interface TJVipPerformanceController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)TJLabel * mineBalance;
@property(nonatomic,strong)TJLabel * numBalance;
@property(nonatomic,strong)TJButton * popularize;

@property(nonatomic,strong)UIView * firstView;
@property(nonatomic,strong)TJLabel * leftTop;
@property(nonatomic,strong)TJLabel * leftBottom;
@property(nonatomic,strong)TJLabel * rightTop;
@property(nonatomic,strong)TJLabel * rightBottom;

@property(nonatomic,strong)UIView * orderDetails;
@property(nonatomic,strong)UIImageView * iconImage;
@property(nonatomic,strong)TJLabel * introlabel;
@property(nonatomic,strong)UIImageView*jjImage;

@end

@implementation TJVipPerformanceController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推广业绩";
    [self setUIhead];
    [self setEstimateViews];
}
-(void)setEstimateViews{
    WeakSelf
    self.firstView = [self setUIEstimateView:@"本月预估收入" leftBottom:@"0.00" rightTop:@"上月预估收入" rightBottom:@"0.00"];
    [self.view addSubview:self.firstView];
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.headView.mas_bottom).offset(10);
        make.height.mas_equalTo(105);
    }];
    
    [self setUIorderView];
    
    UIView * second = [self setUIEstimateView:@"今日预估收入" leftBottom:@"0.00" rightTop:@"付款笔数" rightBottom:@"0.00"];
    [self.view addSubview:second];
    [second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.orderDetails.mas_bottom).offset(10);
        make.height.mas_equalTo(105);
    }];
    
    UIView * third = [self setUIEstimateView:@"昨日预估收入" leftBottom:@"0.00" rightTop:@"付款笔数" rightBottom:@"0.00"];
    [self.view addSubview:third];
    [third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(second.mas_bottom).offset(10);
        make.height.mas_equalTo(105);
    }];
}
-(void)setUIorderView{
    WeakSelf
    self.orderDetails = [[UIView alloc]init];
    self.orderDetails.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.orderDetails];
    [self.orderDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.firstView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(50);
    }];
    
    self.iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.orderDetails addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.orderDetails);
        make.left.mas_equalTo(20*W_Scale);
        make.width.height.mas_equalTo(20*W_Scale);
    }];
//
    self.introlabel = [TJLabel setLabelWith:@"订单明细" font:14 color:RGB(51, 51, 51)];
    [self.orderDetails addSubview:self.introlabel];
    [self.introlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.iconImage);
        make.left.mas_equalTo(weakSelf.iconImage.mas_right).offset(6*W_Scale);
    }];
//
    self.jjImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.orderDetails addSubview:self.jjImage];
    [self.jjImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.iconImage);
        make.right.mas_equalTo(-20*W_Scale);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(11);
    }];
}
-(UIView*)setUIEstimateView:(NSString*)lt leftBottom:(NSString*)lb rightTop:(NSString*)rt rightBottom:(NSString*)rb{
    WeakSelf
    UIView * estimateView = [[UIView alloc]init];
    estimateView.backgroundColor = KBGRGB;;
    
    UIView * leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor whiteColor];;
    [estimateView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(estimateView);
        make.width.mas_equalTo(S_W/2-1);
    }];
    
    self.leftTop = [TJLabel setLabelWith:lt font:15 color:RGB(51, 51, 51)];
    [leftView addSubview:self.leftTop];
    [self.leftTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(leftView);
        make.top.mas_equalTo(30);
    }];

    self.leftBottom = [TJLabel setLabelWith:lb font:15 color:RGB(255, 71, 119)];
    [leftView addSubview:self.leftBottom];
    [self.leftBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(leftView);
        make.top.mas_equalTo(weakSelf.leftTop.mas_bottom).offset(15);
    }];
    
    UIView * rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor whiteColor];;
    [estimateView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(estimateView);
        make.width.mas_equalTo(S_W/2-1);
    }];
    
    self.rightTop = [TJLabel setLabelWith:rt font:15 color:RGB(51, 51, 51)];
    [rightView addSubview:self.rightTop];
    [self.rightTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightView);
        make.top.mas_equalTo(30);
    }];

    self.rightBottom = [TJLabel setLabelWith:rb font:15 color:RGB(255, 71, 119)];
    [rightView addSubview:self.rightBottom];
    [self.rightBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightView);
        make.top.mas_equalTo(weakSelf.rightTop.mas_bottom).offset(15);
    }];
    
    return estimateView;
}
-(void)setUIhead{
    WeakSelf
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 95)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    self.mineBalance = [TJLabel setLabelWith:@"我的余额" font:16 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.mineBalance];
    [self.mineBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(20);
    }];
    
    self.numBalance = [TJLabel setLabelWith:@"1546.00" font:30 color:RGB(255, 71, 119)];
    [self.headView addSubview:self.numBalance];
    [self.numBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mineBalance.mas_bottom).offset(12);
        make.left.mas_equalTo(weakSelf.mineBalance);
    }];
    
    self.popularize = [[TJButton alloc]initWith:@"推广赚钱" delegate:self font:15 titleColor:[UIColor whiteColor] backColor:KALLRGB tag:VipPopularizeButton cornerRadius:18];
    [self.headView addSubview:self.popularize];
    [self.popularize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headView);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
    }];
}
-(void)buttonClick:(UIButton *)but{
    DSLog(@"推广");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
