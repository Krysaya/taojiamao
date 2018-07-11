//
//  TJBaseViewController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"

@interface TJBaseViewController ()

@end

@implementation TJBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = RandomColor;
    
}
-(void)setIsblack:(BOOL)isblack{
    _isblack = isblack;
    if (isblack) {
        [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    }else{
        [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    }
}
//-(void)setOpaque:(BOOL)opaque{
//    _opaque = opaque;
//    if (opaque) {
//        DSLog(@"导航栏不透明");
//        
//    }else{
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    }
//}
-(void)dealloc{
    DSLog(@"%s===base",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
