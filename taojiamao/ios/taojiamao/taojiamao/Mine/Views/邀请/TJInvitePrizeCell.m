
//
//  TJInvitePrizeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJInvitePrizeCell.h"
#import "TJGoodsCollectModel.h"
@interface TJInvitePrizeCell()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_qhprice;
@property (weak, nonatomic) IBOutlet UILabel *lab_yjprice;

@end

@implementation TJInvitePrizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TJGoodsCollectModel *)model{
    _model = model;
    self.lab_title.text = model.itemtitle;
    self.lab_qhprice.text = model.itemendprice;
    self.lab_yjprice.text = [NSString stringWithFormat:@"¥ %@",model.itemprice];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.itempic] placeholderImage:[UIImage imageNamed:@"goods_bg.jpg"]];
}
@end
