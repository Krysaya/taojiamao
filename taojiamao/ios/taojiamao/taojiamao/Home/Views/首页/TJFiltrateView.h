//
//  TJFiltrateView.h
//  taojiamao
//
//  Created by yueyu on 2018/5/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJFiltrateViewDelegate<NSObject>

-(void)popupFiltrateView;

-(void)requestWithKind:(NSString*)kind;

@end

@interface TJFiltrateView : UIView

@property(nonatomic,assign)id<TJFiltrateViewDelegate>deletage;

-(instancetype)initWithFrame:(CGRect)frame withMargin:(CGFloat)margin;

@end
