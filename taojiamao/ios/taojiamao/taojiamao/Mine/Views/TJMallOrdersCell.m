

//
//  TJMallOrdersCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/2.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMallOrdersCell.h"
@interface TJMallOrdersCell ()
@property(nonatomic,strong)UIImageView *iconImg;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *members;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *courierNum;
@property (nonatomic, strong) UILabel *placeOrderTime;
@property (nonatomic, strong) UILabel *orderNum;
@property (nonatomic, strong) UILabel *receiveInfo;
@end

@implementation TJMallOrdersCell

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
     make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(15*H_Scale);
        make.left.mas_equalTo(12*W_Scale);
        make.height.mas_equalTo(80*H_Scale);
        make.width.mas_equalTo(80*W_Scale);
        
    }];
    
    self.title = [[UILabel alloc]init];
    self.title.text  = @"9.9元体验淘价猫VIP会员";
    self.title.textColor = RGB(51, 51, 51);
    self.title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(15*W_Scale);
        make.height.mas_equalTo(20*H_Scale);
//        make.width.mas_equalTo(160*W_Scale);
        
    }];
    
    self.members = [[UILabel alloc]init];
    self.members.textColor = [UIColor whiteColor];
    self.members.text = @"VIP会员";
    self.members.font = [UIFont systemFontOfSize:12];
    self.members.textAlignment = NSTextAlignmentCenter;
    self.members.backgroundColor = KALLRGB;
    self.members.layer.masksToBounds = YES;
    self.members.layer.cornerRadius = 5;
    [self.contentView addSubview:self.members];
    [self.members mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(10*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(15*W_Scale);
        make.height.mas_equalTo(20*H_Scale);
        make.width.mas_equalTo(50*W_Scale);
    }];
    
    self.price = [[UILabel alloc]init];
    self.price.textColor = KALLRGB;
    self.price.text = @"¥9.9";
    [self.contentView addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.members.mas_bottom).offset(22*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(15*W_Scale);
        make.height.mas_equalTo(20*H_Scale);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = RGB(230, 230, 230);
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(351*W_Scale);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.iconImg.mas_bottom).offset(10*H_Scale);
    }];
    
    self.courierNum = [[UILabel alloc]init];
    self.courierNum.text = @"快递单号：暂无订单号";
    self.courierNum.font = [UIFont systemFontOfSize:12];
    self.courierNum.textColor = RGB(102, 102, 102);
    [self.contentView addSubview:self.courierNum];
    [self.courierNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.line.mas_bottom).offset(10*H_Scale);
        make.left.mas_equalTo(12*W_Scale);
        
    }];
    
    self.placeOrderTime = [[UILabel alloc]init];
    self.placeOrderTime.textColor = RGB(102, 102, 102);
    self.placeOrderTime.text = @"下单时间：2018-06-28 09：54：06";
    self.placeOrderTime.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.placeOrderTime];
    [self.placeOrderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*W_Scale);
        make.top.mas_equalTo(weakSelf.courierNum.mas_bottom).offset(12*H_Scale);
        
    }];
    
    self.orderNum = [[UILabel alloc]init];
    self.orderNum.textColor = RGB(102, 102, 102);
    self.orderNum.text = @"订单编号：565894413367332299";
    self.orderNum.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.orderNum];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*W_Scale);
        make.top.mas_equalTo(weakSelf.placeOrderTime.mas_bottom).offset(12*H_Scale);
        
    }];
    
    self.receiveInfo = [[UILabel alloc]init];
    self.receiveInfo.textColor = RGB(102, 102, 102);
    self.receiveInfo.numberOfLines = 0;
    self.receiveInfo.text = @"收货信息：啦啦啦 15728913893 河北省 石家庄市 新华区 民族路 华强广场1202";
    self.receiveInfo.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.receiveInfo];
    [self.receiveInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*W_Scale);
        make.right.mas_equalTo(-12*W_Scale); make.top.mas_equalTo(weakSelf.orderNum.mas_bottom).offset(12*H_Scale);
        
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
