//
//  TJHeadLineOneCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineOneCell.h"
#import "TJArticlesListModel.h"
@interface TJHeadLineOneCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIImageView *img_one;
@property (weak, nonatomic) IBOutlet UIImageView *img_two;
@property (weak, nonatomic) IBOutlet UIImageView *img_three;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;


@end

@implementation TJHeadLineOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TJArticlesListModel *)model{
    _model = model;
    self.lab_title.text = model.title;
    self.lab_from.text = model.source;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[model.images dataUsingEncoding:NSUTF8StringEncoding]    options:NSJSONReadingMutableContainers  error:nil];
    NSDictionary *dict1 = arr[0];
    NSDictionary *dict2 = arr[1];
    NSDictionary *dict3 = arr[2];
    [self.img_one sd_setImageWithURL: [NSURL URLWithString:dict1[@"url"]]];
    [self.img_two sd_setImageWithURL: [NSURL URLWithString:dict2[@"url"]]];
    [self.img_three sd_setImageWithURL: [NSURL URLWithString:dict3[@"url"]]];

    self.lab_pinglun.text = [NSString stringWithFormat:@"%@评论",model.comment_num];
    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    
  
}
@end
