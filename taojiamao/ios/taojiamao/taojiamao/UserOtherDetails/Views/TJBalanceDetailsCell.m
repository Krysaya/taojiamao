//
//  TJBalanceDetailsCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBalanceDetailsCell.h"

@interface TJBalanceDetailsCell()

@property(nonatomic,strong)UILabel * effect;
@property(nonatomic,strong)UILabel * time;
@property(nonatomic,strong)UILabel * amount;

@end

@implementation TJBalanceDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.effect = [self setLabelWith:17 color:RGB(51, 51, 51)];
        self.time = [self setLabelWith:13 color:RGB(102, 102, 102)];
        self.amount =[self setLabelWith:17 color:RGB(51, 51, 51)];
        
        [self.contentView addSubview:self.effect];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.amount];
        WeakSelf
        [self.effect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(36);
            make.top.mas_equalTo(15);
        }];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(36);
            make.top.mas_equalTo(weakSelf.effect.mas_bottom).offset(15);
        }];
        
        [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.contentView);
            make.right.mas_equalTo(-35);
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

-(void)setModel:(TJBalanceDetailsModel *)model{
    _model = model;
    self.effect.text = model.action;
    self.time.text = model.create_time?model.create_time:model.add_time;
    self.amount.text = model.money;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
