//
//  TJContentListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentListCell.h"
#import "TJContetenCollectListModel.h"
@interface TJContentListCell()
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UIButton *select_btn;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBtnLeading;
// 如果要整体右移这个值也改下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewTrailing;

@end

@implementation TJContentListCell

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
    _select_btn.selected = model.isChecked;
    self.title_lab.text = model.title;
    self.lab_from.text = model.source;
    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    self.lab_pinglun.text = [NSString stringWithFormat:@"%@人评论",model.comment_num];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.thumb]];

}



@end
