
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
    
    switch ([model.status intValue]) {
        case 0:
        {
            self.lab_status.text = @"等待接单";
        }
            break; case 1:
        {
            self.lab_status.text = @"已接单，请耐心等待";
        }
            break; case 2:
        {
            self.lab_status.text = @"";
        }
            break; case 3:
        {
            self.lab_status.text = @"订单待评价";
        }
            break; case 4:
        {
            self.lab_status.text = @"订单已完成";
            self.btn_right.hidden = NO;
            [self.btn_right setTitle:@"评论" forState:UIControlStateNormal];
        }
            break; case 5:
        {
            self.lab_status.text = @"订单已失效";
        }
            break; case 6:
        {
            self.lab_status.text = @"订单已取消";
        }
            break;
            
        default:
            break;
    }
}

@end
