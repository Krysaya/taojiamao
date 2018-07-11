
//
//  TJMiddleView.m
//  taojiamao
//
//  Created by yueyu on 2018/7/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMiddleView.h"
@interface TJMiddleView ()
@property (nonatomic, strong) UIButton *btn_zichan;
@property (nonatomic, strong) UIButton *btn_order;
@property (nonatomic, strong) UIButton *btn_collect;
@property (nonatomic, strong) UIButton *btn_zuji;

@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation TJMiddleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        [self setSubView];
    }
    return self;
}


- (void)setSubView{
    self.btn_zichan = [self setButtonImg:@"kddq" withButtonTitle:@"我的资产" withButtonTitleFont:12  withTag:1];
      self.btn_order = [self setButtonImg:@"kddq" withButtonTitle:@"我的订单" withButtonTitleFont:12  withTag:2];
    self.btn_collect = [self setButtonImg:@"kddq" withButtonTitle:@"我的收藏" withButtonTitleFont:12  withTag:3];
    self.btn_zuji = [self setButtonImg:@"kddq" withButtonTitle:@"我的足迹" withButtonTitleFont:12 withTag:4];
    [self addSubview:self.btn_zuji];
    [self addSubview:self.btn_collect];
    [self addSubview:self.btn_order];
    [self addSubview:self.btn_zichan];
    WeakSelf
    [self.btn_zichan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(50*W_Scale);
        make.height.mas_equalTo(45*H_Scale);
        make.left.mas_equalTo(weakSelf.mas_left).offset(29*W_Scale);

    }];
    
    [self.btn_order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(50*W_Scale);
        make.height.mas_equalTo(45*H_Scale);
        make.left.mas_equalTo(weakSelf.btn_zichan.mas_right).offset(29*W_Scale);
        
    }];
    
    [self.btn_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(50*W_Scale);
        make.height.mas_equalTo(45*H_Scale);
        make.left.mas_equalTo(weakSelf.btn_order.mas_right).offset(29*W_Scale);
        
    }];
    [self.btn_zuji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(50*W_Scale);
        make.height.mas_equalTo(45*H_Scale);
        make.left.mas_equalTo(weakSelf.btn_collect.mas_right).offset(29*W_Scale);
        
    }];
}

- (UIButton *)setButtonImg:(NSString *)imag withButtonTitle:(NSString *)title withButtonTitleFont:(CGFloat )font withTag:(NSInteger )tag{
    UIButton *btn = [[UIButton alloc]init];
//    btn.backgroundColor = RandomColor;
    btn.tag = tag;
//    UIImageView *img = [[UIImageView alloc]init];
//    img.frame = CGRectMake(0, 0, 25, 22);
//    img.image = [UIImage imageNamed:imag];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imag] forState:UIControlStateNormal];
//    btn.imageView.frame = CGRectMake(0, 0, 25*W_Scale, 22);
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 22)];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height-15, 0, 0, -btn.titleLabel.intrinsicContentSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, -btn.imageView.frame.size.height-15, 0);
    return btn;
}

- (void)buttonClick:(UIButton *)sender{
    if ([self.delegte respondsToSelector:@selector(buttonClick:)]) {
        [self.delegte buttonClick:sender];
    }
}
@end
