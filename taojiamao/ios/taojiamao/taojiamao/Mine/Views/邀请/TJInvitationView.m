
//
//  TJInvitationView.m
//  taojiamao
//
//  Created by yueyu on 2018/7/20.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJInvitationView.h"

@interface TJInvitationView()
@property (weak, nonatomic) IBOutlet UIButton *btn_pyq;
@property (weak, nonatomic) IBOutlet UIButton *btn_wx;
@property (weak, nonatomic) IBOutlet UIButton *btn_qq;
@property (weak, nonatomic) IBOutlet UIButton *btn_qqaz;
@property (weak, nonatomic) IBOutlet UIButton *btn_sms;
@property (weak, nonatomic) IBOutlet UIButton *btn_link;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end


@implementation TJInvitationView
- (instancetype)initWithFrame:(CGRect)frame withTitile:(NSString *)title withsmsButtonImg:(NSString *)img
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TJInvitationView"
                                              owner:nil options:nil]lastObject];
        [self.btn_sms setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        self.lab_title.text = title;
    }
    return self;
}

+(instancetype)invitationView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TJInvitationView"
                                          owner:nil options:nil]lastObject];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
//    self.hidden = YES;
    [self removeFromSuperview];
}

- (IBAction)shareBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareButtonClick:) ]) {
        [self.delegate shareButtonClick:sender.tag];
    }
}


@end
