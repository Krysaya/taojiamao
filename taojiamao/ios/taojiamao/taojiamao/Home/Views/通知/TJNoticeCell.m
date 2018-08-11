//
//  TJNoticeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJNoticeCell.h"
#import "TJNoticeListModel.h"
@interface TJNoticeCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_type;
@property (weak, nonatomic) IBOutlet UILabel *lab_titel;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_detailt;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation TJNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lab_type.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJNoticeListModel *)model{
    
    self.lab_titel.text = model.message;
    if ([model.isread intValue]==0) {
        self.lab_type.hidden = NO;
    }else{
        self.lab_type.hidden = YES;
    }
    
    
}
@end
