//
//  TJSearchView.m
//  taojiamao
//
//  Created by yueyu on 2018/5/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSearchView.h"

#define subviewH 32*H_Scale

@interface TJSearchView()<TJButtonDelegate>

@property(nonatomic,strong)TJTextField * search;
@property(nonatomic,strong)TJButton * searchButton;

@end

@implementation TJSearchView

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString*)plac title:(NSString*)text{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KBGRGB;
        [self setUIwithFrame:frame placeholder:plac title:text];
    }
    return self;
}
-(void)setUIwithFrame:(CGRect)frame placeholder:(NSString*)plac title:(NSString*)text{
    WeakSelf
    self.search = [TJTextField setTextFieldWith:plac font:15 textColor:RGB(51, 51, 51) backColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    label.backgroundColor = [UIColor clearColor];
    self.search.leftViewMode = UITextFieldViewModeAlways;
    self.search.leftView = label;
    [self addSubview:self.search];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
        make.width.mas_equalTo(frame.size.width-24);
        make.height.mas_equalTo(subviewH);
    }];
    
    self.search.layer.cornerRadius = subviewH*0.5;
    self.search.layer.masksToBounds = YES;
    
    self.searchButton = [[TJButton alloc]initWith:text delegate:self font:15 titleColor:[UIColor whiteColor] backColor:KALLRGB tag:1122 cornerRadius:subviewH*0.5];
    [self addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.centerY.mas_equalTo(weakSelf.search);
        make.width.mas_equalTo(85);
    }];
}

-(void)buttonClick:(UIButton *)but{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SearchButtonClick:)]) {
        [self.delegate SearchButtonClick:self.search.text];
    }
}


















@end
