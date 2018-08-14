
//
//  TJAdressTwoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAdressTwoCell.h"
#import "TJKdOrderInfoModel.h"
@interface TJAdressTwoCell()
//@property (weak, nonatomic) IBOutlet UIImageView *img;
//@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UILabel *lab_quAddress;


@end

@implementation TJAdressTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    self.lab_quAddress.text = [NSString stringWithFormat:@"[取件地址]%@",model.qu_address];
}
@end
