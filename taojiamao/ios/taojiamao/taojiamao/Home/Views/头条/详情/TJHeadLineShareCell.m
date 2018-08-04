//
//  TJHeadLineShareCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineShareCell.h"

@interface TJHeadLineShareCell()

@property (weak, nonatomic) IBOutlet UIButton *btn_pyq;
@property (weak, nonatomic) IBOutlet UIButton *btn_wx;
@property (weak, nonatomic) IBOutlet UIButton *btn_qq;
@property (weak, nonatomic) IBOutlet UIButton *btn_qqaz;

@end

@implementation TJHeadLineShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
