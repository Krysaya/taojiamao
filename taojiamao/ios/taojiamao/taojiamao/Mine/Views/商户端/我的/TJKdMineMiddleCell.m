
//
//  TJKdMineMiddleCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMineMiddleCell.h"
#import "TJKdAgentsInfoModel.h"
@interface TJKdMineMiddleCell()
@property (weak, nonatomic) IBOutlet UIImageView *img_line;
@property (weak, nonatomic) IBOutlet UIImageView *img_lineteo;
@property (weak, nonatomic) IBOutlet UILabel *lab_dan;
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UIImageView *img_one;
@property (weak, nonatomic) IBOutlet UIButton *btn_by;
@property (weak, nonatomic) IBOutlet UIButton *btn_jr;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation TJKdMineMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectBtn = self.btn_jr;
    self.img_lineteo.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(UIButton *)sender {
//    14   15
    if (sender.tag==14) {
        self.img_one.hidden = NO;
        self.selectBtn = self.btn_jr;
        self.img_lineteo.hidden = YES;

    }else if (sender.tag==15) {
        self.img_lineteo.hidden = NO;
        self.img_one.hidden = YES;
        self.selectBtn = self.btn_by;

    }
}
- (void)setModel:(TJKdAgentsInfoModel *)model{
    _model = model;
    if (self.selectBtn==self.btn_jr) {
        self.lab_dan.text = [NSString stringWithFormat:@"%@",model.today_dan];
        self.lab_money.text = [NSString stringWithFormat:@"%@",model.today_money];
    }else{
        self.lab_dan.text = [NSString stringWithFormat:@"%@",model.month_dan];
        self.lab_money.text = [NSString stringWithFormat:@"%@",model.month_money];
    }
}
@end
