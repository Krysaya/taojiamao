
//
//  TJKdAllOrdersController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdAllOrdersController.h"
#import "TJAllOrderContentController.h"


@interface TJKdAllOrdersController ()<ZJScrollPageViewDelegate>
@property (nonatomic, strong) ZJContentView *contentView;
@end

@implementation TJKdAllOrdersController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KKDRGB;
    style.scrollLineColor = KKDRGB;
    style.scrollLineSize = CGSizeMake(50, 2);
    style.scrollContentView = NO;
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 50) segmentStyle:style delegate:self titles:@[@"全部",@"待完成",@"待评价",@"已完成"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    [self.view addSubview:segment];
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, SafeAreaTopHeight+50, S_W, S_H - SafeAreaTopHeight-50) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return 4;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    TJAllOrderContentController *childVc = (TJAllOrderContentController *)reuseViewController;
    if (childVc==nil) {
        childVc = [[TJAllOrderContentController alloc]init];
    }
    return childVc;
}


- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

@end
