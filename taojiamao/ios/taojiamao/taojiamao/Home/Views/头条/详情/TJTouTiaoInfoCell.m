

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
//    self.lab_from.text = model.source;
    self.lab_from.text = [NSString stringWithFormat:@"发布时间：%@",model.created_time];
//    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[ model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.lab_content.attributedText = attrStr;
    self.lab_content.font = [UIFont systemFontOfSize:15];
}
@end
