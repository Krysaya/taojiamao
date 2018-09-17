
//
//  TJTBOrderContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTBOrderContentCell.h"
#import "TJTaoBaoOrderModel.h"

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
    self.iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goods_bg"]];
    WeakSelf;
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(82);
        make.width.mas_equalTo(82);

    }];
    
//    self.tbImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_bs"]];
//    [self.contentView addSubview:self.tbImg];
//    [self.tbImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(weakSelf.title.mas_bottom).offset(9);
//        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(16);
//        make.height.mas_equalTo(13);
//        make.width.mas_equalTo(27);
//
//    }];
    
    self.arrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.iconImg.mas_centerY);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(6);
    }];
    
    self.title = [[UILabel alloc]init];
    self.title.text = @" ";
    self.title.textColor = RGB(51, 51, 51);
    self.title.numberOfLines = 0;
    self.title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(16);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(weakSelf.arrowImg.mas_right).offset(30);
//        make.width.mas_equalTo(160);
        
    }];

    self.jiesuan_time = [[UILabel alloc]init];
    self.jiesuan_time.text = @"预计05月12日结算";
    self.jiesuan_time.textColor = RGB(102, 102, 102);
    self.jiesuan_time.font = [UIFont systemFontOfSize:12];

    [self.contentView addSubview:self.jiesuan_time];
    [self.jiesuan_time mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(weakSelf.tbImg.mas_bottom).offset(11*H_Scale);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(16);
//        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(weakSelf.iconImg.mas_bottom);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = RGB(230, 230, 230);
    [self.contentView addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(S_W-24);
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.iconImg.mas_bottom).offset(10);
        
    }];
    
    self.order_type = [[UILabel alloc]init];
    self.order_type.text = @"订单来源：淘宝";
    self.order_type.font = [UIFont systemFontOfSize:12];

    self.order_type.textColor = RGB(102, 102, 102);

    [self.contentView addSubview:self.order_type];
    
    [self.order_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.line.mas_bottom).offset(10);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(10);
    }];
    self.time = [[UILabel alloc]init];
    self.time.text = @"下单时间：";
    
    self.time.font = [UIFont systemFontOfSize:12];

    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(weakSelf.order_type.mas_centerY);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(10);
    }];
    
    self.order_num = [[UILabel alloc]init];
    self.order_num.text = @"订单号：";
    self.order_num.font = [UIFont systemFontOfSize:12];
    self.order_num.textColor = RGB(102, 102, 102);

    [self.contentView addSubview:self.order_num];
    
    [self.order_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.order_type.mas_bottom).offset(19*H_Scale);
//        make.height.mas_equalTo(10);
        make.left.mas_equalTo(12);
    }];
    
    self.daijiesuan = [[UILabel alloc]init];
    self.daijiesuan.text = @"待结算";
    self.daijiesuan.textColor = RGB(102, 102, 102);
    self.daijiesuan.font = [UIFont systemFontOfSize:14];

    [self.contentView addSubview:self.daijiesuan];
    
    [self.daijiesuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(weakSelf.order_num.mas_centerY);
//        make.height.mas_equalTo(10);
    }];
}

- (void)setModel:(TJTaoBaoOrderModel *)model{
    _model = model;
    [self.iconImg sd_setImageWithURL: [NSURL URLWithString:model.item_pic] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    self.title.text = model.item_title;
    self.order_num.text = [NSString stringWithFormat:@"订单号：%@",model.trade_id];
    self.order_type.text = [NSString stringWithFormat:@"订单来源：%@",model.order_type];
    self.time.text = model.create_time;
    if ([model.tk_status intValue]==3) {
        self.daijiesuan.text = @"订单待结算";
    }
    if ([model.tk_status intValue]==13) {
        self.daijiesuan.text = @"订单已失效";
    }if ([model.tk_status intValue]==12) {
        self.daijiesuan.text = @"订单待付款";
    }if ([model.tk_status intValue]==14) {
        self.daijiesuan.text = @"订单已完成";
    }if ([model.tk_status intValue]==15) {
        self.daijiesuan.text = @"";
    }
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
