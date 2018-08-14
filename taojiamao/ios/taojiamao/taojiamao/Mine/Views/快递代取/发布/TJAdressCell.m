
//
//  TJAdressCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAdressCell.h"
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
    self.lab_name.text = model.name;
    self.lab_phone.text = model.shou_telephone;
    self.lab_songAddress.text = [NSString stringWithFormat:@"[送件地址]%@",model.song_address];
}
@end
