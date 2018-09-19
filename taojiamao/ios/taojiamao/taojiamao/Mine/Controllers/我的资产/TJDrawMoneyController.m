//
//  TJDrawMoneyController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJDrawMoneyController.h"
#import "TJBalanceDetailsController.h"
#import "TJPersonalController.h"
#import "TJUserDataModel.h"
#define MarginLR  20*W_Scale

@interface TJDrawMoneyController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)TJLabel * intro;
@property(nonatomic,strong)TJLabel * number;

@property(nonatomic,strong)UIView * alipayView;
@property(nonatomic,strong)TJLabel * realName;
@property(nonatomic,strong)TJLabel * name;
@property(nonatomic,strong)UIView * line;
@property(nonatomic,strong)TJLabel * zfbAccount;
@property(nonatomic,strong)TJLabel * account;

@property(nonatomic,strong)UIView * inputView;
@property(nonatomic,strong)TJLabel * explain;
@property(nonatomic,strong)TJLabel * symbol;
@property(nonatomic,strong)TJTextField * input;
@property(nonatomic,copy)NSString * min;

@property(nonatomic,strong)TJButton * exchangeButton;

@end

@implementation TJDrawMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf
    [KConnectWorking requestNormalDataParam:nil withRequestURL:MembersBalance withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        weakSelf.min = responseObject[@"data"][@"min_money"];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
    self.title = @"余额提现";
    [self setNavRightItem];
    [self setUIhead];
    [self setUIalipayView];
    [self setUIinputView];
    [self setExchangeButtons];
    
    NSString *aliname = GetUserDefaults(Ali_name);
    NSString *aliaccount = GetUserDefaults(Ali_account);

    if (!aliname) {
        self.name.text = @"";
        [SVProgressHUD showInfoWithStatus:@"未绑定，先去绑定"];

    }else{
        self.name.text = aliname;
        self.account.text = aliaccount;

    }
    
    self.explain.text = [NSString stringWithFormat:@"可提现金额%@(元)",self.moneyNum];
}
-(void)setExchangeButtons{
    WeakSelf
    
    if ([self.type_tx intValue]==0) {
 self.exchangeButton =[[TJButton alloc] initWith:@"提现" delegate:self font:17 titleColor:[UIColor whiteColor] backColor:KALLRGB tag:123 cornerRadius:20];        self.iconView.image = [UIImage imageNamed:@"balance"];
    }else{
 self.exchangeButton =[[TJButton alloc] initWith:@"提现" delegate:self font:17 titleColor:[UIColor whiteColor] backColor:KKDRGB tag:123 cornerRadius:20];        self.iconView.image = [UIImage imageNamed:@"kd_money_m"];
        
    }
    
    
    [self.view addSubview:self.exchangeButton];
    [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.input.mas_bottom).offset(40);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(S_W-40);
        make.height.mas_equalTo(40);
    }];
}
-(void)buttonClick:(UIButton *)but{
    
//    if (self.input.text.length<=0) return;
    if ([TJOverallJudge judgeNumInputShouldNumber:self.input.text]) {
        NSInteger num = [self.input.text integerValue];
        NSInteger max = [self.moneyNum integerValue];
        NSInteger min = [self.min integerValue];
        if (num>max || num<min) {
            DSLog(@"数额不正确");
        }else{
            DSLog(@"提现喽");

        [KConnectWorking requestNormalDataParam:@{@"type":@"1",@"balance":self.input.text,} withRequestURL:UserBalanceTiXian withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
            //            DSLog(@"---%@---tixian---",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"申请提现成功，请耐心等待3~5工作日到账！"];
//            TJPersonalController *vc = [[TJPersonalController alloc]init];
            [self.navigationController popViewControllerAnimated:NO];
            //            [];
        } withFailure:^(NSError * _Nullable error) {
            NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSString  * receive = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding ];
            
            //字符串再生成NSData
            NSData *data = [receive dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            //打印出后台给出的错误信息
            DSLog(@"---%@---tixian---",dict[@"msg"]);
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }];
    }
      
    }else{
        [SVProgressHUD showErrorWithStatus:@"格式不正确"];
        
    }
}
-(void)setUIinputView{
    WeakSelf
    self.inputView = [[UIView alloc]init];
    self.inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.alipayView.mas_bottom).offset(10);
        make.height.mas_equalTo(105*H_Scale);
    }];
    
    self.explain = [TJLabel setLabelWith:@"提现金额(元)" font:15 color:RGB(51, 51, 51)];
    [self.inputView addSubview:self.explain];
    [self.explain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MarginLR);
        make.top.mas_equalTo(35);
