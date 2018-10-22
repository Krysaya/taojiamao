//
//  TJButton.m
//  taojiamao
//
//  Created by yueyu on 2018/5/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJButton.h"

@interface TJButton()
@property(nonatomic,weak)id<TJButtonDelegate>delegate;
@property(nonatomic,strong)UIButton * button;
@end

@implementation TJButton

-(instancetype)initDelegate:(id<TJButtonDelegate>)dele backColor:(UIColor*)bc tag:(NSInteger)tag withBackImage:(NSString*)image{
    return [self initWith:nil delegate:dele font:0.0 titleColor:nil backColor:bc tag:tag cornerRadius:0.0 borderColor:nil  borderWidth:0.0 withBackImage:image];
}

-(instancetype)initWith:(NSString*)title delegate:(id<TJButtonDelegate>)dele font:(CGFloat)font titleColor:(UIColor*)color backColor:(UIColor*)bc tag:(NSInteger)tag{
    
    return [self initWith:title delegate:dele font:font titleColor:color backColor:bc tag:tag cornerRadius:0.0 borderColor:nil  borderWidth:0.0 withBackImage:nil];
}

-(instancetype)initWith:(NSString*)title delegate:(id<TJButtonDelegate>)dele font:(CGFloat)font titleColor:(UIColor*)color backColor:(UIColor*)bc tag:(NSInteger)tag cornerRadius:(CGFloat)cor{
    
    return [self initWith:title delegate:dele font:font titleColor:color backColor:bc tag:tag cornerRadius:cor borderColor:nil  borderWidth:0.0 withBackImage:nil];
}

-(instancetype)initWith:(NSString*)title delegate:(id<TJButtonDelegate>)dele font:(CGFloat)font titleColor:(UIColor*)color backColor:(UIColor*)bc tag:(NSInteger)tag cornerRadius:(CGFloat)cor borderColor:(UIColor*)bcolor  borderWidth:(CGFloat)bw withBackImage:(NSString*)image{
    
    self = [super init];
    if (self) {
        self.delegate = dele;
        UIButton * but = [[UIButton alloc]init];
        but.tag = tag;
        [but addTarget:self action:@selector(logregClick:) forControlEvents:UIControlEventTouchUpInside];
//        [but setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [but setBackgroundColor:bc];
        [but setTitle:title forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:font];
        [but setTitleColor:color forState:UIControlStateNormal];
        but.layer.borderWidth =bw;
        but.layer.cornerRadius = cor;
        but.layer.masksToBounds = YES;
        but.layer.borderColor = bcolor.CGColor;
        self.button = but;
        [self addSubview:but];
        WeakSelf
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(weakSelf);
        }];
    }
    return self;
}
-(void)logregClick:(UIButton*)tj{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClick:)]) {
        [self.delegate buttonClick:tj];
    }
}
-(void)setTitle:(NSString *)title{
    _title = title;
    [self.button setTitle:title forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
