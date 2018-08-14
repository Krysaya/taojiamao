
//
//  TJOrderInfoOneCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderInfoOneCell.h"
#import "TJKdOrderInfoModel.h"
@interface TJOrderInfoOneCell ()
@property (weak, nonatomic) IBOutlet UILabel *lab_detail;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_code;

@end

@implementation TJOrderInfoOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    switch ([model.status intValue]) {
        case 0:
        {
            self.lab_detail.text = @"取件码：";
            self.lab_code.text = model.qu_code;
        }
            break; case 1:
        {
            self.lab_detail.text = @"已接单，请耐心等待";
        }
            break; case 2:
        {
            self.lab_detail.text = @"待完成~";
        }
            break; case 3:
        {
            self.lab_detail.text = @"订单待评价";
        }
            break; case 4:
        {
            self.lab_detail.text = @"订单已完成,欢迎下次使用";
           
        }
            break; case 5:
        {
            self.lab_detail.text = @"订单失效,请重新发布";
//            self.lab_time.text =
        }
            break; case 6:
        {
            self.lab_detail.text = @"订单已取消";
        }
            break;
            
        default:
            break;
    }
}
@end
