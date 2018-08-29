
//
//  TJCommentsSendView.m
//  taojiamao
//
//  Created by yueyu on 2018/8/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCommentsSendView.h"
@interface TJCommentsSendView()
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UIButton *btn_send;


@end
@implementation TJCommentsSendView


+(instancetype)commentsSendView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TJCommentsSendView"
                                          owner:nil options:nil]lastObject];
}
- (IBAction)sendBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sendButtonClick:) ]) {
        [self.delegate sendButtonClick:self.tf.text];
    }
}
- (IBAction)cancelBtnClick:(id)sender {
    self.hidden = YES;
}



@end
