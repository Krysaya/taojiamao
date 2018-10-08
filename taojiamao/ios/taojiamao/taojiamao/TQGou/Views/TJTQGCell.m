
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
@property (weak, nonatomic) IBOutlet UILabel *lab_tkmoney;



@end


@implementation TJTQGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btn_fen.layer.borderColor = KALLRGB.CGColor;
    self.btn_fen.layer.borderWidth = 0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJTqgGoodsModel *)model{
    _model = model;
    if ([[TJAppManager sharedTJAppManager].urbate.show_type isEqual:@"1"]) {
        DSLog(@"--不显示");
        self.lab_tkmoney.hidden = YES;
    }else if ([[TJAppManager sharedTJAppManager].urbate.show_type isEqual:@"2"]){
        self.lab_tkmoney.hidden = NO;
        self.lab_tkmoney.text = [NSString stringWithFormat:@"约赚 %@",model.rebate];
        
    }else{
        self.lab_tkmoney.hidden = NO;
        self.lab_tkmoney.text = [NSString stringWithFormat:@"约赚¥%.2f",[model.rebate floatValue]/100];
    }
    self.pg_yq.progress = [model.sold_num floatValue]/[model.total_amount floatValue];
    self.lab_xprice.text = model.zk_final_price;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribt_yuanj = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model.reserve_price] attributes:attribtDic];
    
    self.lab_yprice.attributedText = attribt_yuanj;
    
    [self.img sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@_300x300",model.pic_url]] placeholderImage:[UIImage imageNamed:@"good_bg.jpg"]];
    
    NSAttributedString *string = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insertImage([UIImage imageNamed:@"tb_bs"], 0, CGPointMake(0, 0), CGSizeMake(23, 11));
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
- (void)setType:(NSString *)type{
    _type = type;
    if ([type intValue]==0) {
//        [self.btn_fen setTitle:@"" forState:UIControlStateNormal];
        [self.btn_qiang setBackgroundColor:KALLRGB];
        [self.btn_qiang setTitle:@"立即抢" forState:UIControlStateNormal];
    }else{
        self.pg_yq.hidden = YES;
        self.lab_yq.hidden = YES;
        [self.btn_qiang setTitle:@"稍后抢" forState:UIControlStateNormal];
        [self.btn_qiang setBackgroundColor:RGB(88, 213, 45)];
    }
}

@end
