
//
//  TJFindPopView.m
//  taojiamao
//
//  Created by yueyu on 2018/9/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJFindPopView.h"


@interface TJFindPopView ()
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
@implementation TJFindPopView
- (instancetype)initWithFrame:(CGRect)frame withImgURL:(NSString *)str
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TJFindPopView"
                                              owner:nil options:nil]lastObject];
        self.frame = frame;
        //        self.selectBtn.selected = YES;
        [self.img sd_setImageWithURL: [NSURL URLWithString:str]];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
@end
