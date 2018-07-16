
//
//  TJGoodsListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsListCell.h"
#import "TJGoodsCollectModel.h"
@interface TJGoodsListCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btn_quan;
@property (weak, nonatomic) IBOutlet UILabel *lab_quanh;
@property (weak, nonatomic) IBOutlet UILabel *lab_yuanjia;
@property (weak, nonatomic) IBOutlet UILabel *lab_yimai;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBtnLeading;
// 如果要整体右移这个值也改下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewTrailing;

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

- (void)cellWithArr:(NSArray *)arr forIndexPath:(NSIndexPath *)indexPath isEditing:(BOOL)editing
{
    if (editing) {
        NSLog(@"keyi--%d",editing);
        _checkBtnLeading.constant = 20.f;
        
        _rightViewTrailing.constant = -49.f;
    }else
    {
        _checkBtnLeading.constant = -29.f;
        
        _rightViewTrailing.constant = 0.f;
    }
    
    // 这里取出model， 根据model的是否选中属性，标记checkBtn的select状态，图标会自动转换
    
    TJGoodsCollectModel *model = [arr objectAtIndex:indexPath.row];
    _selectBtn.selected = model.isChecked;
    
}

@end
