
//
//  TJAdressCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAdressCell.h"
#import "TJMyAddressModel.h"
#import "TJKdOrderInfoModel.h"
@interface TJAdressCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_phone;
@property (weak, nonatomic) IBOutlet UILabel *lab_songAddress;


@end

@implementation TJAdressCell

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
    self.lab_name.text = model.shou_username;
    self.lab_phone.text = model.shou_telephone;
    self.lab_songAddress.text = [NSString stringWithFormat:@"[送件地址]%@",model.song_address];
}

- (void)setType:(NSString *)type{
    _type = type;
    if ([type isEqualToString:@"fb"]) {
        self.lab_songAddress.text = @"请选择送件地址";
    }
}
- (void)setM_fb:(TJMyAddressModel *)m_fb{
    _m_fb = m_fb;
    if (m_fb==nil) {
        self.lab_name.text = @"";
        self.lab_phone.text = @"";
        self.lab_songAddress.text = @"请选择送件地址";

    }else{
        self.lab_name.text = [NSString stringWithFormat:@"%@",m_fb.name];
        self.lab_phone.text = [NSString stringWithFormat:@"%@",m_fb.telephone];
        self.lab_songAddress.text = [NSString stringWithFormat:@"[送件地址]%@",m_fb.address];
    }
}
@end
