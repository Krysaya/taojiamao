
//
//  TJOrderHeadViewCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderHeadViewCell.h"
#import "TJKdOrderInfoModel.h"
@interface TJOrderHeadViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lab_status;
@property (weak, nonatomic) IBOutlet UIButton *btn_right;
@property (weak, nonatomic) IBOutlet UIButton *btn_left;

@end

@implementation TJOrderHeadViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn_left.hidden = YES;
    self.btn_right.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    
    if ([model.status intValue]==0) {
        self.lab_status.text = @"等待接单";

    }else if ([model.status integerValue]==4){
        self.lab_status.text = @"订单已完成";
        self.btn_right.hidden = NO;
        [self.btn_right setTitle:@"评论" forState:UIControlStateNormal];
    }else if ([model.status integerValue]==1){
        self.lab_status.text = @"已接单，请按时送达";

    }else{
        
        if ([model.timeout integerValue]==1) {
            self.lab_status.text = @"即将超时，请尽快送达";
        }else{
            self.lab_status.text = @"已超时";

        }
    }
   
}

@end
