

//
//  TJTouTiaoInfoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTouTiaoInfoCell.h"
#import "TJArticlesInfoListModel.h"

@interface TJTouTiaoInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_pl;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;


@end

@implementation TJTouTiaoInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJArticlesInfoListModel *)model{
    _model = model;
    self.lab_title.text = model.title;
    self.lab_from.text = model.source;
    self.lab_pl.text = [NSString stringWithFormat:@"%@人评论",model.comment_num];
    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    self.lab_content.text = model.content;
}
@end
