
//
//  TJThreeImageCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJThreeImageCell.h"
#import "TJContetenCollectListModel.h"

@interface TJThreeImageCell()
@property (weak, nonatomic) IBOutlet UIButton *btn_check;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_pl;
@property (weak, nonatomic) IBOutlet UILabel *lab_like;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBtnLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewTrailing;
@end

@implementation TJThreeImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cellWithArr:(NSArray *)arr forIndexPath:(NSIndexPath *)indexPath isEditing:(BOOL)editing
{
    if (editing) {
        
        _checkBtnLeading.constant = 20.f;
        
        _rightViewTrailing.constant = -49.f;
    }else
    {
        _checkBtnLeading.constant = -29.f;
        
        _rightViewTrailing.constant = 0.f;
    }
    // 这里取出model， 根据model的是否选中属性，标记checkBtn的select状态，图标会自动转换
    TJContetenCollectListModel *model = [arr objectAtIndex:indexPath.row];
    _btn_check.selected = model.isChecked;
    self.lab_title.text = model.title;
    self.lab_from.text = model.source;
    self.lab_like.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    self.lab_pl.text = [NSString stringWithFormat:@"%@人评论",model.comment_num];
    
    
    NSArray *arrimg = [NSJSONSerialization JSONObjectWithData:[model.images dataUsingEncoding:NSUTF8StringEncoding]    options:NSJSONReadingMutableContainers  error:nil];
    NSDictionary *dict1 = arrimg[0];
    NSDictionary *dict2 = arrimg[1];
    NSDictionary *dict3 = arrimg[2];
    [self.img1 sd_setImageWithURL: [NSURL URLWithString:dict1[@"url"]]];
    [self.img2 sd_setImageWithURL: [NSURL URLWithString:dict2[@"url"]]];
    [self.img3 sd_setImageWithURL: [NSURL URLWithString:dict3[@"url"]]];

    
}
@end
