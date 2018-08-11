//
//  TJBindTBController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBindTBController.h"

#define BindButton 125478

@interface TJBindTBController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * TBAccount;
@property(nonatomic,strong)UILabel * hadBind;
@property(nonatomic,strong)UILabel * noBind;
@property(nonatomic,strong)UIImageView * jj;
@property(nonatomic,strong)TJButton * cancel;

@end

@implementation TJBindTBController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户绑定";
    [self setUI];
}
-(void)setUI{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, S_W, 55*H_Scale)];
    self.headView.backgroundColor = RandomColor;
    [self.view addSubview:self.headView];
    
    WeakSelf
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.headView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*W_Scale);
        make.centerY.mas_equalTo(weakSelf.headView);
        make.width.height.mas_equalTo(35*W_Scale);
    }];
    
    self.TBAccount = [self setLabelWith:@"淘宝账号" font:14 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.TBAccount];
    [self.TBAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageView.mas_right).offset(15*W_Scale);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
    
    self.jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.headView addSubview:self.jj];
    self.jj.hidden = YES;
    [self.jj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headView);
        make.right.mas_equalTo(-30*W_Scale);
        make.width.mas_equalTo(6*W_Scale);
        make.height.mas_equalTo(11*H_Scale);
    }];
    
    self.noBind =[self setLabelWith:@"未绑定" font:14 color:RGB(128, 128, 128)];
    [self.headView addSubview:self.noBind];
    self.noBind.hidden = YES;
    [self.noBind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.jj.mas_left).offset(-16*W_Scale);
        make.centerY.mas_equalTo(weakSelf.jj);
    }];
    
    self.cancel = [[TJButton alloc]initWith:@"去绑定" delegate:self font:14*W_Scale titleColor:[UIColor redColor] backColor:[UIColor whiteColor] tag:BindButton];
    [self.headView addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30*W_Scale);
        make.centerY.mas_equalTo(weakSelf.headView);
    }];
    
    self.hadBind = [self setLabelWith:@"(已绑定)" font:14 color:RGB(128, 128, 128)];
    [self.headView addSubview:self.hadBind];
    [self.hadBind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.cancel.mas_left).offset(-16*W_Scale);
        make.centerY.mas_equalTo(weakSelf.headView);
    }];
}
-(void)buttonClick:(UIButton *)but{
    DSLog(@"取消绑定");
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
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
