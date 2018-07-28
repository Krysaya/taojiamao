//
//  TJJHSuanCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJJHSuanCell.h"
#import "TJJHSGoodsListModel.h"
#import "UIImageView+WebCache.h"
@interface TJJHSuanCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *tb_img;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *yimai_lab;
@property (weak, nonatomic) IBOutlet UILabel *quanhou_lab;
@property (weak, nonatomic) IBOutlet UIButton *btn_quan;


@end

@implementation TJJHSuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TJJHSGoodsListModel *)model{
    self.title_lab.text = model.title;
//    self.yimai_lab.text =
    NSString *str = [NSString stringWithFormat:@"券后：¥%@",model.price];
    NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.font([UIFont systemFontOfSize:12.f]).textColor(KALLRGB);
        make.append(str);
        make.rangeEdit(NSMakeRange(4, model.price.length), ^(SJAttributesRangeOperator * _Nonnull make) {
            make.font([UIFont systemFontOfSize:17.f]).textColor(KALLRGB);
        });
    });
    self.quanhou_lab.attributedText = attrStr;
    [self.btn_quan setTitle:[NSString stringWithFormat:@"领券减%@",model.coupon_money] forState:UIControlStateNormal];

    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",model.thumb]] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
}
@end
