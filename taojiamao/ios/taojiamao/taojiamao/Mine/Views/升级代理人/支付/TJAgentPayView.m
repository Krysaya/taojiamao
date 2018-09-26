
//
//  TJAgentPayView.m
//  taojiamao
//
//  Created by yueyu on 2018/9/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAgentPayView.h"
@interface TJAgentPayView()
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UIButton *btn_yue;
@property (weak, nonatomic) IBOutlet UIButton *btn_zfb;


@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation TJAgentPayView
+(instancetype)invitationView{

    return [[[NSBundle mainBundle] loadNibNamed:@"TJAgentPayView"
                                          owner:nil options:nil]lastObject];
}
- (instancetype)initWithFrame:(CGRect)frame withMoney:(NSString *)str
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TJAgentPayView"
                                              owner:nil options:nil]lastObject];
        self.frame = frame;
//        self.selectBtn.selected = YES;
        self.selectBtn = self.btn_yue;
        self.lab_money.text = [NSString  stringWithFormat:@"¥ %@",str];
    }
    return self;
}
- (IBAction)chooseButtonClick:(UIButton *)sender {
    if (self.delegate) {
        [self.delegate payTypeButtonClick:sender.tag];
    }
    
    if (!sender.selected) {
        self.selectBtn.selected = !self.selectBtn.selected;
        sender.selected = !sender.selected;
        self.selectBtn = sender;
    }
    
}
- (IBAction)closeButtonClick:(UIButton *)sender {
    [self removeFromSuperview];
}
//- (IBAction)payButtonClick:(UIButton *)sender {
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
