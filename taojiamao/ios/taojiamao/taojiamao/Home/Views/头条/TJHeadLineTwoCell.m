//
//  TJHeadLineTwoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineTwoCell.h"
#import "TJArticlesListModel.h"
@interface TJHeadLineTwoCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;


@end

@implementation TJHeadLineTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJArticlesListModel *)model{
    self.lab_title.text = model.title;
    self.lab_from.text = model.source;
    self.lab_pinglun.text = [NSString stringWithFormat:@"%@评论",model.comment_num];
    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    [self.img sd_setImageWithURL: [NSURL URLWithString:model.thumb]];
}
@end
