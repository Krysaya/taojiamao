
//
//  TJPayTypeCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPayTypeCell.h"
@interface TJPayTypeCell()
@property (weak, nonatomic) IBOutlet UIButton *btn_zfb;
@property (weak, nonatomic) IBOutlet UIButton *btn_wx;
@property (weak, nonatomic) IBOutlet UIButton *btn_yue;

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSString *select_status;

@end


@implementation TJPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectBtn = self.btn_zfb;
}
- (IBAction)btnClick:(UIButton *)sender {
    if (!sender.selected) {
        self.selectBtn.selected = !self.selectBtn.selected;
        sender.selected = !sender.selected;
        self.selectBtn = sender;
    }

    if (self.selectBtn==_btn_zfb) {
        self.select_status = @"1";
    }else if(self.selectBtn==_btn_wx){
        self.select_status = @"2";
    }else{
        self.select_status = @"3";
    }
    
    
    if (self.deletage && [self.deletage respondsToSelector:@selector(selectClickWithBtnStatus:)]) {
        
        [self.deletage selectClickWithBtnStatus:self.select_status];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
