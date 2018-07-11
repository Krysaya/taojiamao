//
//  TJLabel.m
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJLabel.h"

@implementation TJLabel

+(instancetype)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    TJLabel*label =  [[TJLabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    label.textInsets =UIEdgeInsetsZero;
    return  label;
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
