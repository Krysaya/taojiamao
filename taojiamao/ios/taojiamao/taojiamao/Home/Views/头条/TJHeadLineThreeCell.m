
//
//  TJHeadLineThreeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineThreeCell.h"
@interface  TJHeadLineThreeCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;

@end

@implementation TJHeadLineThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
