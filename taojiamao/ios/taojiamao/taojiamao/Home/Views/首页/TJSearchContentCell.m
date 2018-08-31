//
//  TJSearchContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//
#import "TJJHSGoodsListModel.h"
#import "TJSearchContentCell.h"
@interface TJSearchContentCell()

@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UIImageView * taobao;
@property(nonatomic,strong)TJLabel * title;
@property(nonatomic,strong)TJLabel * discount;
@property(nonatomic,strong)TJLabel * money;
@property(nonatomic,strong)TJLabel * buyNum;
@property(nonatomic,strong)UIImageView * backView;
@property(nonatomic,strong)TJLabel * minus;

@end

@implementation TJSearchContentCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RandomColor;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    WeakSelf
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(weakSelf.contentView);
        make.width.height.mas_equalTo(weakSelf.contentView.mas_width);
    }];
   
    self.taobao = [[UIImageView alloc]init];
    [self.contentView addSubview:self.taobao];
    [self.taobao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakSelf.icon.mas_bottom).offset(10*H_Scale);
        make.width.mas_equalTo(27*W_Scale);
        make.height.mas_equalTo(13*H_Scale);
    }];
    
    self.title = [TJLabel setLabelWith:@"汤米瑞春秋吊带红旗雷哥专用" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.taobao);
        make.right.mas_equalTo(-10*W_Scale);
    }];
    
    self.buyNum = [TJLabel setLabelWith:@"5.7万人购买" font:11 color:RGB(165, 165, 165)];
    [self.contentView addSubview:self.buyNum];
    [self.buyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.taobao.mas_bottom).offset(14*H_Scale);
    }];
    
    self.discount = [TJLabel setLabelWith:@"券后:￥" font:12 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.discount];
    [self.discount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.buyNum.mas_bottom).offset(15*H_Scale);
    }];
    
    self.money = [TJLabel setLabelWith:@"270.0" font:19 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.discount.mas_right);
        make.bottom.mas_equalTo(weakSelf.discount.mas_bottom);
    }];
    
    self.backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youhuiquanBJ"]];
    self.backView.backgroundColor = RandomColor;
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-14);
        make.width.mas_equalTo(62*W_Scale);
        make.height.mas_equalTo(18*H_Scale);
    }];
    
    self.minus = [TJLabel setLabelWith:@"领券减300" font:12 color:RGB(255, 255, 255)];
    [self.contentView addSubview:self.minus];
    [self.minus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.backView);
    }];
    
}


- (void)setModel:(TJJHSGoodsListModel *)model{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.itempic] placeholderImage:[UIImage imageNamed:@"goods_bg.jpg"]];
//    if (model.site) {
//        <#statements#>
//    }
    self.title.text = model.itemtitle;
    self.buyNum.text = [NSString stringWithFormat:@"%@人已买",model.itemsale];
    self.money.text = model.itemprice;
    
}














@end
