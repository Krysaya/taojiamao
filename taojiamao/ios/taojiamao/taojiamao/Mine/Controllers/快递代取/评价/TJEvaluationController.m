
//
//  TJEvaluationController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJEvaluationController.h"
#import "HYBStarEvaluationView.h"
#import "SQButtonTagView.h"
@interface TJEvaluationController ()<DidChangedStarDelegate>

@end

@implementation TJEvaluationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    [self setGiveStar];
    [self setPingJiaTag];
}
- (void)setGiveStar{
//    评价
    HYBStarEvaluationView *starView = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(80, 109, S_W-160, 30) numberOfStars:5 isVariable:YES];
    starView.actualScore = 1;
    starView.fullScore = 5;
    starView.delegate = self;
    [self.view addSubview:starView];
    
    UILabel *lab  = [[UILabel alloc]initWithFrame:CGRectMake(0, 159, S_W, 25)];
    lab.text = @"觉得怎么样，打个分吧~";
    lab.textColor = RGB(225, 225, 225);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
}

- (void)setPingJiaTag{
    UIView *view_bg = [[UIView alloc]initWithFrame:CGRectMake(10, 190, S_W-20, 225)];
    view_bg.layer.masksToBounds = YES;
    view_bg.layer.cornerRadius = 6 ;
    view_bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_bg];
    
//    tag
    SQButtonTagView *tagView = [[SQButtonTagView alloc]initWithTotalTagsNum:8 viewWidth:S_W-40 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor grayColor] colorWithAlphaComponent:1] selectedTagTextColor:KKDRGB selectedBackgroundColor:[KKDRGB colorWithAlphaComponent:0.5]];
    tagView.tagTexts = @[@"态度很好",@"人很nice",@"服务态度好",@"人长得帅",@"人长得漂亮",@"有礼貌",@"有耐心",@"很准时"];
    tagView.selectBlock = ^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray) {
        DSLog(@"--select--%ld",tagView.tag);
    };
    tagView.frame = CGRectMake(15, 30, S_W-30-20, 100);
    [view_bg addSubview:tagView];
//    line
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, tagView.frame.size.height+tagView.frame.origin.y+15, S_W-30-20, 1)];
    img.backgroundColor = KBGRGB;
    [view_bg addSubview:img];
//    textview
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, img.frame.origin.y+15, S_W-40, 80)];
    tv.userInteractionEnabled = NO;
    [view_bg addSubview:tv];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 190+225+25, S_W-20, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTickClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
    
    
}
- (void)btnTickClick:(UIButton *)sender{
    
}
#pragma mark - star--deleagte

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)didChangeStar {

}
#pragma mark - tag
//- (void)selectAction:(void(^)(SQButtonTagView *tagView, NSArray *selectArray))block{
//    DSLog(@"---select--%ld");
//
//}
@end
