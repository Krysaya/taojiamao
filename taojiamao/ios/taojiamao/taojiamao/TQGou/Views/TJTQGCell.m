
//
//  TJTQGCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTQGCell.h"
#import "TJTqgGoodsModel.h"

@interface TJTQGCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_yq;
@property (weak, nonatomic) IBOutlet UIProgressView *pg_yq;
@property (weak, nonatomic) IBOutlet UILabel *lab_xprice;
@property (weak, nonatomic) IBOutlet UILabel *lab_yprice;
@property (weak, nonatomic) IBOutlet UIButton *btn_qiang;
@property (weak, nonatomic) IBOutlet UIButton *btn_fen;


@end


@implementation TJTQGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJTqgGoodsModel *)model{
    _model = model;
    
    self.lab_xprice.text = model.zk_final_price;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribt_yuanj = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model.reserve_price] attributes:attribtDic];
    
    self.lab_yprice.attributedText = attribt_yuanj;
    
    [self.img sd_setImageWithURL: [NSURL URLWithString:model.pic_url]];
    
    NSAttributedString *string = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insertImage([UIImage imageNamed:@"tb_bs"], 0, CGPointMake(0, 0), CGSizeMake(27, 13));
        make.insertText(@" ", 1);
        make.insertText(model.title, 2);
    });
    self.lab_title.attributedText = string;
    
    NSString *str  = [NSString stringWithFormat:@"已抢%@件",model.sold_num];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:nil];
    NSArray *numArr = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str  attributes:@{NSForegroundColorAttributeName:KALLRGB}];
    for (NSTextCheckingResult *attirbute in numArr) {
        
        [attributedString setAttributes:@{NSForegroundColorAttributeName:RGB(51, 51, 51)} range:attirbute.range];
        
    }
    self.lab_yq.attributedText = attributedString;
    
    //    NSString *quan = [NSString stringWithFormat:@"领券减%@",model.couponmoney];
    //    [self.btn_quan setTitle:quan forState:UIControlStateNormal];
    
//  CGFloat  pg = (float)(model.sold_num)/(float)(model.total_amount);
    
}


@end