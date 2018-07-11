//
//  TJBannerView.m
//  taojiamao
//
//  Created by yueyu on 2018/4/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBannerView.h"


@interface TJBannerView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
@property(nonatomic,strong)NewPagedFlowView * pageView;
@property(nonatomic,strong)NSMutableArray * URLS;
@end

@implementation TJBannerView

#pragma mark - initview
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setSDCycleScrollViewWithFrame:frame];
       
    }
    return self;
}
-(void)setSDCycleScrollViewWithFrame:(CGRect)frame{
    
    self.pageView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 187*H_Scale)];
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 0.1;
    self.pageView.isCarousel = YES;
    self.pageView.orientation = NewPagedFlowViewOrientationHorizontal;
    self.pageView.isOpenAutoScroll = YES;
    [self.pageView adjustCenterSubview];
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageView.pageControl = pageControl;
    [self addSubview:pageControl];
    
    [self.pageView reloadData];
    
    [self addSubview:self.pageView];
    
    WeakSelf
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.pageView);
        make.top.mas_equalTo(weakSelf.pageView.mas_bottom);
    }];

}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(S_W - 60, (S_W - 60) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
//    DSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (self.clickItemOperationBlock) {
        self.clickItemOperationBlock(subIndex+1);
    }
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
//    DSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.bannerData.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
      [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.URLS[index]] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    return bannerView;
}
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    self.pageView.autoTime = autoScrollTimeInterval;
}
#pragma mark - life cycle
- (void)dealloc
{
//    self.carousel.dataSource = nil;
//    self.carousel.delegate = nil;
}
#pragma mark - iCarouselDelegate && iCarouselDataSource


#pragma mark - getter
//
//- (UIImageView *)placeholderImageView
//{
//    return HT_LAZY(_placeholderImageView, ({
//
//        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, S_W - 2*PAGE_OFFSET, self.yj_height)];
//        view.contentMode = UIViewContentModeScaleToFill;
//        view.backgroundColor = RandomColor;
//        [self addSubview:view];
//        view;
//    }));
//}
//- (NSMutableArray *)imageURLStringsGroup
//{
//    return HT_LAZY(_imageURLStringsGroup, @[].mutableCopy);
//}
-(void)setBannerData:(NSMutableArray<TJHomeBanner *> *)bannerData{
    _bannerData = bannerData;
//    [self.carousel reloadData];
    for (TJHomeBanner * hb in bannerData) {
        [self.URLS addObject:hb.content];
    }
    [self.pageView reloadData];
}
-(NSMutableArray *)URLS{
    if (_URLS==nil) {
        _URLS = [NSMutableArray array];
    }
    return _URLS;
}
@end
