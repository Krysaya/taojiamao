
//
//  TJKdMineHeadCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMineHeadCell.h"
#import "TJKdAgentsInfoModel.h"
@interface TJKdMineHeadCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_ycode;



@end

@implementation TJKdMineHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJKdAgentsInfoModel *)model{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.card_image] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    self.lab_name.text = [NSString stringWithFormat:@"%@",model.name];
    self.lab_ycode.text = [NSString stringWithFormat:@"%@",model.invite_code];
}
@end
