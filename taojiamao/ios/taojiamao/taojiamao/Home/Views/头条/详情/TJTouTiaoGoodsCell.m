
//
//  TJTouTiaoGoodsCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTouTiaoGoodsCell.h"
#import "TJGoodsCollectModel.h"
@interface TJTouTiaoGoodsCell()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_quanhoujia;
@property (weak, nonatomic) IBOutlet UILabel *lab_ym;

@end

@implementation TJTouTiaoGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJGoodsCollectModel *)model{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.itempic] placeholderImage:[UIImage imageNamed:@"good_bg"]];
    self.lab_ym.text = [NSString stringWithFormat:@"%@人已买",model.itemsale];
    self.lab_quanhoujia.text = model.itemendprice;
    self.lab_title.text = model.itemtitle;
}
@end
