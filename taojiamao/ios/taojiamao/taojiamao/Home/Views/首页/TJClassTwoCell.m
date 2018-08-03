//
//  TJClassTwoCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassTwoCell.h"
#import "TJHomePageModel.h"
@interface TJClassTwoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;


@end

@implementation TJClassTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TJHomePageModel *)model{
    _model = model;
    [self.img sd_setImageWithURL: [NSURL URLWithString:model.imgurl]];
}
@end
