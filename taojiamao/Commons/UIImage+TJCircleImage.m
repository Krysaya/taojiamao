//
//  UIImage+TJCircleImage.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "UIImage+TJCircleImage.h"

@implementation UIImage (TJCircleImage)

- (void)lb_cornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)c completed:(void (^)(UIImage *image))completed {
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
       
        int w = size.width * self.scale;
        int h = size.height * self.scale;
        CGRect rect = CGRectMake(0, 0, w, h);
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:c] addClip];
        [self drawInRect:rect];
        UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completed) {
                completed(ret);
            }
        });
        return ;
//        // 1.利用绘图，建立上下文
//        UIGraphicsBeginImageContextWithOptions(size,YES,0);
//        
//        CGRect rect =CGRectMake(0,0, size.width, size.height);
//        
//        // 2.设置被裁切的部分的填充颜色
//        [fillColor setFill];
//        UIRectFill(rect);
//
//        // 3.利用贝塞尔路径实现裁切效果
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//
//        [path addClip];
//
//        // 4.绘制图像
//        [self drawInRect:rect];
//
//        // 5.取得结果
//        UIImage *result =UIGraphicsGetImageFromCurrentImageContext();
//
//        // 6.关闭上下文
//        UIGraphicsEndImageContext();
//
//
//        // 7.使用回调，返回结果
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (completed) {
//                completed(result);
//            }
//        });
        
    });
    
}

@end
