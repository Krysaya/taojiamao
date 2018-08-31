//
//  TJSearchScreenView.m
//  taojiamao
//
//  Created by yueyu on 2018/7/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSearchScreenView.h"


#define zhButton  48562
#define xlButton  48663
#define jgButton  48634
#define tmButton 34534

#define yqButton 32334
#define hsButton  48886
#define sxButton  48623

@interface TJSearchScreenView()

@property(nonatomic,strong)UIButton * zh;
@property(nonatomic,strong)UIButton * xl;
@property(nonatomic,strong)UIButton * jg;
@property(nonatomic,strong)UIButton * tm;

@property(nonatomic,strong)UIButton * yq;
@property(nonatomic,strong)UIButton * hs;
@property(nonatomic,strong)UIButton * sx;

@property(nonatomic,strong)UIButton * record;


@end

@implementation TJSearchScreenView
-(instancetype)initWithFrame:(CGRect)frame withMargin:(CGFloat)margin{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIwithFrame:margin];

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
    
    self.tm = [self buttonWithString:@"天猫" normalColor:RGB(51, 51, 51) selectColor:RGB(255, 71, 119) normalImage:@"" selectImage:@"" tag:tmButton imgAndTitleEdge:YES];
    [self addSubview:self.tm];
    [self.tm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.jg.mas_right).offset(margin);
    }];
    
    self.yq = [self buttonWithString:@"有券" normalColor:RGB(51, 51, 51) selectColor:RGB(255, 71, 119) normalImage:@"" selectImage:@"" tag:yqButton imgAndTitleEdge:NO];
    [self addSubview:self.yq];
    [self.yq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.tm.mas_right).offset(margin);
    }];
    
    //出现图片超高的bug
    self.hs = [self buttonWithString:@"" normalColor:nil selectColor:nil normalImage:@"class_collectlist" selectImage:@"class_tablist" tag:hsButton imgAndTitleEdge:NO];
    [self addSubview:self.hs];
    [self.hs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.yq.mas_right).offset(margin);
        make.width.height.mas_equalTo(18);
    }];
    //    self.hs.hidden = margin==22?NO:YES;
    
    self.sx =[self buttonWithString:@"筛选" normalColor:RGB(51, 51, 51) selectColor:nil normalImage:@"list_choose" selectImage:@"" tag:sxButton imgAndTitleEdge:NO];
    
    [self addSubview:self.sx];
    if (self.hs.hidden) {
        [self.sx mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf);
            make.width.mas_equalTo(50);
            make.left.mas_equalTo(weakSelf.yq.mas_right).offset(margin);
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
        UIImage *img = [UIImage imageNamed:@"price_bottom"];
//         [but setTitle:@"价格" forState:UIControlStateNormal];
        UILabel *lab = but.titleLabel;
        [but setTitleEdgeInsets:UIEdgeInsetsMake(0, -img.size.width-5, 0, img.size.width+5)];
        [but setImageEdgeInsets:UIEdgeInsetsMake(0,lab.bounds.size.width+28 , 0, -lab.bounds.size.width-15)];
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
        
    }else if (but.tag==sxButton){
        if (self.deletage && [self.deletage respondsToSelector:@selector(superPopupFiltrateView)]) {
            [self.deletage superPopupFiltrateView];
        }
    }else{
        if (!(but==self.record)) {
            self.record.selected = NO;
            but.selected = YES;
            self.record = but;
            switch (but.tag) {
                case zhButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(superRequestWithKind:)]) {
                        [self.deletage superRequestWithKind:@"综合"];
                    }
                }
                    break;
                case xlButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(superRequestWithKind:)]) {
                        [self.deletage superRequestWithKind:@"销量"];
                    }
                }
                    break;
                case jgButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(superRequestWithKind:)]) {
                        [self.deletage superRequestWithKind:@"价格"];
                    }
                }
                    break;
                case tmButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(superRequestWithKind:)]) {
                        [self.deletage superRequestWithKind:@"天猫"];
                    }
                }
                    break;
                    
                case yqButton:{
                    if (self.deletage && [self.deletage respondsToSelector:@selector(superRequestWithKind:)]) {
                        [self.deletage superRequestWithKind:@"有券"];
                    }
                }
                    break;
                default:
                    break;
            }
        }
     
    }
}


-(UIButton *)record{
    if (!_record) {
        _record = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _record;
}

@end
