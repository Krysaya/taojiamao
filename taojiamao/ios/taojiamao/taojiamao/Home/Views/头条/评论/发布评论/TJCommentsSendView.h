//
//  TJCommentsSendView.h
//  taojiamao
//
//  Created by yueyu on 2018/8/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SendBtnDelegate <NSObject>
-(void)sendButtonClick:(NSString *)text;

@end
@interface TJCommentsSendView : UIView
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIView *view_bg;
+(instancetype)commentsSendView;
@property (nonatomic,assign)id<SendBtnDelegate> delegate;

@end
