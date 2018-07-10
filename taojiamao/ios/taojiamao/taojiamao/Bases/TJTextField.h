//
//  TJTextField.h
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TJTextField:UITextField

+(instancetype)setTextFieldWith:(NSString*)placeholder font:(CGFloat)font textColor:(UIColor*)tc;
+(instancetype)setTextFieldWith:(NSString*)placeholder font:(CGFloat)font textColor:(UIColor*)tc backColor:(UIColor*)bc;
+(instancetype)setTextFieldWith:(NSString*)placeholder textFont:(CGFloat)font textColor:(UIColor*)tc backColor:(UIColor*)bc placeholderFont:(CGFloat)pfont;

@end
