
//
//  TJKdMineDefaultCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMineDefaultCell.h"
@interface TJKdMineDefaultCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@end

@implementation TJKdMineDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(NSString *)type{
    _type =  type;
    if ([type intValue]==0) {
        self.img.image = [UIImage imageNamed:@"kd_money_yue"];
        self.lab_title.text = @"余额提现";
    }else{
        self.img.image = [UIImage imageNamed:@"kd_money_mx"];
        self.lab_title.text = @"余额明细";
    }
}
@end
