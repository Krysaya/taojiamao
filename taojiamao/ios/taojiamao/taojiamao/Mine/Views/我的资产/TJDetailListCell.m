
//
//  TJDetailListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJDetailListCell.h"
#import "TJAssetsDetailListModel.h"
@interface TJDetailListCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_type;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;
@end

@implementation TJDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJAssetsDetailListModel *)model{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
     NSString *time = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.addtime doubleValue]]];
//    self.lab_type.text = model.message;
    self.lab_time.text = time;
    
    if ([model.type intValue]==1) {
        self.lab_type.text = @"签到";
    }
    
    if ([model.operate intValue]==1) {
        self.lab_num.text = [NSString stringWithFormat:@"+ %@",model.point];
    }else{
        self.lab_num.text = [NSString stringWithFormat:@"- %@",model.point];

    }
}
@end
