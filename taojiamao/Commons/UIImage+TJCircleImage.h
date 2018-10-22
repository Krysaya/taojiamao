//
//  UIImage+TJCircleImage.h
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TJCircleImage)

/**
 *根据当前图像，和指定的尺寸，生成圆角图像并且返回
 * return圆角图像
 */
- (void)lb_cornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)c completed:(void (^)(UIImage *image))completed;

@end
