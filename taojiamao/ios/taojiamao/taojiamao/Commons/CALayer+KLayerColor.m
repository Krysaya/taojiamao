//
//  CALayer+KLayerColor.m
//  taojiamao
//
//  Created by yueyu on 2018/9/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "CALayer+KLayerColor.h"

@implementation CALayer (KLayerColor)
- (void)setBorderColorFromUIColor:(UIColor *)color {
     self.borderColor = color.CGColor;
}
@end
