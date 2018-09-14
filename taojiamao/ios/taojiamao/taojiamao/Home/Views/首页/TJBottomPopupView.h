//
//  TJBottomPopupView.h
//  taojiamao
//
//  Created by yueyu on 2018/5/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJBottomPopupViewDelegate<NSObject>

-(void)clickViewRemoveFromSuper;
- (void)buttonCopyClick;
@end

@interface TJBottomPopupView : UIView

@property(nonatomic,assign)id<TJBottomPopupViewDelegate>deletage;

-(instancetype)initWithFrame:(CGRect)frame select:(CGFloat)select height:(CGFloat)h info:(id)info;

@end
