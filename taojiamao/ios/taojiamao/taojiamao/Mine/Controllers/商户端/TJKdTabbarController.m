
//
//  TJKdTabbarController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdTabbarController.h"
#import "TJKdHomePageController.h"
#import "TJKdUserCenterController.h"
@interface TJKdTabbarController ()

@end

@implementation TJKdTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/**
 *  添加子控制器，
 */
- (void)setUpChildViewController{
    
    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJKdHomePageController alloc]init]]
                          WithTitle:@"首页"
                          imageName:@"kd_homep_gray"
                  selectedImageName:@"kd_homep_select"];



    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJKdHomePageController alloc]init]]
                          WithTitle:nil
                          imageName:@"kd_refrensh"
                  selectedImageName:@"kd_refrensh"];

    [self addOneChildViewController:[[TJNavigationController alloc]initWithRootViewController:[[TJKdUserCenterController alloc] init]]
                          WithTitle:@"我的"
                          imageName:@"kd_my_gray"
                  selectedImageName:@"mycity_highlight"];
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
