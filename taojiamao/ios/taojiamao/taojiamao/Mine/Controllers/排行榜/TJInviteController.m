//
//  TJInviteController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJInviteController.h"
#import "TJRankingListContentController.h"
@interface TJInviteController ()

@end

@implementation TJInviteController

- (void)viewDidLoad {
    [super viewDidLoad];
//    邀请排行
    self.view.frame = CGRectMake(0, 20, S_W, S_H);
    [self setControllers];

    
}
-(void)setControllers{
    
    self.titles = @[@"本周奖励",@"上周奖励"];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.selectIndex = 0;
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 15;
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(51, 51, 51);
    self.progressColor = RGB(255, 71, 119);
    
    [self reloadData];
}

#pragma mark - deletage DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    TJRankingListContentController *vc = [[TJRankingListContentController alloc]init];
    vc.time = [NSString stringWithFormat:@"%ld",index];
    vc.type_main = @"2";
    return vc;
    
}
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//        CGFloat width = [super menuView:menu widthForItemAtIndex:index];
//    return width;
//}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY+65, S_W - 2*leftMargin, 44*H_Scale);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
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
