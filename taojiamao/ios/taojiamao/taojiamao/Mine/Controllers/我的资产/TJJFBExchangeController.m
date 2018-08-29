//
//  TJJFBExchangeController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJJFBExchangeController.h"
#import "TJBalanceDetailsController.h"

#define ECTXButton  74109

@interface TJJFBExchangeController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)TJLabel * intro;
@property(nonatomic,strong)TJLabel * number;

@property(nonatomic,strong)UIView * numView;
@property(nonatomic,strong)TJLabel * inputNum;
@property(nonatomic,strong)TJTextField * textField;

@property(nonatomic,strong)TJButton * exchangeButton;

@property(nonatomic,strong)UIView * footIntro;
@property(nonatomic,strong)TJLabel * reminder;
@property(nonatomic,strong)TJLabel * remIntro;
@end

@implementation TJJFBExchangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBGRGB;
    self.title = @"兑换集分";
    [self setNavRightItem];
    [self setUIhead];
    [self setInputView];
    [self setExchangeButtons];
    [self setUIfoot];
}
-(void)setUIhead{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 95*H_Scale)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    WeakSelf
    self.iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"exchange"]];
    [self.headView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headView);
        make.left.mas_equalTo(20*W_Scale);
        make.width.height.mas_equalTo(60*W_Scale);
    }];
    
    self.intro = [TJLabel setLabelWith:@"可兑换集分(个)" font:16*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.intro];
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.iconView);
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(18*W_Scale);
    }];
    
    self.number = [TJLabel setLabelWith:self.exchangeNum font:30*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.intro.mas_bottom).offset(13*H_Scale);
        make.left.mas_equalTo(weakSelf.intro);
    }];
    
}

-(void)setInputView{
    WeakSelf
    self.numView = [[UIView alloc]init];
    self.numView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.numView];
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headView.mas_bottom).offset(10*H_Scale);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(49*H_Scale);
    }];
    
    self.inputNum = [TJLabel setLabelWith:@"输入数量" font:15 color:RGB(51, 51, 51)];
    [self.numView addSubview:self.inputNum];
    [self.inputNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.numView);
        make.left.mas_equalTo(20*W_Scale);
    }];
    
    self.textField = [TJTextField setTextFieldWith:@"请输入想兑换的数量" font:15 textColor:RGB(51, 51, 51) backColor:nil];
    [self.numView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.numView);
        make.left.mas_equalTo(weakSelf.inputNum.mas_right).offset(30*W_Scale);
    }];
}
-(void)setExchangeButtons{
    WeakSelf
    self.exchangeButton =[[TJButton alloc] initWith:@"兑换" delegate:self font:17 titleColor:[UIColor whiteColor] backColor:KALLRGB tag:ECTXButton cornerRadius:20];
    [self.view addSubview:self.exchangeButton];
    [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.numView.mas_bottom).offset(40*H_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}
-(void)setUIfoot{
    WeakSelf
    self.footIntro = [[UIView alloc]init];
    self.footIntro.layer.cornerRadius = 15;
    self.footIntro.layer.masksToBounds = YES;
    self.footIntro.backgroundColor =KBGRGB;
    [self.view addSubview:self.footIntro];
    [self.footIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.exchangeButton.mas_bottom).offset(40*H_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(330*W_Scale);
        make.height.mas_equalTo(100*H_Scale);
    }];
    
    self.reminder = [TJLabel setLabelWith:@"小提示:" font:15 color:RGB(51, 51, 51)];
    [self.footIntro addSubview:self.reminder];
    [self.reminder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(20*W_Scale);
    }];
    self.remIntro = [TJLabel setLabelWith:@"集分可以通过邀请好友、分享商品、参与平台活动、抽奖以及通过任务获得，100集分=1元" font:13 color:RGB(51, 51, 51)];
    self.remIntro.numberOfLines = 0;
    [self.footIntro addSubview:self.remIntro];
    [self.remIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.reminder);
        make.top.mas_equalTo(weakSelf.reminder.mas_bottom).offset(10);
        make.width.mas_equalTo(280*W_Scale);
    }];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self addBorderToLayer:self.footIntro];
}
-(void)setNavRightItem{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"兑换记录" forState:UIControlStateNormal];
    [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13*W_Scale];
    [button addTarget:self action:@selector(recordClick) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
-(void)recordClick{
    DSLog(@"兑换记录");
    TJBalanceDetailsController * bdvc = [[TJBalanceDetailsController alloc]init];
    bdvc.title = @"兑换记录";
    [self.navigationController pushViewController:bdvc animated:YES];
}
-(void)buttonClick:(UIButton *)but{
    DSLog(@"兑换");
    NSInteger max = [self.exchangeNum integerValue];
    if ([TJOverallJudge judgeNumInputShouldNumber:self.textField.text]) {
        NSInteger input  = [self.textField.text integerValue];
        
        if (max>=input) {
           
           
        }else{
            DSLog(@"数量超出了");
            [SVProgressHUD showInfoWithStatus:@"集分不足！"];
            
        }
    }else{
        DSLog(@"含有非数字");
        [SVProgressHUD showInfoWithStatus:@"非法输入！"];
    
    }
}

- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
  
    border.strokeColor = [UIColor redColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:15].CGPath;
    
    border.frame = view.bounds;
   
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @3];
    
    [view.layer addSublayer:border];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
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
