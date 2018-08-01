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
    self.lab_title.text = model.title;
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[model.images  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    self.lab_pinglun.text = [NSString stringWithFormat:@"%@评论",model.comment_num];
    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    
  
}
@end
