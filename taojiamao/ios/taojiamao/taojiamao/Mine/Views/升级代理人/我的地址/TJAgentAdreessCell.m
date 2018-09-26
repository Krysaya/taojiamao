
//
//  TJAgentAdreessCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAgentAdreessCell.h"
#import "TJMyAddressModel.h"
@interface TJAgentAdreessCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;
@property (weak, nonatomic) IBOutlet UILabel *lab_phone;

@end

@implementation TJAgentAdreessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJMyAddressModel *)model{
    _model = model;
    self.lab_name.text = model.name;
    self.lab_phone.text = model.telephone;
    self.lab_content.text = model.address;
}

@end
