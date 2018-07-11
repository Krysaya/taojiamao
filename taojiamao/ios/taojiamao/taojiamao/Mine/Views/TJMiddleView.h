//
//  TJMiddleView.h
//  taojiamao
//
//  Created by yueyu on 2018/7/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJMiddleViewDelegate <NSObject>

- (void)buttonClick:(UIButton *)btn;

@end

@interface TJMiddleView : UIView
@property (nonatomic,   weak) id<TJMiddleViewDelegate> delegte;
@end
