
//
//  TJCourierTakeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCourierTakeCell.h"
@interface TJCourierTakeCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_nickname;
@property (weak, nonatomic) IBOutlet UILabel *lab_phonenum;
@property (weak, nonatomic) IBOutlet UILabel *lab_qu;
@property (weak, nonatomic) IBOutlet UILabel *lab_song;
@property (weak, nonatomic) IBOutlet UILabel *lab_day;

@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_status;
@property (weak, nonatomic) IBOutlet UIButton *btn_pl;

@end

@implementation TJCourierTakeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
