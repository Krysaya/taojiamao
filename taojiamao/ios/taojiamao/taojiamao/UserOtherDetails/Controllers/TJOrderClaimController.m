//
//  TJOrderClaimController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/10.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderClaimController.h"
#import "TJOrderClaimDetailsController.h"

#define  ClaimOrderButton  58552299

@interface TJOrderClaimController ()<TJButtonDelegate>

@property(nonatomic,strong)UILabel * titleL;
@property(nonatomic,strong)UILabel * introL;
@property(nonatomic,strong)UIView * claimView;
@property(nonatomic,strong)UILabel * claimL;
@property(nonatomic,strong)UITextField * claimF;
@property(nonatomic,strong)TJButton * sure;
@end

@implementation TJOrderClaimController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.title = self.changeNick?@"修改昵称":@"订单认领";
    [self setUI];
    if (self.changeNick) return;
    [self setNavRightItem];
}

-(void)setUI{
    _titleL = [self setLabelWith:@"丢单？认领找回订单" font:15*W_Scale color:RGB(51, 51, 51)];
    _titleL.hidden = self.changeNick;
    [self.view addSubview:_titleL];
    
    _introL = [self setLabelWith:@"订单付款后，需要等待5-10分钟才能看到相关信息哦" font:13*W_Scale color:RGB(77, 77, 77)];
    _introL.hidden = self.changeNick;
    [self.view addSubview:_introL];
    
    _claimView = [[UIView alloc]init];
    _claimView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_claimView];
    _claimL = [self setLabelWith:@"" font:15*W_Scale color:RGB(51, 51, 51)];
    [_claimView addSubview:_claimL];
    _claimF = [[UITextField alloc]init];
    _claimF.textColor = RGB(217, 217, 217);
    _claimF.font = [UIFont systemFontOfSize:15*W_Scale];
    if (self.changeNick) {
        _claimL.text = @"修改昵称";
        _claimF.placeholder = @"请输入新的昵称";
    }else{
        _claimL.text = @"订单认领";
        _claimF.placeholder = @"请输入订单号";
    }
    [_claimView addSubview:_claimF];
    
    _sure = [[TJButton alloc]initWith:@"确定" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:KALLRGB tag:ClaimOrderButton cornerRadius:20.0];;
    [self.view addSubview:_sure];
    
    WeakSelf
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35*H_Scale+SafeAreaTopHeight);
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    [_introL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleL.mas_bottom).offset(15*H_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    if (self.changeNick) {
        [_claimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10*H_Scale+SafeAreaTopHeight);
            make.left.right.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(49*H_Scale);
        }];
    }else{
        [_claimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.introL.mas_bottom).offset(30*H_Scale);
            make.left.right.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(49*H_Scale);
        }];
    }
    
    [_claimL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.claimView);
        make.left.mas_equalTo(20*W_Scale);
    }];
    
    [_claimF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.claimL.mas_right).offset(16*W_Scale);
        make.centerY.height.mas_equalTo(weakSelf.claimView);
        make.width.mas_equalTo(243*W_Scale);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.claimView.mas_bottom).offset(30*H_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
    
}
-(void)setNavRightItem{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"认领记录" forState:UIControlStateNormal];
    [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13*W_Scale];
    [button addTarget:self action:@selector(claimClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"认领订单" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)claimClick{
    TJOrderClaimDetailsController * ocdvc = [[TJOrderClaimDetailsController alloc]init];
    ocdvc.titles = [NSArray arrayWithObjects:@"全部订单",@"认领成功",@"已结算", nil];
    ocdvc.menuViewStyle = WMMenuViewStyleLine;
    ocdvc.selectIndex = 0;
    ocdvc.titleSizeNormal = 14;
    ocdvc.titleSizeSelected = 15;
    ocdvc.titleColorSelected = RGB(255, 71, 119);
    ocdvc.titleColorNormal = RGB(102, 102, 102);
    ocdvc.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    [self.navigationController pushViewController:ocdvc animated:YES];
}
#pragma mark - TJButtonDeletage
-(void)buttonClick:(UIButton *)but{
    if (self.changeNick) {
        DSLog(@"修改昵称");
    }else{
        DSLog(@"查询订单");
    }
}
#warning 这玩意要封装↓
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}
#warning 这玩意要封装↑
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
