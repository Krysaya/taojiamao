
//
//  TJOrderPersonCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderPersonCell.h"
#import "TJKdOrderInfoModel.h"
@interface TJOrderPersonCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *lab_score;
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UIButton *btn_phone;


@end
@implementation TJOrderPersonCell

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
    self.lab_name.text = [NSString stringWithFormat:@"%@",model.daili_name];
    [self.img_head  sd_setImageWithURL:[NSURL URLWithString:model.card_image] placeholderImage: [UIImage imageNamed:@"morentouxiang"]];
    
}
@end
