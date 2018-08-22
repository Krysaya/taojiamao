
//
//  TJOrderInfoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderInfoCell.h"
#import "TJKdOrderInfoModel.h"
@interface TJOrderInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_danhao;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_ji;

@property (weak, nonatomic) IBOutlet UILabel *lab_payType;

@end

@implementation TJOrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    self.lab_danhao.text = model.danhao;
    double time = [model.addtime doubleValue];
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //将时间转换为字符串
    NSString *timeS = [formatter stringFromDate:myDate];
    self.lab_time.text = timeS;
    if ([model.is_ji  intValue]==0) {
        self.lab_ji.text = @"否";
    }else{
        self.lab_ji.text = @"是";
    }
}
@end
