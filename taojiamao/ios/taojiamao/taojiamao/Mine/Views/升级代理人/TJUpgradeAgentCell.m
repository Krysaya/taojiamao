
//
//  TJUpgradeAgentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJUpgradeAgentCell.h"
#import "TJUpgradeAgentModel.h"

@interface TJUpgradeAgentCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab_text;



@end

@implementation TJUpgradeAgentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TJUpgradeAgentModel *)model{
    _model = model;
    [self.img sd_setImageWithURL: [NSURL URLWithString:model.image]];
    
}
@end
