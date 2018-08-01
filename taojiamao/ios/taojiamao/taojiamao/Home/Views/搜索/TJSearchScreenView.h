//
//  TJSearchScreenView.h
//  taojiamao
//
//  Created by yueyu on 2018/7/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TJSearchScreenViewDelegate<NSObject>

-(void)superPopupFiltrateView;

-(void)superRequestWithKind:(NSString*)kind;

@end

@interface TJSearchScreenView : UIView
@property(nonatomic,assign)id<TJSearchScreenViewDelegate>deletage;
-(instancetype)initWithFrame:(CGRect)frame withMargin:(CGFloat)margin;

@end
