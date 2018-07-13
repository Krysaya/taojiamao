
//
//  TJTBOrderContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTBOrderContentCell.h"

@interface TJTBOrderContentCell()
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIImageView *tbImg;

@property(nonatomic,strong)UIImageView *arrowImg;

@property(nonatomic,strong)UILabel *jiesuan_time;

@property(nonatomic,strong)UIView *line;

@property(nonatomic,strong)UILabel *order_type;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *order_num;
@property(nonatomic,strong)UILabel *daijiesuan;



@end

@implementation TJTBOrderContentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUIsubViews];
    }
    return self;
}


- (void)setUIsubViews{
    self.iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading1"]];
    WeakSelf;
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(82);
        make.width.mas_equalTo(82);

    }];
    
    self.title = [[UILabel alloc]init];
    self.title.text = @"雅丽洁防晒霜喷雾学生户外超强隔离女全身面部保护";
    self.title.textColor = RGB(51, 51, 51);
    self.title.numberOfLines = 0;
    self.title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(16);
        make.height.mas_equalTo(45*H_Scale);
        make.width.mas_equalTo(160*W_Scale);

    }];

    self.tbImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading1"]];
    [self.contentView addSubview:self.tbImg];
    [self.tbImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(9*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(16);
        make.height.mas_equalTo(10*H_Scale);
        make.width.mas_equalTo(25*W_Scale);

    }];
    
    self.arrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading1"]];
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.iconImg.mas_centerY);
        make.right.mas_equalTo(-38*W_Scale);
        make.height.mas_equalTo(11*H_Scale);
        make.width.mas_equalTo(6*W_Scale);
    }];
    
    self.jiesuan_time = [[UILabel alloc]init];
    self.jiesuan_time.text = @"预计05月12日结算";
    self.jiesuan_time.textColor = RGB(102, 102, 102);
    self.jiesuan_time.font = [UIFont systemFontOfSize:12];

    [self.contentView addSubview:self.jiesuan_time];
    [self.jiesuan_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tbImg.mas_bottom).offset(11*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(16);
//        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(weakSelf.iconImg.mas_bottom);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = RGB(230, 230, 230);
    [self.contentView addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(351*W_Scale);
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.iconImg.mas_bottom).offset(10);
        
    }];
    
    self.order_type = [[UILabel alloc]init];
    self.order_type.text = @"taobao";
    self.order_type.font = [UIFont systemFontOfSize:12];

    self.order_type.textColor = RGB(102, 102, 102);

    [self.contentView addSubview:self.order_type];
    
    [self.order_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.line.mas_bottom).offset(10);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(10);
    }];
    self.time = [[UILabel alloc]init];
    self.time.text = @"09月28号";
    self.time.font = [UIFont systemFontOfSize:12];

    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(weakSelf.order_type.mas_centerY);
        make.right.mas_equalTo(-12*W_Scale);
        make.height.mas_equalTo(10*H_Scale);
    }];
    
    self.order_num = [[UILabel alloc]init];
    self.order_num.text = @"订单号：394u79345739";
    self.order_num.font = [UIFont systemFontOfSize:12];
    self.order_num.textColor = RGB(102, 102, 102);

    [self.contentView addSubview:self.order_num];
    
    [self.order_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.order_type.mas_bottom).offset(19*H_Scale);
//        make.height.mas_equalTo(10);
        make.left.mas_equalTo(12*W_Scale);
    }];
    
    self.daijiesuan = [[UILabel alloc]init];
    self.daijiesuan.text = @"待结算";
    self.daijiesuan.textColor = RGB(102, 102, 102);
    self.daijiesuan.font = [UIFont systemFontOfSize:14];

    [self.contentView addSubview:self.daijiesuan];
    
    [self.daijiesuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12*W_Scale);
        make.centerY.mas_equalTo(weakSelf.order_num.mas_centerY);
//        make.height.mas_equalTo(10);
    }];
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
