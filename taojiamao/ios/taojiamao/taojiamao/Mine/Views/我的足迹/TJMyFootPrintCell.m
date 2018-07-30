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
    self.lab_title.text = model.itemtitle;
    
}
@end
