//
//  TJTextField.m
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTextField.h"

@implementation TJTextField

+(instancetype)setTextFieldWith:(NSString*)placeholder font:(CGFloat)font textColor:(UIColor*)tc{
    return [self setTextFieldWith:placeholder textFont:font textColor:tc backColor:nil placeholderFont:0];
}

+(instancetype)setTextFieldWith:(NSString*)placeholder font:(CGFloat)font textColor:(UIColor*)tc backColor:(UIColor*)bc{
   
    return [self setTextFieldWith:placeholder textFont:font textColor:tc backColor:bc placeholderFont:0];
}
+(instancetype)setTextFieldWith:(NSString*)placeholder textFont:(CGFloat)font textColor:(UIColor*)tc backColor:(UIColor*)bc placeholderFont:(CGFloat)pfont{
    
    TJTextField * textF = [[TJTextField alloc]init];
    textF.font = [UIFont systemFontOfSize:font];
    if (pfont==0) {
        textF.placeholder = placeholder;

    }else{
        NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:placeholder];
        [temp addAttribute:NSForegroundColorAttributeName value:tc range:NSMakeRange(0, placeholder.length)];
        [temp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:pfont] range:NSMakeRange(0, placeholder.length)];
        textF.attributedPlaceholder = temp;

    }
    textF.textColor = tc;
    textF.backgroundColor = bc;
    return textF;
}

//缩进
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , 10 , 0 );
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , 10 , 0 );
//}
@end
