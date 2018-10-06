
//
//  TJHPFindController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHPFindController.h"
#import "TJHPFindContentController.h"

@interface TJHPFindController ()<ZJScrollPageViewDelegate,ZJScrollPageViewChildVcDelegate>
@property(weak, nonatomic)ZJContentView *contentView;
@property (nonatomic, strong) ZJScrollSegmentView *segV;
@end

@implementation TJHPFindController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 120)];
    [self.view addSubview:topView];
    UIImageView *img_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 120)];
    img_bg.backgroundColor = [UIColor redColor];
    [topView addSubview:img_bg];
    
    //    分栏
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.titleMargin = 100.f;style.normalTitleColor = [UIColor whiteColor];
    style.segmentViewBounces = NO;style.selectedTitleColor = [UIColor whiteColor];
    style.scrollLineColor = [UIColor whiteColor];
//    style.scrollLineHeight = 5;
//    style.autoAdjustTitlesWidth = YES;
    style.scrollLineSize = CGSizeMake(70, 5);
    style.showLine = YES;
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 120-45, S_W, 45.0) segmentStyle:style delegate:self titles:@[@"淘宝",@"拼多多",] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    self.segV = segment;
    [topView addSubview:segment];
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 120, S_W, S_H-120);
    ZJContentView *contentV = [[ZJContentView alloc] initWithFrame:scrollPageViewFrame segmentView:segment parentViewController:self delegate:self];
    self.contentView = contentV;
    [self.view addSubview:self.contentView];
}
#pragma mark - zj-delegate
- (NSInteger)numberOfChildViewControllers {
    return 2;
    
}
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    TJHPFindContentController *vc = (TJHPFindContentController *)reuseViewController;
    if (!vc) {
        vc = [[TJHPFindContentController alloc]init];
    }
    return vc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}
@end
