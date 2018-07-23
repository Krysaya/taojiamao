
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
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        //ARRewardView : 自定义的view名称
//        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"TJInvitationView"owner:self options:nil];
//        UIView *backView = [nibView objectAtIndex:0];
//        backView.frame = frame;
//        [self addSubview:backView];
//    }
//    return self;
//}

+(instancetype)invitationView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TJInvitationView"
                                          owner:nil options:nil]lastObject];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    self.hidden = YES;
}



@end
