//
//  TJAgentPayView.h
//  taojiamao
//
//  Created by yueyu on 2018/9/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PayTypeBtnDelegate <NSObject>
-(void)payTypeButtonClick:(NSInteger)sender;

@end
@interface TJAgentPayView : UIView
- (instancetype)initWithFrame:(CGRect)frame withMoney:(NSString *)str;
+(instancetype)invitationView;
@property (nonatomic,assign)id<PayTypeBtnDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btn_pay;
@end

NS_ASSUME_NONNULL_END
