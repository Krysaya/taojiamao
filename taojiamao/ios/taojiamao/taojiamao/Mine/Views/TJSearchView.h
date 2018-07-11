//
//  TJSearchView.h
//  taojiamao
//
//  Created by yueyu on 2018/5/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol TJSearchViewDelegate<NSObject>

-(void)SearchButtonClick:(NSString*)text;

@end


@interface TJSearchView : UIView

@property(nonatomic,assign)id<TJSearchViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString*)plac title:(NSString*)text;

@end
