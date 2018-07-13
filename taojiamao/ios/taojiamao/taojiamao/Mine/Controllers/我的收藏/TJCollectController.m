//
//  TJCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCollectController.h"
#import "ZJScrollPageView.h"
#import "TJGoodsCollectController.h"
#import "TJContentCollectController.h"
#import "TJGoodsListCell.h"
#import "TJContentListCell.h"
@interface TJCollectController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJContentView *contentView;
@property (nonatomic, strong) NSArray *childVCs;
//底部全选背景
@property(nonatomic,weak) UIView *bottomBgView;
@property(nonatomic,assign) NSInteger isSelect;

@end

@implementation TJCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    TJGoodsCollectController *vc1 = [[TJGoodsCollectController alloc]init];
    
    TJContentCollectController *vc2 = [[TJContentCollectController alloc]init];
    _childVCs = @[vc1,vc2];
    
    //    self.title = @"我的收藏";
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KALLRGB;
    style.scrollLineColor = KALLRGB;
    style.scrollLineSize = CGSizeMake(40, 2);
    
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 10, 200, 30) segmentStyle:style delegate:self titles:@[@"商品收藏",@"内容收藏"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
       [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    self.navigationItem.titleView = segment;
    
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64, S_W, S_H - 64 - SafeAreaBottomHeight) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}

- (void)editClick:(UIButton *)sender{
    if (self.isSelect==0) {
        NSLog(@"sp");
        TJGoodsCollectController *vc = _childVCs[0];
        for (TJGoodsListCell *cell in vc.goodsTabView.visibleCells) {
            cell.selectBtn.selected = !cell.selectBtn.selected;
//           编辑
        }
    }else{
        NSLog(@"nr");
    }
}

//底部
- (void)setupBottomStatus{
    UIView *bottomBgView = [[UIView alloc]init];
    bottomBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBgView];
    [bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(44);
        make.height.mas_equalTo(@44);
    }];
    self.bottomBgView = bottomBgView;
    
    //左侧全选按钮
//    [self setLeftSelectAllBtn];
    //右侧删除按钮
    [self setRightDeleteBtn];
}
//右侧删除按钮
- (void)setRightDeleteBtn{
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"取消收藏" forState:UIControlStateNormal];
    btn.backgroundColor = KALLRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 15;
    [self.bottomBgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.top.bottom.equalTo(self.bottomBgView);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.bottomBgView.mas_right).offset(-12);
    }];
}
#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return _childVCs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    self.isSelect = index;
    return _childVCs[index];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}



@end
