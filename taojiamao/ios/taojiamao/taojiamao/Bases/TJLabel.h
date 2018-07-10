//
//  TJLabel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJLabel : UILabel


@property (nonatomic, assign) UIEdgeInsets textInsets;

+(instancetype)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c;

@end
