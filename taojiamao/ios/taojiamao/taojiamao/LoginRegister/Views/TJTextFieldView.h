//
//  TJTextFieldView.h
//  taojiamao
//
//  Created by yueyu on 2018/5/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
//@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

//typedef void(^textFieldText)(NSString * string);

@interface TJTextFieldView : UIView

@property(nonatomic,copy)NSString * text;

//-(instancetype)initWithPlaceholder:(NSString*)plac image:(NSString*)image highlightImage:(NSString*)himage  with:(BOOL)securet;
-(instancetype)initWithPlaceholder:(NSString*)plac image:(NSString*)image highlightImage:(NSString*)himage with:(BOOL)securet;

@end
