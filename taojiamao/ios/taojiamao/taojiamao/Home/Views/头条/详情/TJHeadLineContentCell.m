
//
//  TJHeadLineContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineContentCell.h"
#import "TJArticlesInfoListModel.h"
@interface TJHeadLineContentCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;


@end

@implementation TJHeadLineContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJArticlesInfoListModel *)model{
    
}
@end
