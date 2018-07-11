//
//  TJMineAssetDetailsController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMineAssetDetailsController.h"
#import "TJBalanceDetailsController.h"
#import "TJJFBExchangeController.h"
#import "TJDrawMoneyController.h"

#define DrawMoneyButton 3366
#define ExchangeButton  6633

@interface TJMineAssetDetailsController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
//现金subView
@property(nonatomic,strong)UILabel * intro;
@property(nonatomic,strong)UILabel * number;
@property(nonatomic,strong)UILabel * reminder;
@property(nonatomic,strong)TJButton * drawMoney;
//集分subView
@property(nonatomic,strong)UILabel * mineJF;
@property(nonatomic,strong)UILabel * mineJFNum;
@property(nonatomic,strong)UILabel * giveJF;
@property(nonatomic,strong)UILabel * giveJFNum;
@property(nonatomic,strong)UILabel * exchangeJF;
@property(nonatomic,strong)UILabel * exchangeJFNum;
@property(nonatomic,strong)UILabel * reminderJF;
@property(nonatomic,strong)TJButton * exchange;

@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UILabel * modeDetails;
@property(nonatomic,strong)UIImageView*jj;
@end

@implementation TJMineAssetDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeadFootView];
    if (self.index) {
        DSLog(@"集分宝");
        [self JFSubViews];
    }else{
        DSLog(@"现金");
        [self drawMoneySubViews];
    }
    [self setFootViewSubViews];
}
-(void)JFSubViews{
    WeakSelf
    self.mineJF = [self setLabelWith:@"我的集分" font:15 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.mineJF];
    [self.mineJF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(48*H_Scale);
        make.left.mas_equalTo(30*W_Scale);
    }];
    
    self.giveJF = [self setLabelWith:@"赠送集分" font:15 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.giveJF];
    [self.giveJF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mineJF);
        make.left.mas_equalTo(weakSelf.mineJF.mas_right).offset(46*W_Scale);
    }];

    self.exchangeJF = [self setLabelWith:@"可兑换集分" font:15 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.exchangeJF];
    [self.exchangeJF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mineJF);
        make.left.mas_equalTo(weakSelf.giveJF.mas_right).offset(46*W_Scale);
    }];
    
    self.mineJFNum = [self setLabelWith:@"" font:17 color:RGB(255, 72, 120)];
    self.mineJFNum.text = self.model.money.length>0?self.model.money:@"0";
    [self.headView addSubview:self.mineJFNum];
    [self.mineJFNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mineJF.mas_bottom).offset(20*H_Scale);
        make.centerX.mas_equalTo(weakSelf.mineJF);
    }];
    
    self.giveJFNum = [self setLabelWith:@"" font:17 color:RGB(255, 72, 120)];
    self.giveJFNum.text = self.model.reward_money.length>0?self.model.reward_money:@"0";
    [self.headView addSubview:self.giveJFNum];
    [self.giveJFNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mineJFNum);
        make.centerX.mas_equalTo(weakSelf.giveJF);
    }];
    
    self.exchangeJFNum = [self setLabelWith:@"" font:17 color:RGB(255, 72, 120)];
    self.exchangeJFNum.text = self.model.total.length>0?self.model.total:@"0";
    [self.headView addSubview:self.exchangeJFNum];
    [self.exchangeJFNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mineJFNum);
        make.centerX.mas_equalTo(weakSelf.exchangeJF);
    }];
    
    self.reminderJF = [self setLabelWith:@"每兑换10集分=我的集分7+赠送集分3" font:12 color:RGB(128, 128, 128)];
    [self.headView addSubview:self.reminderJF];
    [self.reminderJF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.giveJFNum.mas_bottom).offset(50*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
    }];
    
    self.exchange =[[TJButton alloc]initWith:@"兑换" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:ExchangeButton cornerRadius:20.0];
    [self.headView addSubview:self.exchange];
    [self.exchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.headView);
        make.top.mas_equalTo(weakSelf.reminderJF.mas_bottom).offset(13*H_Scale);
        make.height.mas_equalTo(40*H_Scale);
        make.width.mas_equalTo(263*W_Scale);
    }];
}
-(void)drawMoneySubViews{
    WeakSelf
    self.intro = [self setLabelWith:@"我的余额(元)" font:15 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.intro];
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
    }];
    
    self.number = [self setLabelWith:@"1546.00" font:40 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.intro.mas_bottom).offset(19*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
    }];
    
    self.reminder = [self setLabelWith:@"每次提现金额不得少于30元" font:12 color:RGB(128, 128, 128)];
    [self.headView addSubview:self.reminder];
    [self.reminder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.number.mas_bottom).offset(44*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
    }];
    
    self.drawMoney =[[TJButton alloc]initWith:@"提现" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:DrawMoneyButton cornerRadius:20.0];
    [self.headView addSubview:self.drawMoney];
    [self.drawMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.headView);
        make.top.mas_equalTo(weakSelf.reminder.mas_bottom).offset(13*H_Scale);
        make.height.mas_equalTo(40*H_Scale);
        make.width.mas_equalTo(263*W_Scale);
    }];
}
-(void)setHeadFootView{
    WeakSelf
    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = RandomColor;
    [self.view addSubview:self.headView];
    self.headView.layer.cornerRadius = 10;
    self.headView.layer.masksToBounds = YES;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(339*W_Scale);
        make.height.mas_equalTo(250*H_Scale);
    }];
    
    self.footView = [[UIView alloc]init];
    self.footView.backgroundColor = RandomColor;
    self.footView.layer.cornerRadius = 5;
    self.footView.layer.masksToBounds = YES;
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headView.mas_bottom).offset(25*H_Scale);
        make.width.centerX.mas_equalTo(weakSelf.headView);
        make.height.mas_equalTo(47*H_Scale);
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(footViewClick)];
    [self.footView addGestureRecognizer:tap];
}
-(void)setFootViewSubViews{
    WeakSelf
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.footView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25*W_Scale);
        make.centerY.mas_equalTo(weakSelf.footView);
        make.width.mas_equalTo(17*W_Scale);
        make.height.mas_equalTo(18*H_Scale);
    }];
    
    self.modeDetails  = [self setLabelWith:@"" font:14 color:RGB(77, 77, 77)];
    self.modeDetails.text = self.index?@"集分明细":@"余额明细";
    [self.footView addSubview:self.modeDetails];
    [self.modeDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footView);
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(18*W_Scale);
    }];
    
    self.jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.footView addSubview:self.jj];
    [self.jj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footView);
        make.right.mas_equalTo(-20*W_Scale);
        make.width.mas_equalTo(6*W_Scale);
        make.height.mas_equalTo(11*H_Scale);
    }];
}
-(void)buttonClick:(UIButton *)but{
    if (but.tag==DrawMoneyButton) {
        TJDrawMoneyController * dmvc =[[TJDrawMoneyController alloc]init];
        dmvc.moneyNum = self.number.text;//
        [self.navigationController pushViewController:dmvc animated:YES];
    }else{
        TJJFBExchangeController * jfbevc = [[TJJFBExchangeController alloc]init];
        jfbevc.exchangeNum = self.model.total;
        [self.navigationController pushViewController:jfbevc animated:YES];
    }
}
-(void)footViewClick{
    if (self.index==0) {
        DSLog(@"余额明细");
        TJBalanceDetailsController * bdvc = [[TJBalanceDetailsController alloc]init];
        bdvc.title = @"余额明细";
        [self.navigationController pushViewController:bdvc animated:YES];
    }else{
        DSLog(@"集分明细");
        TJBalanceDetailsController * bdvc = [[TJBalanceDetailsController alloc]init];
        bdvc.title = @"集分明细";
        [self.navigationController pushViewController:bdvc animated:YES];
    }
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}

-(void)dealloc{
    DSLog(@"%s",__func__);
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
