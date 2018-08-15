
//
//  TJKdQuAddressCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdQuAddressCell.h"
#import "TJKdQuAddressModel.h"
@interface TJKdQuAddressCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_addres;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;

@end

@implementation TJKdQuAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn_edit.hidden = YES;
    // Initialization code
    
}
- (void)setModel:(TJKdQuAddressModel *)model{
    _model = model;
    self.lab_addres.text = model.address;
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.deletage && [self.deletage respondsToSelector:@selector(editClick:)]) {
        [self.deletage editClick:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
