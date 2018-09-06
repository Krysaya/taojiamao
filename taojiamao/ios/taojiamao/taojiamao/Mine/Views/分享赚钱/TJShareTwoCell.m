
//
//  TJShareTwoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJShareTwoCell.h"
#import "TJGoodsCollectModel.h"
@interface TJShareTwoCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_price;

@property (weak, nonatomic) IBOutlet UILabel *lab_yimai;


@end

@implementation TJShareTwoCell

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
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.itempic] placeholderImage:[UIImage imageNamed:@"goods_bg.jpg"]];
    UIImage *imgs;
    if ([model.shoptype isEqualToString:@"B"]) {
        imgs = [UIImage imageNamed:@"tb_bs"];
    }else{
        imgs = [UIImage imageNamed:@"tm_bs"];
    }
    NSAttributedString *str_tb = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insertImage(imgs, 0, CGPointMake(0, 0), CGSizeMake(26, 13));
        make.insertText(@" ", 1);
        make.insertText(model.itemtitle, 2);
    });
    self.lab_title.attributedText = str_tb;
    self.lab_price.text = [NSString stringWithFormat:@"到手价:¥ %@",model.itemendprice];

    self.lab_yimai.text = [NSString stringWithFormat:@"%@人已买",model.itemsale];
}
@end
