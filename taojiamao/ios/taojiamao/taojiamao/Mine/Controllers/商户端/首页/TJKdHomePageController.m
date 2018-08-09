
//
//  TJKdHomePageController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//  快递 - 首页

#import "TJKdHomePageController.h"
#import "TJKdHomePaContentController.h"
#import "TJKdHomePageContentTwoController.h"
#import "TJTabBarController.h"
#define NoticeTag  3732
#define BackTag  3452
@interface TJKdHomePageController ()<ZJScrollPageViewDelegate,TJButtonDelegate>
@property (nonatomic, strong) NSArray *childVCs;

@property (nonatomic, strong) ZJContentView *contentView;

@end

@implementation TJKdHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent = NO;
    TJKdHomePaContentController *vc1 = [[TJKdHomePaContentController alloc]init];
    TJKdHomePageContentTwoController *vc2 = [[TJKdHomePageContentTwoController alloc]init];
    _childVCs = @[vc1,vc2];

    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KKDRGB;
    style.scrollLineColor = KKDRGB;
    style.scrollLineSize = CGSizeMake(40, 2);
    style.scrollContentView = NO;
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 10, 200, 30) segmentStyle:style delegate:self titles:@[@"待接单",@"已接单"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    self.navigationItem.titleView = segment;
    
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64, S_W, S_H - 64 - SafeAreaBottomHeight) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];
    
    
    TJButton *btn = [[TJButton alloc]initDelegate:self backColor:nil tag:NoticeTag withBackImage:@"kd_notice" withSelectImage:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    TJButton *btn_left = [[TJButton alloc]initDelegate:self backColor:nil tag:BackTag withBackImage:@"back_left" withSelectImage:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn_left];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - rightbtnDELEGATE
- (void)buttonClick:(UIButton *)but{
    if (but.tag==NoticeTag) {
        //    notice

    }else{
        //    back
        TJTabBarController *tbs = [[TJTabBarController alloc]init];
        [UIApplication  sharedApplication].keyWindow.rootViewController = tbs;
        

    }
}
#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return _childVCs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
   
    return _childVCs[index];
}


- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

@end
