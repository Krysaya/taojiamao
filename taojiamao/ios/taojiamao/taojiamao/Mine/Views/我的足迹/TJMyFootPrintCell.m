//
//  TJMyFootPrintCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMyFootPrintCell.h"
#import "TJGoodsInfoListModel.h"
@interface TJMyFootPrintCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_quanhou;
@property (weak, nonatomic) IBOutlet UILabel *lab_yaunjia;
@property (weak, nonatomic) IBOutlet UIButton *btn_quan;

@end


@implementation TJMyFootPrintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TJGoodsInfoListModel *)model{
    
    NSAttributedString *string = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insertImage([UIImage imageNamed:@"tb_bs"], 0, CGPointMake(0, 0), CGSizeMake(27, 13));
        make.insertText(@" ", 1);
        make.insertText(model.itemtitle, 2);
    });
    self.lab_title.attributedText = string;
    [self.img sd_setImageWithURL: [NSURL URLWithString:model.itempic]];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model.itemprice] attributes:attribtDic];
    self.lab_yaunjia.attributedText = attribtStr;
    NSString *str = [NSString stringWithFormat:@"券后：¥%@",model.itemendprice];
    NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.font([UIFont systemFontOfSize:12.f]).textColor(KALLRGB);
        make.append(str);
        make.rangeEdit(NSMakeRange(4, model.itemendprice.length), ^(SJAttributesRangeOperator * _Nonnull make) {
            make.font([UIFont systemFontOfSize:17.f]).textColor(KALLRGB);
        });
    });
    self.lab_quanhou.attributedText = attrStr;
     [self.btn_quan setTitle:[NSString stringWithFormat:@"领券减%@",model.couponmoney] forState:UIControlStateNormal];
}
@end
