//
//  TJGoodsDetailsTitleCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsDetailsTitleCell.h"
@interface TJGoodsDetailsTitleCell()

@property(nonatomic,strong)TJLabel * title;
@property(nonatomic,strong)UIImageView * taobao;
@property(nonatomic,strong)TJLabel * discount;
@property(nonatomic,strong)TJLabel * money;
@property(nonatomic,strong)YYLabel * original;
@property(nonatomic,strong)TJLabel * kdby;
@property(nonatomic,strong)TJLabel * buyNum;
@property(nonatomic,strong)TJLabel * commission;
@property(nonatomic,strong)TJLabel * address;

@end

@implementation TJGoodsDetailsTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
    }
    return self;
}
-(void)setSubViews{
    WeakSelf
    self.title = [TJLabel setLabelWith:@"ins超火的鞋子女老爹鞋 学生百搭复古跑鞋ulzzang运动女鞋" font:17 color:RGB(51, 51, 51)];
    self.title.numberOfLines = 0;
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*W_Scale);
        make.top.mas_equalTo(15*H_Scale);
        make.right.mas_equalTo(-12*W_Scale);
    }];
    
    self.taobao = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goods_bg.jpg"]];
    [self.contentView addSubview:self.taobao];
    [self.taobao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.title);
        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(13*H_Scale);
        make.width.mas_equalTo(27*W_Scale);
        make.height.mas_equalTo(13*H_Scale);
    }];
    
    self.discount = [TJLabel setLabelWith:@"券后:￥" font:13 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.discount];
    [self.discount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.taobao.mas_bottom).offset(15*H_Scale);
    }];
    
    self.money = [TJLabel setLabelWith:@"0.00" font:24 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.discount.mas_right);
        make.bottom.mas_equalTo(weakSelf.discount.mas_bottom);
    }];
    
    self.original = [[YYLabel alloc]init];
    self.original.attributedText = [self labelStrikethrough:@"0.00"];
    [self.contentView addSubview:self.original];
    [self.original mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.money.mas_right).offset(35*W_Scale);
        make.bottom.mas_equalTo(weakSelf.discount);
    }];
    self.kdby = [TJLabel setLabelWith:@"快递:包邮" font:13 color:RGB(165, 165, 165)];
    [self.contentView addSubview:self.kdby];
    [self.kdby mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.discount.mas_bottom).offset(20*H_Scale);
        make.left.mas_equalTo(weakSelf.discount);
    }];
    self.buyNum = [TJLabel setLabelWith:@"1945人购买" font:13 color:RGB(165, 165, 165)];
    [self.contentView addSubview:self.buyNum];
    [self.buyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.kdby.mas_right).offset(84*W_Scale);
        make.centerY.mas_equalTo(weakSelf.kdby);
    }];
    
    self.commission = [TJLabel setLabelWith:@"佣金￥2.8" font:13 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.commission];
    [self.commission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.title);
        make.bottom.mas_equalTo(weakSelf.original);
    }];
    
    self.address =[TJLabel setLabelWith:@"浙江温州" font:13 color:RGB(165, 165, 165)];
    [self.contentView addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.title);
        make.centerY.mas_equalTo(weakSelf.kdby);
    }];
}

-(NSMutableAttributedString*)labelStrikethrough:(NSString*)str{
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",str]];
    one.yy_textStrikethrough = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle];
    one.yy_font = [UIFont boldSystemFontOfSize:13];
    [one yy_setStrikethroughStyle:NSUnderlineStyleSingle range:NSMakeRange(0, one.length)];
    [one yy_setColor:RGB(165, 165, 165) range:NSMakeRange(0, one.length)];
    
    return one;
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
