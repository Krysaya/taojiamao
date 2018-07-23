
//
//  TJDetailListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJDetailListCell.h"
@interface TJDetailListCell()


@property (weak, nonatomic) IBOutlet UILabel *lab_num;
@end

@implementation TJDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
