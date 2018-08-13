

//
//  TJBargainHeadCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBargainHeadCell.h"
@interface TJBargainHeadCell()

@property (weak, nonatomic) IBOutlet UIImageView *img_one;
@property (weak, nonatomic) IBOutlet UIImageView *img_two;

@end

@implementation TJBargainHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
