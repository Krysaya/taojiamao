//
//  ViewController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import "DHGuidePageHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //在窗口初始化并显示后（[self.window makeKeyAndVisible]后）初始化图片数组并添加引导页;
    NSArray * imageArray = @[@"ydy_1.jpg",@"ydy_2.jpg",@"ydy_3.jpg"];
    DHGuidePageHUD * guidePage = [[DHGuidePageHUD alloc]dh_initWithFrame:S_F imageNameArray:imageArray buttonIsHidden:YES];
    
    [self.view addSubview:guidePage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
