//
//  TJHomeFootShowCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomeFootShowCell.h"
#import "TJJHSGoodsListModel.h"
@interface TJHomeFootShowCell()

@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UIImageView * shareOption;
@property(nonatomic,strong)UIImageView * taobao;
@property(nonatomic,strong)TJLabel * title;
@property(nonatomic,strong)TJLabel * discount;
@property(nonatomic,strong)TJLabel * money;
@property(nonatomic,strong)YYLabel * original;
@property(nonatomic,strong)TJLabel * buyNum;
@property(nonatomic,strong)UIImageView * backView;
@property(nonatomic,strong)TJLabel * minus;
@property(nonatomic,strong)UIView * line;

@property(nonatomic,assign)BOOL selectB;
@end

@implementation TJHomeFootShowCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectB = NO;
        [self setUI];
        
    }
    return self;
}
-(void)setUI{
    
    WeakSelf
    self.icon = [[UIImageView alloc]init];
//    self.icon.backgroundColor = RandomColor;
    UITapGestureRecognizer * tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick)];
    [self.icon addGestureRecognizer:tap];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(weakSelf.contentView);
        make.width.height.mas_equalTo(140*H_Scale);
    }];
    
    self.shareOption = [[UIImageView alloc]init];
    [self.contentView addSubview:self.shareOption];
    [self.shareOption mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.icon);
        make.width.height.mas_equalTo(27);
    }];
    self.shareOption.hidden = YES;
    
    
    self.taobao = [[UIImageView alloc]init];
//    self.taobao.backgroundColor = RandomColor;
    [self.contentView addSubview:self.taobao];
    [self.taobao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(15*W_Scale);
        make.top.mas_equalTo(weakSelf.icon).offset(10*H_Scale);
        make.width.mas_equalTo(27*W_Scale);
        make.height.mas_equalTo(13*H_Scale);
    }];
    
    
    self.title = [TJLabel setLabelWith:@"" font:14 color:RGB(51, 51, 51)];
    self.title.numberOfLines = 2;
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.taobao).offset(-2);
        make.right.mas_equalTo(-30);
//        make.height.mas_equalTo(32*H_Scale);
    }];
    
    self.discount = [TJLabel setLabelWith:@"券后:￥" font:12 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.discount];
    [self.discount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(24*H_Scale);
    }];
    
    self.money = [TJLabel setLabelWith:@"" font:19 color:RGB(255, 71, 119)];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.discount.mas_right);
        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(16*H_Scale);
    }];
    
    
    self.original = [[YYLabel alloc]init];
    [self.contentView addSubview:self.original];
    [self.original mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.money.mas_right).offset(19);
        make.bottom.mas_equalTo(weakSelf.discount);
    }];
    
    self.buyNum = [TJLabel setLabelWith:@"" font:11 color:RGB(165, 165, 165)];
    [self.contentView addSubview:self.buyNum];
    [self.buyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.discount.mas_bottom).offset(10*H_Scale);
    }];
    
    self.backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quan_bg"]];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.taobao);
        make.top.mas_equalTo(weakSelf.buyNum.mas_bottom).offset(10);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(18);
    }];
    
    self.minus = [TJLabel setLabelWith:@"" font:12 color:RGB(255, 255, 255)];
    [self.contentView addSubview:self.minus];
    [self.minus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.backView);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = RGB(211, 211, 211);
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.8);
//        make.width.mas_equalTo();
        make.left.mas_equalTo(weakSelf.taobao);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-5);

    }];
}
-(void)setModel:(TJJHSGoodsListModel *)model{
    _model = model;
    self.money.text = model.itemendprice;
    if ([model.shoptype isEqualToString:@"B"]) {
        self.taobao.image = [UIImage imageNamed:@"tb_bs"];
    }else{
        self.taobao.image = [UIImage imageNamed:@"tm_bs"];
    }
    self.title.attributedText = [self labelRetract:model.itemtitle];
    
    self.buyNum.text =[NSString stringWithFormat:@"%@人已买",model.itemsale];
    
    self.original.attributedText = [self labelStrikethrough:model.itemprice];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.itempic] placeholderImage:[UIImage imageNamed:@"goods_bg.jpg"]];

    self.minus.text = [NSString stringWithFormat:@"领券减%@",model.couponmoney];
    
}
-(NSAttributedString*)labelRetract:(NSString*)str{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    // 对齐方式
    style.alignment = NSTextAlignmentJustified;
    // 首行缩进
    style.firstLineHeadIndent = 30.0f;
    // 头部缩进
    //    style.headIndent = 10.0f;
    // 尾部缩进
    //    style.tailIndent = -10.0f;
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:str attributes:@{ NSParagraphStyleAttributeName : style}];
    return attrText;
}
-(NSMutableAttributedString*)labelStrikethrough:(NSString*)str{
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",str]];
    one.yy_textStrikethrough = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle];
    one.yy_font = [UIFont boldSystemFontOfSize:11];
    [one yy_setStrikethroughStyle:NSUnderlineStyleSingle range:NSMakeRange(0, one.length)];
    [one yy_setColor:RGB(165, 165, 165) range:NSMakeRange(0, one.length)];
    
    return one;
}
-(void)setShowShare:(BOOL)showShare{
    _showShare = showShare;
    self.shareOption.hidden = !showShare;
    self.icon.userInteractionEnabled = showShare;
    self.shareOption.image = [UIImage imageNamed:@"check_default"];
}
-(void)setIsShare:(BOOL)isShare{
    _isShare = isShare;
    if (isShare) {
        self.shareOption.image = [UIImage imageNamed:@"check_light"];
    }else{
        self.shareOption.image = [UIImage imageNamed:@"check_default"];
    }
    self.selectB = isShare;
}

-(void)iconClick{

    self.selectB = !self.selectB;
    if (self.selectB) {
       self.shareOption.image = [UIImage imageNamed:@"check_light"];
    }else{
       self.shareOption.image = [UIImage imageNamed:@"check_default"];
    }

    if (self.deletage && [self.deletage respondsToSelector:@selector(deletageWithModel:withCell:)]) {
        [self.deletage deletageWithModel:self.model withCell:self];
    }
}









@end
