//
//  TJFiltrateView.m
//  taojiamao
//
//  Created by yueyu on 2018/5/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJFiltrateView.h"

#define zhButton  4862
#define xlButton  4863
#define jgButton  4864
#define yhqButton 4865
#define hsButton  4866
#define sxButton  486723

@interface TJFiltrateView()

@property(nonatomic,strong)UIButton * zh;
@property(nonatomic,strong)UIButton * xl;
@property(nonatomic,strong)UIButton * jg;
@property(nonatomic,strong)UIButton * yhq;
@property(nonatomic,strong)UIButton * hs;
@property(nonatomic,strong)UIButton * sx;
@property(nonatomic,strong)UIImageView * sxImage;

@property(nonatomic,strong)UIButton * record;

@end

@implementation TJFiltrateView

-(instancetype)initWithFrame:(CGRect)frame withMargin:(CGFloat)margin{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor orangeColor];
        [self setUIwithFrame:margin];
//        self.jg.imageEdgeInsets = UIEdgeInsetsMake(0, self.jg.titleLabel.frame.size.width, 0, -self.jg.titleLabel.frame.size.width);
//        self.jg.titleEdgeInsets = UIEdgeInsetsMake(0, -self.jg.imageView.frame.size.width, 0, self.jg.imageView.frame.size.width);
        
    }
    return self;
}

-(void)setUIwithFrame:(CGFloat)margin{
    WeakSelf
    self.zh = [self buttonWithString:@"综合" normalColor:RGB(51, 51, 51) selectColor:RGB(255, 71, 119) normalImage:@"" selectImage:@"" tag:zhButton imgAndTitleEdge:NO];
    self.zh.selected = YES;
    self.record = self.zh;
    [self addSubview:self.zh];
    [self.zh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(20);
    }];
    
    self.xl =[self buttonWithString:@"销量" normalColor:RGB(51, 51, 51) selectColor:RGB(255, 71, 119) normalImage:@"" selectImage:@"" tag:xlButton imgAndTitleEdge:NO];
    [self addSubview:self.xl];
    [self.xl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.zh.mas_right).offset(margin);
    }];
    
    self.jg = [self buttonWithString:@"价格" normalColor:RGB(51, 51, 51) selectColor:RGB(255, 71, 119) normalImage:@"price_bottom" selectImage:@"price_top" tag:jgButton imgAndTitleEdge:YES];
//    self.jg.selected = !self.jg.selected;
    [self addSubview:self.jg];
    [self.jg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.xl.mas_right).offset(margin);
    }];
   
    
    
    self.yhq = [self buttonWithString:@"优惠券高" normalColor:RGB(51, 51, 51) selectColor:RGB(255, 71, 119) normalImage:@"" selectImage:@"" tag:yhqButton imgAndTitleEdge:NO];
    [self addSubview:self.yhq];
    [self.yhq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.jg.mas_right).offset(margin);
    }];
    
    //出现图片超高的bug
    self.hs = [self buttonWithString:@"" normalColor:nil selectColor:nil normalImage:@"class_collectlist" selectImage:@"class_tablist" tag:hsButton imgAndTitleEdge:NO];
    [self addSubview:self.hs];
    [self.hs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.yhq.mas_right).offset(margin);
        make.width.height.mas_equalTo(18);
    }];
//    self.hs.hidden = margin==22?NO:YES;
    
    self.sx =[self buttonWithString:@"筛选" normalColor:RGB(51, 51, 51) selectColor:nil normalImage:@"list_choose" selectImage:@"" tag:sxButton imgAndTitleEdge:NO];

    [self addSubview:self.sx];
    if (self.hs.hidden) {
        [self.sx mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf);
            make.width.mas_equalTo(50);
            make.left.mas_equalTo(weakSelf.yhq.mas_right).offset(margin);
        }];
    }else{
        [self.sx mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf);
            make.width.mas_equalTo(50);
            make.left.mas_equalTo(weakSelf.hs.mas_right).offset(margin);
        }];
    }

}


#pragma mark - 设置button
-(UIButton*)buttonWithString:(NSString*)str normalColor:(UIColor*)nc selectColor:(UIColor*)sc normalImage:(NSString*)ni selectImage:(NSString*)si tag:(NSInteger)t imgAndTitleEdge:(BOOL)type{
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.titleLabel.font = [UIFont systemFontOfSize:15];
    but.tag = t;
    [but setTitle:str forState:UIControlStateNormal];
    [but setTitleColor:nc forState:UIControlStateNormal];
    [but setTitleColor:sc forState:UIControlStateSelected];
    [but setImage:[UIImage imageNamed:ni] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:si] forState:UIControlStateSelected];
    [but addTarget:self action:@selector(sixButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (type==YES) {
        
        but.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -30);
        but.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 10);
    }else{
        
    }
   
    return but;
}


-(void)sixButtonClick:(UIButton*)but{
    if (but.tag==hsButton) {
        but.selected = !but.selected;
        //通知
        NSNotificationCenter * noticen = [NSNotificationCenter defaultCenter];
        NSNumber * sele = [NSNumber numberWithBool:but.selected];
        [noticen postNotificationName:TJHorizontalVerticalTransform object:nil userInfo:@{@"hsBool":sele}];
         [noticen postNotificationName:TJHorizontalVerticalTransformClass object:nil userInfo:@{@"hsClassBool":sele}];
    }else if (but.tag==sxButton){
        if (self.deletage && [self.deletage respondsToSelector:@selector(popupFiltrateView)]) {
            [self.deletage popupFiltrateView];
        }
    }else{
        if (!(but==self.record)) {
            self.record.selected = NO;
            but.selected = YES;
            self.record = but;
            switch (but.tag) {
                case zhButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(requestWithKind:)]) {
                        [self.deletage requestWithKind:@"综合"];
                    }
                }
                    break;
                case xlButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(requestWithKind:)]) {
                        [self.deletage requestWithKind:@"销量"];
                    }
                }
                    break;
                case jgButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(requestWithKind:)]) {
                        [self.deletage requestWithKind:@"价格"];
                    }
                }
                    break;
                case yhqButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(requestWithKind:)]) {
                        [self.deletage requestWithKind:@"优惠券"];
                    }
                }
                    break;
                default:
                    break;
            }
        }
        //        else{
        
        //        }
    }
}


-(UIButton *)record{
    if (!_record) {
        _record = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _record;
}























@end
