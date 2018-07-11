
//
//  TJShareView.m
//  taojiamao
//
//  Created by yueyu on 2018/7/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJShareView.h"
@interface TJShareView ()
@property (nonatomic, strong) UIButton *btn_tb;
@property (nonatomic, strong) UIButton *btn_wx;
@property (nonatomic, strong) UIButton *btn_qq;
@end

@implementation TJShareView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setSubViewWithBackImg:(NSString *)img{
//    NSArray *imgArr = @[@"",@"",@""];
    CGFloat btnW = 50*W_Scale;
    CGFloat btnH = 50*W_Scale;
    CGFloat b = (self.bounds.size.width-2*35-3*btnW)/2;
    for (int i = 0; i<3; i++) {
        UIButton * shareBtn = [[UIButton alloc]init];
        shareBtn.tag = i;
        shareBtn.frame = CGRectMake(b+(btnW+35)*i, 0, btnW, btnH);
        shareBtn.backgroundColor = RandomColor;
        [self addSubview:shareBtn];
    
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
