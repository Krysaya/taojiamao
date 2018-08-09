
//
//  TJKdMyOpintionMyController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyOpintionMyController.h"
#import "XMTextView.h"
@interface TJKdMyOpintionMyController ()

@end

@implementation TJKdMyOpintionMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = KBGRGB;
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(15, 15+SafeAreaTopHeight, S_W-30, 225)];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.masksToBounds = YES;
    bg.layer.cornerRadius = 6;
    [self.view addSubview:bg];
    XMTextView *tv = [[XMTextView alloc]initWithFrame:CGRectMake(0, 0, S_W-30, 225)];
    tv.placeholder = @"聊聊您的看法，欢迎您参与我们的产品建设，说不定您的一句吐槽将成为下一次产品改进的指导。（140字范围内）";
    tv.placeholderColor =RGB(151, 151, 151);
    tv.textMaxNum = 140;
    tv.borderLineWidth = 0;
    tv.textFont = [UIFont systemFontOfSize:15];
    tv.textViewListening = ^(NSString *textViewStr) {
        NSLog(@"tv监听输入的内容：%@",textViewStr);
    };
    [bg  addSubview:tv];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 275+SafeAreaTopHeight, S_W-20, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
}
-(void)btnClick:(UIButton *)sender
{
// 提交
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
