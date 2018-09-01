
//
//  TJInvitePrizeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJInvitePrizeCell.h"
@interface TJInvitePrizeCell()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_qhprice;
@property (weak, nonatomic) IBOutlet UILabel *lab_yjprice;
@property (weak, nonatomic) IBOutlet UIButton *btn_buy;

@end

@implementation TJInvitePrizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
