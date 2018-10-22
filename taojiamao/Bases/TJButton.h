//
//  TJButton.h
//  taojiamao
//
//  Created by yueyu on 2018/5/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TJButtonDelegate<NSObject>

-(void)buttonClick:(UIButton*)but;

@end

@interface TJButton : UIView

@property(nonatomic,copy)NSString * title;

-(instancetype)initDelegate:(id<TJButtonDelegate>)dele backColor:(UIColor*)bc tag:(NSInteger)tag withBackImage:(NSString*)image;

-(instancetype)initWith:(NSString*)title delegate:(id<TJButtonDelegate>)dele font:(CGFloat)font titleColor:(UIColor*)color backColor:(UIColor*)bc tag:(NSInteger)tag;

-(instancetype)initWith:(NSString*)title delegate:(id<TJButtonDelegate>)dele font:(CGFloat)font titleColor:(UIColor*)color backColor:(UIColor*)bc tag:(NSInteger)tag cornerRadius:(CGFloat)cor;

-(instancetype)initWith:(NSString*)title delegate:(id<TJButtonDelegate>)dele font:(CGFloat)font titleColor:(UIColor*)color backColor:(UIColor*)bc tag:(NSInteger)tag cornerRadius:(CGFloat)cor borderColor:(UIColor*)bcolor  borderWidth:(CGFloat)bw withBackImage:(NSString*)image;

@end
