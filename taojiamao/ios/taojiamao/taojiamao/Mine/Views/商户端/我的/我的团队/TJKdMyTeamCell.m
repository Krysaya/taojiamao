
//
//  TJKdMyTeamCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyTeamCell.h"
#import "TJKdMyTeamListModel.h"
@interface TJKdMyTeamCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_id;
@property (weak, nonatomic) IBOutlet UILabel *lab_todayDan;
@property (weak, nonatomic) IBOutlet UILabel *lab_todayMoney;


@end

@implementation TJKdMyTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJKdMyTeamListModel *)model{
    _model = model;
    [self.img sd_setImageWithURL: [NSURL URLWithString:model.card_image]];
    self.lab_id.text = model.id;
    self.lab_todayDan.text = [NSString stringWithFormat:@"%@ 单",model.today_dan];
    self.lab_todayMoney.text = [NSString stringWithFormat:@"%@ 元",model.today_money];
}

@end
