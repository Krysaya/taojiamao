
//
//  TJDafultGoodsTitlesCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJDafultGoodsTitlesCell.h"
#import "TJJHSGoodsListModel.h"
@interface TJDafultGoodsTitlesCell()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_Ad;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_price;
@property (weak, nonatomic) IBOutlet UILabel *lab_prime;
@property (weak, nonatomic) IBOutlet UILabel *lab_totalprenson;
@property (weak, nonatomic) IBOutlet UILabel *lab_couponmoneny;
@property (weak, nonatomic) IBOutlet UIImageView *img_bs;
@property (weak, nonatomic) IBOutlet UIView *view_yz;
@property (weak, nonatomic) IBOutlet UILabel *lab_tkmoney;


@end

@implementation TJDafultGoodsTitlesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel_detail:(TJJHSGoodsListModel *)model_detail{
    
    _model_detail = model_detail;
    if ([[TJAppManager sharedTJAppManager].urbate.show_type isEqual:@"1"]) {
        DSLog(@"--不显示");
        self.view_yz.hidden = YES;
    }else if ([[TJAppManager sharedTJAppManager].urbate.show_type isEqual:@"2"]){
        self.view_yz.hidden = NO;
        self.lab_tkmoney.text = [NSString stringWithFormat:@"%@",model_detail.rebate];
        
    }else{
        self.view_yz.hidden = NO;
        self.lab_tkmoney.text = [NSString stringWithFormat:@"¥%.2f",[model_detail.rebate floatValue]/100];
    }
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 375)];
    [img sd_setImageWithURL:[NSURL URLWithString:model_detail.itempic] placeholderImage:[UIImage imageNamed:@"goods_bg.jpg"]];
    if ([model_detail.shoptype isEqualToString:@"B"]) {
        [self.img_bs setImage: [UIImage imageNamed:@"tb_bs"]];
    }else{
        [self.img_bs setImage: [UIImage imageNamed:@"tm_bs"]];

    }
    
    [self.scroll_Ad addSubview:img];
    
    self.lab_title.text = model_detail.itemtitle;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model_detail.itemprice] attributes:attribtDic];
    self.lab_prime.attributedText = attribtStr;
    self.lab_price.text = model_detail.itemendprice;
    self.lab_couponmoneny.text = [NSString stringWithFormat:@"%@元优惠券",model_detail.couponmoney];
    self.lab_totalprenson.text  = [NSString stringWithFormat:@"%@人已买",model_detail.itemsale];
    
}
@end
