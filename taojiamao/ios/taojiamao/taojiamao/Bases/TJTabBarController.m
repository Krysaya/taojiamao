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
    self.view.backgroundColor = KBGRGB;
    self.tabBar.tintColor = KALLRGB;
    //setControllers
    [self setControllers];
    
    
    
    
}
-(void)setControllers{

//    TJHomePageController *VC1 = [[TJHomePageController alloc] init];
//    TJNavigationController *home = [[TJNavigationController alloc] initWithRootViewController:VC1];
//
//    TJTQGouController *VC2 = [[TJTQGouController alloc] init];
//    //    VC2.progressColor = KALLRGB;
//    VC2.progressHeight = 50*H_Scale;
//    VC2.progressColor = KALLRGB;
//    VC2.titleColorNormal = [UIColor whiteColor];
//    VC2.titleColorSelected = [UIColor redColor];
//    VC2.menuViewStyle = WMMenuViewStyleFlood;
//    VC2.progressViewCornerRadius = 0.f;
//
//
//    TJNavigationController *tqg = [[TJNavigationController alloc] initWithRootViewController:VC2];
//
//    //    TJCQuanController *VC3 = [[TJCQuanController alloc] init];
//    //    TJNavigationController *cqu = [[TJNavigationController alloc] initWithRootViewController:VC3];
//
//    TJJHSuanController *VC4 = [[TJJHSuanController alloc] init];
//    TJNavigationController *jhs = [[TJNavigationController alloc] initWithRootViewController:VC4];
//    //
//    //    TJMineController *VC5 = [[TJMineController alloc] init];
//    //    TJNavigationController *mine = [[TJNavigationController alloc] initWithRootViewController:VC5];
//
//    TJPersonalController *VC5 = [[TJPersonalController alloc] init];
//    TJNavigationController *mine = [[TJNavigationController alloc] initWithRootViewController:VC5];
//    VC1.title = @"首页";
//    VC2.title = @"淘抢购";
//    //    VC3.title = @"查券";
//    VC4.title = @"聚划算";
//    VC5.title = @"我的";
//    //
//    NSArray *viewCtrs = @[home,tqg,jhs,mine];
//    //
//    [self setViewControllers:viewCtrs animated:YES];
    
    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJHomePageController alloc]init]]
                          WithTitle:@"首页"
                          imageName:@"tjm_hp_gray.jpg"
                  selectedImageName:@"tjm_hp_light.jpg"];
    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJTQGouController alloc]init]]
                          WithTitle:@"淘抢购"
                          imageName:@"tjm_tqg_gray.jpg"
                  selectedImageName:@"tjm_tqg_light.jpg"];
    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJJHSuanController alloc]init]]
                          WithTitle:@"聚划算"
                          imageName:@"tjm_jhs_gray.jpg"
                  selectedImageName:@"tjm_jhs_light.jpg"];
    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJPersonalController alloc]init]]
                          WithTitle:@"我的"
                          imageName:@"tjm_center_gray.jpg"
                  selectedImageName:@"tjm_center_light.jpg"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.tabBarItem.title         = title;
    UIImage *image_default = [UIImage imageNamed:imageName];
    image_default = [image_default imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image         = image_default;
    viewController.tabBarItem.selectedImage = image;
    [self addChildViewController:viewController];
    
}


@end
