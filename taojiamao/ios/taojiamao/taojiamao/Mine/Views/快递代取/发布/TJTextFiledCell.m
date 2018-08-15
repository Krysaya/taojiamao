//
//  TJTextFiledCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTextFiledCell.h"
@interface TJTextFiledCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;


@end

@implementation TJTextFiledCell

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
    if ([type integerValue]==2) {
        self.lab_title.text = @"运单编号:";
        self.tf.placeholder = @"请输入商品运单编号";
    }else if ([type integerValue]==3){
        self.lab_title.text = @"取件码:";
        self.tf.placeholder = @"请输入取件码";
    }else{
        self.lab_title.text = @"送件地址:";
        self.tf.placeholder = @"请选择时间";
    }
}
@end
