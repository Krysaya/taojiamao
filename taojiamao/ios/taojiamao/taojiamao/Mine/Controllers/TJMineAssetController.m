//
//  TJMineAssetController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMineAssetController.h"
#import "TJMineAssetDetailsController.h"
#import "TJMineJFBModel.h"

@interface TJMineAssetController ()

@property(nonatomic,strong)UIImageView * backImage;
@property(nonatomic,strong)TJMineJFBModel * model;

@end

@implementation TJMineAssetController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requstMineJFB];
    self.navBarBgAlpha = @"0.0";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资产";
    self.view.backgroundColor = RandomColor;
}
-(void)requstMineJFB{
    [XDNetworking postWithUrl:UserMineJFB refreshRequest:NO cache:NO params:@{@"uid":@"1"} progressBlock:nil successBlock:^(id response) {
        NSDictionary * dict = response[@"data"];
        self.model = [TJMineJFBModel yy_modelWithDictionary:dict];
        [self reloadData];
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
    }];
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index==1) {
        TJMineAssetDetailsController * vc = [[TJMineAssetDetailsController alloc] init];
        vc.index = index;
        vc.model = self.model;
        return vc;
    }else{
        TJMineAssetDetailsController * vc = [[TJMineAssetDetailsController alloc] init];
        vc.index = index;
        return vc;
    }
}
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return 65;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY+25*H_Scale, S_W - 2*leftMargin, 44*H_Scale);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY+25*H_Scale, self.view.frame.size.width, self.view.frame.size.height - originY);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    DSLog(@"%s",__func__);
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
