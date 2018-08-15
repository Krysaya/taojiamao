
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
    }else if ([type intValue]==1) {
        self.img.image = [UIImage imageNamed:@"kd_money_mx"];
        self.lab_title.text = @"余额明细";
    }else if ([type intValue]==3) {
        self.img.image = [UIImage imageNamed:@"kd_my_yq"];
        self.lab_title.text = @"邀请好友";
    }else if ([type intValue]==4) {
        self.img.image = [UIImage imageNamed:@"kd_my_kf"];
        self.lab_title.text = @"客服中心";
    }else if ([type intValue]==5) {
        self.img.image = [UIImage imageNamed:@"kd_my_fk"];
        self.lab_title.text = @"意见反馈";
    }
}
@end