//        make.centerY.mas_equalTo();
    }];
    
    self.symbol = [TJLabel setLabelWith:@"￥" font:27 color:RGB(51, 51, 51)];
    [self.inputView addSubview:self.symbol];
    [self.symbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MarginLR);
        make.top.mas_equalTo(weakSelf.explain.mas_bottom).offset(15);
    }];
    
    self.input = [TJTextField setTextFieldWith:[NSString stringWithFormat:@"每次提现金额不得少于%@元",self.min] textFont:25 textColor:RGB(151, 151, 151) backColor:nil placeholderFont:13];
    self.input.keyboardType = UIKeyboardTypePhonePad;
    [self.inputView addSubview:self.input];
    [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.symbol.mas_right).offset(19);
        make.centerY.mas_equalTo(weakSelf.symbol);
        make.width.mas_equalTo(288);
        make.height.mas_equalTo(41);
    }];
}
-(void)setUIalipayView{
    WeakSelf
    self.alipayView = [[UIView alloc]init];
    self.alipayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.alipayView];
    [self.alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.headView.mas_bottom).offset(10);
        make.height.mas_equalTo(98*H_Scale);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = KBGRGB;
    [self.alipayView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.alipayView);
        make.left.mas_equalTo(MarginLR);
        make.right.mas_equalTo(-MarginLR);
        make.height.mas_equalTo(1);
    }];
    
    self.realName = [TJLabel setLabelWith:@"真实姓名" font:15 color:RGB(51, 51, 51)];
    CGSize size =[@"真实姓名" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGFloat H = size.height;
    [self.alipayView addSubview:self.realName];
    [self.realName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MarginLR);
        make.top.mas_equalTo((49*H_Scale-H)*0.5);
    }];
    
    self.name = [TJLabel setLabelWith:@" " font:15 color:RGB(51, 51, 51)];
    [self.alipayView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.realName.mas_right).offset(30*W_Scale);
        make.centerY.mas_equalTo(weakSelf.realName);
    }];
    
    self.zfbAccount =[TJLabel setLabelWith:@"支付宝账号" font:15 color:RGB(51, 51, 51)];
    [self.alipayView addSubview:self.zfbAccount];
    [self.zfbAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MarginLR);
        make.top.mas_equalTo(weakSelf.line.mas_bottom).offset((49*H_Scale-H)*0.5);
    }];
    
    self.account = [TJLabel setLabelWith:@" " font:15 color:RGB(51, 51, 51)];
    [self.alipayView addSubview:self.account];
    [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.name);
        make.centerY.mas_equalTo(weakSelf.zfbAccount);
    }];
}
-(void)setUIhead{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 95*H_Scale)];
    self.headView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    WeakSelf
    self.iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"balance"]];
    [self.headView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headView);
        make.left.mas_equalTo(MarginLR);
        make.width.height.mas_equalTo(60*W_Scale);
    }];
    
    self.intro = [TJLabel setLabelWith:@"可提现余额(元)" font:16*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.intro];
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.iconView);
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(18*W_Scale);
    }];
    
    self.number = [TJLabel setLabelWith:self.moneyNum font:30*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.intro.mas_bottom).offset(13*H_Scale);
        make.left.mas_equalTo(weakSelf.intro);
    }];
    
}
-(void)setNavRightItem{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"提现记录" forState:UIControlStateNormal];
    [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13*W_Scale];
    [button addTarget:self action:@selector(recordClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
-(void)recordClick{

    TJBalanceDetailsController * bdvc = [[TJBalanceDetailsController alloc]init];
    bdvc.title = @"提现记录";
    bdvc.tx_type = self.type_tx;
    [self.navigationController pushViewController:bdvc animated:YES];
}
-(void)dealloc{
//    DSLog(@"%s",__FUNCTION__);
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
