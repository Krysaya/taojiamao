
//
//  TJClassicFirstCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassicFirstCell.h"
#import "TJGoodCatesMainListModel.h"

@interface TJClassicFirstCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab_message;


@end

@implementation TJClassicFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.lab_select.hidden = NO;
        self.lab_message.textColor = KALLRGB;
    }else{
        self.lab_select.hidden = YES;
        self.lab_message.textColor = RGB(51, 51, 51);
    }
    // Configure the view for the selected state
}

- (void)setModel:(TJGoodCatesMainListModel *)model{
    
    self.lab_message.text = model.catname;
    
}
@end
