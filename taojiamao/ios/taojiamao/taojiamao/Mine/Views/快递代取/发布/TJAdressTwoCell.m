
//
//  TJAdressTwoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAdressTwoCell.h"
#import "TJKdOrderInfoModel.h"
#import "TJKdQuAddressModel.h"
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
- (void)setType:(NSString *)type{
    _type = type;
    if ([type isEqualToString:@"fb"]) {
        self.lab_quAddress.text = @"请选择取件地址";
    }
}
- (void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    self.lab_quAddress.text = [NSString stringWithFormat:@"[取件地址]%@",model.qu_address];
}
- (void)setM_qu:(TJKdQuAddressModel *)m_qu{
    _m_qu = m_qu;
    if (m_qu==nil) {
        self.lab_quAddress.text = @"请选择取件地址";
    }else{
        self.lab_quAddress.text = [NSString stringWithFormat:@"[取件地址]%@",m_qu.address];}
}
@end
