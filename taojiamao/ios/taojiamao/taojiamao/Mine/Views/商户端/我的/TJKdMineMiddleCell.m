
//
//  TJKdMineMiddleCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMineMiddleCell.h"
@interface TJKdMineMiddleCell()
@property (weak, nonatomic) IBOutlet UIImageView *img_line;
@property (weak, nonatomic) IBOutlet UIImageView *img_lineteo;
@property (weak, nonatomic) IBOutlet UILabel *lab_dan;
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UIImageView *img_one;


@end

@implementation TJKdMineMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img_lineteo.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
