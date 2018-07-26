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

@end

@implementation TJNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJNoticeListModel *)model{
    
    self.lab_titel.text = model.message;
    
}
@end
