
//
//  TJGoodsListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsListCell.h"
@interface TJGoodsListCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btn_quan;
@property (weak, nonatomic) IBOutlet UILabel *lab_quanh;
@property (weak, nonatomic) IBOutlet UILabel *lab_yuanjia;
@property (weak, nonatomic) IBOutlet UILabel *lab_yimai;



@end

@implementation TJGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
