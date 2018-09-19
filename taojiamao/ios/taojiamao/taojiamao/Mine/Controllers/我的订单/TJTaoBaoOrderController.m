
//
//  TJTaoBaoOrderController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTaoBaoOrderController.h"
#import "TJTBOrderContentController.h"

@interface TJTaoBaoOrderController ()<ZJScrollPageViewDelegate,ZJScrollPageViewChildVcDelegate>
@property(weak, nonatomic)ZJContentView *contentView;
@property (nonatomic, strong) ZJScrollSegmentView *segV;
@end

@implementation TJTaoBaoOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝订单";
    DSLog(@"--%@--nav",self.navigationController);
    self.view.frame = CGRectMake(0, 0, S_W, S_H);
    //    分栏
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showLine = YES;
    style.titleMargin = 30.f;
    style.segmentViewBounces = NO;
    style.selectedTitleColor = KALLRGB;
    style.normalTitleColor = RGB(151, 151, 151);
    style.scrollLineColor = KALLRGB;
    /// 显示图片 (在显示图片的时候只有下划线的效果可以开启, 其他的'遮盖','渐变',效果会被内部关闭)
//    style.showImage = YES;
    /// 图片位置
//    style.imagePosition = TitleImagePositionTop;
    // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
    style.autoAdjustTitlesWidth = YES;
    
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 64, S_W, 50) segmentStyle:style delegate:self titles:@[@"全部",@"待结算",@"已结算"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    segment.backgroundColor = [UIColor whiteColor];
//    self.segV = segment;
    // 自定义标题的样式
    segment.layer.cornerRadius = 14.0;
    [self.view addSubview:segment];
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, SafeAreaTopHeight+50, S_W, S_H-SafeAreaTopHeight-50);
    ZJContentView *contentV = [[ZJContentView alloc] initWithFrame:scrollPageViewFrame segmentView:segment parentViewController:self delegate:self];
    self.contentView = contentV;
    [self.view addSubview:self.contentView];
//    [self openTaoBaoOrder];
//    [self setControllers];
//淘宝订单
    // Do any additional setup after loading the view.
}



#pragma mark - zj-delegate
- (NSInteger)numberOfChildViewControllers {
    return 3;
    
}
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    // 根据不同的下标或者title返回相应的控制器, 但是控制器必须要遵守ZJScrollPageViewChildVcDelegate
    // 并且可以通过实现协议中的方法来加载不同的数据
    // 注意ZJScrollPageView不会保证viewWillAppear等生命周期方法一定会调用
    // 所以建议使用ZJScrollPageViewChildVcDelegate中的方法来加载不同的数据
        TJTBOrderContentController *childVc = (TJTBOrderContentController *)reuseViewController;
        if (!childVc) {
    
            childVc = [[TJTBOrderContentController alloc]init];
    
        }
//    TJTBOrderContentController *vc = [[TJTBOrderContentController alloc]init];
    childVc.type = [NSString stringWithFormat:@"%ld",index];
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
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
