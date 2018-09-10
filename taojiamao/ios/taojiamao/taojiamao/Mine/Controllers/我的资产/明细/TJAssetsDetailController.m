//
//  TJAssetsDetailController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAssetsDetailController.h"
#import "TJDetailListController.h"
#import "ZJScrollSegmentView.h"
@interface TJAssetsDetailController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJContentView *contentView;

@end

@implementation TJAssetsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收支明细";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];

    if ([self.type_mx isEqualToString:@"put"]) {
        style.selectedTitleColor = KALLRGB;
        style.scrollLineColor = KALLRGB;
    }else{
        style.selectedTitleColor = KKDRGB;
        style.scrollLineColor = KKDRGB;
    }
    style.titleMargin  = 80;
    style.segmentViewBounces = NO;
    style.showLine= YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    
    style.scrollLineSize = CGSizeMake(79, 2);

    
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 64, S_W, 45) segmentStyle:style delegate:self titles:@[@"余额明细",@"集分宝明细"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    segment.center = CGPointMake(self.view.center.x, 90);
    [self.view addSubview:segment];
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64+50, S_W, S_H - 64 - SafeAreaBottomHeight) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];
 
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}
#pragma mark - delegte
- (NSInteger)numberOfChildViewControllers {
    return 2;// 传入页面的总数, 推荐使用titles.count
}
- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController *childVc = reuseViewController;
    // 这里一定要判断传过来的是否是nil, 如果为nil直接使用并返回
    // 如果不为nil 就创建
    if (childVc == nil) {
        TJDetailListController *vc = [[TJDetailListController alloc]init];
        vc.type_mxx = self.type_mx;
        childVc = vc;
        
        if (index%2 == 0) {
            
            childVc.view.backgroundColor = [UIColor redColor];
        } else {
            childVc.view.backgroundColor = [UIColor cyanColor];
            
        }
        
    }
    return childVc;
}
@end
