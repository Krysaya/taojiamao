
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
    
    double time = [model.song_start_time doubleValue];
    double time_end = [model.song_end_time doubleValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *myendDate = [NSDate dateWithTimeIntervalSince1970:time_end];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSDateFormatter *formatter1 = [NSDateFormatter new];
    [formatter1 setDateFormat:@"HH:mm"];
    //将时间转换为字符串
    
    NSString *timeS = [formatter stringFromDate:myDate];
    NSString *timeEnd = [formatter1 stringFromDate:myendDate];
    
    self.lab_time.text = [NSString stringWithFormat:@"%@-%@",timeS,timeEnd];
    
    if ([self.shoryh isEqualToString:@"sh"]) {
//        商户详情
        if ([self.type_hp isEqualToString:@"danjiedan"]) {
            self.lab_detail.text = @"取件码：";
            self.lab_code.text = model.qu_code;
        }else{
            if ([model.timeout intValue]==1) {
                self.lab_detail.text = @"若订单超时，则扣除50%收益";
            }else if ([model.timeout intValue]==2){
                self.lab_detail.text = @"订单已超时";
            }else{
                self.lab_detail.text = @"累计获得收益：";
                if ([model.is_ji intValue]==0) {
                    self.lab_code.text = [NSString stringWithFormat:@"(取件费%@元)",model.qu_fee];
                }
                self.lab_code.text = [NSString stringWithFormat:@"(取件费%@元+加急费%@元)",model.qu_fee,model.is_ji];
            }
        }
        
        
       
    }else{
//        用户详情
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
   
    
    
}
@end
