
//
//  TJCourierTakeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCourierTakeCell.h"
#import "TJKdUserOrderList.h"
#import "TJOverallJudge.h"
@interface TJCourierTakeCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_nickname;
@property (weak, nonatomic) IBOutlet UILabel *lab_phonenum;
@property (weak, nonatomic) IBOutlet UILabel *lab_qu;
@property (weak, nonatomic) IBOutlet UILabel *lab_song;
@property (weak, nonatomic) IBOutlet UILabel *lab_day;

@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_status;
@property (weak, nonatomic) IBOutlet UILabel *lab_jiaji;
@property (weak, nonatomic) IBOutlet UIImageView *img_jiaji;

@end

@implementation TJCourierTakeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TJKdUserOrderList *)model{
    _model = model;
    self.btn_pl.hidden = YES;

    if (![TJOverallJudge judgeBlankString:model.shou_username]) {
        self.lab_nickname.text = model.shou_username;
        DSLog(@"no??");
    }
    
//    加急
    if ([model.is_ji intValue]==0) {
        self.lab_jiaji.hidden = YES;
        self.img_jiaji.hidden = YES;
    }else{
        self.lab_jiaji.hidden = NO;
        self.img_jiaji.hidden = NO;
    }
    
    self.lab_phonenum.text = model.shou_telephone;
    self.lab_qu.text = [NSString stringWithFormat:@"[取件地址]%@",model.qu_address];
    self.lab_song.text = [NSString stringWithFormat:@"[送件地址]%@",model.song_address];
    if ([model.status intValue]==0) {
        self.lab_status.text = @"待接单";
    }else if ([model.status intValue]==1){
        self.lab_status.text = @"已接单";

    }else if ([model.status intValue]==2){
        self.lab_status.text = @"待完成";

    }else if ([model.status intValue]==3){
        self.lab_status.text = @"待评价";
        self.btn_pl.hidden = NO;

    }else if ([model.status intValue]==4){
        self.lab_status.text = @"已完成";
        self.btn_pl.hidden = NO;

    }else if ([model.status intValue]==5){
        self.lab_status.text = @"已失效";

    }else{
        self.lab_status.text = @"已取消";
    }
}
@end
