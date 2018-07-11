//
//  TJOCDContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/10.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOCDContentCell.h"
@interface TJOCDContentCell()

@property(nonatomic,strong)UILabel * orderNum;
@property(nonatomic,strong)UILabel * claimTime;
@property(nonatomic,strong)UILabel * status;

@end

@implementation TJOCDContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.orderNum = [self setLabelWith:12*W_Scale color:RGB(102, 102, 102)];
        self.claimTime = [self setLabelWith:12*W_Scale color:RGB(102, 102, 102)];
        self.status =[self setLabelWith:14*W_Scale color:RGB(255, 72, 120)];
        
        self.orderNum.text =@"订单号:888888888888";
        self.claimTime.text =@"订单号:888888888888";
        self.status.text =@"订单号:888888888888";
        
        [self.contentView addSubview:self.orderNum];
        [self.contentView addSubview:self.claimTime];
        [self.contentView addSubview:self.status];
        
        WeakSelf
        [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12*W_Scale);
            make.top.mas_equalTo(18*W_Scale);
        }];
        [self.claimTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.orderNum);
            make.top.mas_equalTo(weakSelf.orderNum.mas_bottom).offset(20*W_Scale);
        }];
        
        [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-18*H_Scale);
            make.right.mas_equalTo(-14*W_Scale);
        }];
    }
    return self;
}
-(UILabel*)setLabelWith:(CGFloat)font color:(UIColor*)c{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
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
