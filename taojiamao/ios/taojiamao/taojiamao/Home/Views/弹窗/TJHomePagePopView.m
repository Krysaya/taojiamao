//
//  TJHomePagePopView.m
//  taojiamao
//
//  Created by yueyu on 2018/9/10.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomePagePopView.h"
#import "TJHomePageModel.h"


@interface TJHomePagePopView ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;

@end
@implementation TJHomePagePopView

+(instancetype)invitationView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TJHomePagePopView"
                                          owner:nil options:nil]lastObject];
}

- (IBAction)tapButtonClick:(UIButton *)sender {
    [self removeFromSuperview];
    [self.delegate tapClick];
    
}
- (IBAction)closeButtonClick:(UIButton *)sender {
    [self removeFromSuperview];
}
- (void)setModel:(TJHomePageModel *)model{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"pop_img"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
