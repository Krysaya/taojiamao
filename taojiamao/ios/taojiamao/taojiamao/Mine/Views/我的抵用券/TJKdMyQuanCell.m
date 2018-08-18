
//
//  TJKdMyQuanCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyQuanCell.h"
#import "TJKdMyQuanModel.h"
@interface TJKdMyQuanCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UILabel *lab_status;


@end

@implementation TJKdMyQuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJKdMyQuanModel *)model{
    _model = model;
    self.lab_money.text = model.coupon;
    
}
@end
