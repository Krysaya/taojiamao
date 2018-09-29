
//
//  TJHPFindCell.m
//  taojiamao
//
//  Created by yueyu on 2018/9/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHPFindCell.h"
#import "TJHPFindModel.h"
#import "TJHPFindGoodsModel.h"
@interface TJHPFindCell()
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UIButton *btn_one;
@property (weak, nonatomic) IBOutlet UIButton *btn_two;
@property (weak, nonatomic) IBOutlet UIButton *btn_three;
@property (weak, nonatomic) IBOutlet UIButton *btn_four;
@property (weak, nonatomic) IBOutlet UIButton *btn_five;
@property (weak, nonatomic) IBOutlet UIButton *btn_six;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewHeight;



@end

@implementation TJHPFindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn_buy.layer.borderWidth = 1;
    self.btn_buy.layer.borderColor = [UIColor darkTextColor].CGColor;

}
- (IBAction)btnClick:(UIButton *)sender {
    [self.delegate imgClickWithIndex:sender];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJHPFindModel *)model{
    _model = model;
    self.lab_time.text = model.created_time;
    self.lab_name.text = model.name;
    self.lab_content.text = model.content;
    [self.img_head sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage: [UIImage imageNamed:@"morentouxiang"]];
    if (model.good.count<=3) {
        
        self.imgViewHeight.constant = 0;
    }else{
        self.imgViewHeight.constant = 100;
    }
    
    for (int i=0; i<model.good.count; i++) {
//        if (i+1>model.good.count) {
//        }else{
            if (i==0) {
                TJHPFindGoodsModel *m = model.good[i];
                [self.btn_one sd_setImageWithURL:[NSURL URLWithString:m.itempic] forState:UIControlStateNormal];
            } else if (i==1) {
                TJHPFindGoodsModel *m = model.good[i];
               [self.btn_two sd_setImageWithURL:[NSURL URLWithString:m.itempic] forState:UIControlStateNormal];
            }else if (i==2) {
                TJHPFindGoodsModel *m = model.good[i];
                 [self.btn_three sd_setImageWithURL:[NSURL URLWithString:m.itempic] forState:UIControlStateNormal];
            }else if (i==3) {
                TJHPFindGoodsModel *m = model.good[i];
                [self.btn_four sd_setImageWithURL:[NSURL URLWithString:m.itempic] forState:UIControlStateNormal];
            }else if (i==4) {
                TJHPFindGoodsModel *m = model.good[i];
                [self.btn_five sd_setImageWithURL:[NSURL URLWithString:m.itempic] forState:UIControlStateNormal];
            }else if (i==5) {
                TJHPFindGoodsModel *m = model.good[i];
                [self.btn_six sd_setImageWithURL:[NSURL URLWithString:m.itempic] forState:UIControlStateNormal];
            }
            
        }
//    }
}
@end
