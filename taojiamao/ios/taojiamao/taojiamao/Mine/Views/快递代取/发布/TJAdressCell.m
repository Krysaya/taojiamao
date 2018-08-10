
//
//  TJAdressCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAdressCell.h"
@interface TJAdressCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_phone;
@property (weak, nonatomic) IBOutlet UILabel *lab_songAddress;


@end

@implementation TJAdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
