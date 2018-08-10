
//
//  TJOrderTypeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderTypeCell.h"
@interface TJOrderTypeCell()
@property (weak, nonatomic) IBOutlet UIImageView *img_kdlogo;
@property (weak, nonatomic) IBOutlet UILabel *lab_kdtype;
@property (weak, nonatomic) IBOutlet UILabel *lab_kdnum;


@end

@implementation TJOrderTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
