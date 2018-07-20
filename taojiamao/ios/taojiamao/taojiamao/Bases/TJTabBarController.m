//
//  TJTabBarController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTabBarController.h"
#import "TJHomePageController.h"
#import "TJHomeController.h"
#import "TJTQGouController.h"
//#import "TJCQuanController.h"
#import "TJJHSuanController.h"
//#import "TJMineController.h"

#import "TJPersonalController.h"
@interface TJTabBarController ()

@end

@implementation TJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    //setControllers
    [self setControllers];
}
-(void)setControllers{
    TJHomePageController *VC1 = [[TJHomePageController alloc] init];
    TJNavigationController *home = [[TJNavigationController alloc] initWithRootViewController:VC1];
    
    TJTQGouController *VC2 = [[TJTQGouController alloc] init];
    TJNavigationController *tqg = [[TJNavigationController alloc] initWithRootViewController:VC2];

    
    TJJHSuanController *VC4 = [[TJJHSuanController alloc] init];
    TJNavigationController *jhs = [[TJNavigationController alloc] initWithRootViewController:VC4];
//
//    TJMineController *VC5 = [[TJMineController alloc] init];
//    TJNavigationController *mine = [[TJNavigationController alloc] initWithRootViewController:VC5];
    
    TJPersonalController *VC5 = [[TJPersonalController alloc] init];
    TJNavigationController *mine = [[TJNavigationController alloc] initWithRootViewController:VC5];
    VC1.title = @"首页";
    VC2.title = @"淘抢购";
//    VC3.title = @"查券";
    VC4.title = @"聚划算";
    VC5.title = @"我的";
    //
    NSArray *viewCtrs = @[home,tqg,jhs,mine];
    //
    [self setViewControllers:viewCtrs animated:YES];
    
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
