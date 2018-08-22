

//
//  TJKdHomeOrderCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdHomeOrderCell.h"
#import "TJKdUserOrderList.h"
@interface TJKdHomeOrderCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_sex;
@property (weak, nonatomic) IBOutlet UILabel *lab_phone;
@property (weak, nonatomic) IBOutlet UILabel *lab_qu;
@property (weak, nonatomic) IBOutlet UILabel *lab_song;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_jiaji;
@property (weak, nonatomic) IBOutlet UILabel *lab_jj;

@end

@implementation TJKdHomeOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJKdUserOrderList *)model{
    _model = model;
    if (![TJOverallJudge judgeBlankString:model.shou_username]) {
        self.lab_name.text = model.shou_username;
        DSLog(@"no??");
    }
    
    //    加急
    if ([model.is_ji intValue]==0) {
        self.lab_jiaji.hidden = YES;
        self.lab_jj.hidden = YES;
    }else{
        self.lab_jiaji.hidden = NO;
        self.lab_jj.hidden = NO;
        self.lab_jiaji.text = model.is_ji;
    }
    
    self.lab_phone.text = model.shou_telephone;
    self.lab_qu.text = [NSString stringWithFormat:@"[取件地址]%@",model.qu_address];
    self.lab_song.text = [NSString stringWithFormat:@"[送件地址]%@",model.song_address];
//    时间;
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
    

}
@end
