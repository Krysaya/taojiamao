//
//  TJContentListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentListCell.h"
@interface TJContentListCell()
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation TJContentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
