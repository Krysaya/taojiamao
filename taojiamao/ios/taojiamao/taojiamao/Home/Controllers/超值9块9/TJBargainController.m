//
//  TJBargainController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBargainController.h"
#import "TJBargainContentController.h"
#import "TJSearchController.h"
#import "TJGoodCatesMainListModel.h"
@interface TJBargainController () <UISearchBarDelegate,ZJScrollPageViewDelegate,ZJScrollPageViewChildVcDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray *hotSearchArr;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *cateArr;
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSArray *imgSelectArr;

@property(weak, nonatomic)ZJContentView *contentView;
@property (nonatomic, strong) ZJScrollSegmentView *segV;

@end

@implementation TJBargainController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self loadGoodsCatesList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *headerImg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"hp_jkj_nav"]];
    self.navigationItem.titleView = headerImg;
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 116)];
//    topView.backgroundColor = KALLRGB;
    [self.view addSubview:topView];
    UIImageView *img_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 116)];
    img_bg.backgroundColor = KALLRGB;
    [topView addSubview:img_bg];

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 74, S_W-30, 32)];
    bgView.backgroundColor = RGBA(255, 255, 255, 0.2);
    bgView.layer.cornerRadius = 15;
    bgView.layer.masksToBounds = YES;
    UISearchBar *searchB = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, S_W-30, 32)];
    searchB.delegate = self;
    [searchB setBackgroundImage: [UIImage new]];
    [searchB setPlaceholder: @"搜宝贝 领优惠"];
    
    [searchB setImage:[UIImage imageNamed:@""] forSearchBarIcon:UISearchBarIconResultsList state:UIControlStateNormal];
    UITextField *searchField = [searchB valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    }

    searchB.searchBarStyle = UISearchBarStyleDefault;
    [bgView addSubview:searchB];
    [topView addSubview:bgView];
    
    UIView *bg_pageView = [[UIView alloc]initWithFrame:CGRectMake(0, 116, S_W, 75)];
    [self.view addSubview:bg_pageView];
    UIImageView *img_page = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 75)];
    img_page.backgroundColor = KALLRGB;
    [bg_pageView addSubview:img_page];
    
    
//    分栏
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    style.titleMargin = 30.f;style.normalTitleColor = [UIColor whiteColor];
    style.segmentViewBounces = NO;style.selectedTitleColor = [UIColor whiteColor];
    /// 显示图片 (在显示图片的时候只有下划线的效果可以开启, 其他的'遮盖','渐变',效果会被内部关闭)
    style.showImage = YES;
    /// 图片位置
    style.imagePosition = TitleImagePositionTop;
    // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
    style.autoAdjustTitlesWidth = YES;

    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 0, S_W, 75.0) segmentStyle:style delegate:self titles:self.cateArr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];

    }];
    
    self.segV = segment;
    // 自定义标题的样式
    segment.layer.cornerRadius = 14.0;
//    segment.backgroundColor = [UIColor redColor];
    // 当然推荐直接设置背景图片的方式
    //    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    [bg_pageView addSubview:segment];
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 116+75, S_W, S_H-116-75);
    ZJContentView *contentV = [[ZJContentView alloc] initWithFrame:scrollPageViewFrame segmentView:segment parentViewController:self delegate:self];
    self.contentView = contentV;
    [self.view addSubview:self.contentView];
    
    [self requestSearchHotsList];
}

#pragma mark - request
- (void)requestSearchHotsList{
    self.hotSearchArr = [NSArray array];
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SearchGoods;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        self.hotSearchArr = responseObject[@"data"][@"hot"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } onFailure:^(NSError * _Nullable error) {
    
        
    }];
}
- (void)loadGoodsCatesList{
    self.dataArr = [NSMutableArray array];
    self.cateArr = [NSMutableArray array];
    [self.cateArr insertObject:@"精选" atIndex:0];
    [self.cateArr insertObject:@"9.9" atIndex:1];
    [self.cateArr insertObject:@"19.9" atIndex:2];
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    DSLog(@"--sign==%@",md5Str);
    
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = GoodsClassicList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
        
    } onSuccess:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        for (int i=1; i<dict.count+1; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            TJGoodCatesMainListModel *model = [TJGoodCatesMainListModel mj_objectWithKeyValues:dict[str]];
            //            DSLog(@"---fl=%@",dict[str]);
            [self.dataArr addObject:model];
            [self.cateArr addObject:model.catname];
            
        }
        [self.segV reloadTitlesWithNewTitles:self.cateArr];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentView reload];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
    
}
#pragma mark - zj-delegate
- (NSInteger)numberOfChildViewControllers {
    return self.cateArr.count;
  
}

/// 设置图片
- (void)setUpTitleView:(ZJTitleView *)titleView forIndex:(NSInteger)index {
    titleView.normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"hp_jkj_%ld",index+1]];
    titleView.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"hp_jkj_select_%ld",index+1]];
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    // 根据不同的下标或者title返回相应的控制器, 但是控制器必须要遵守ZJScrollPageViewChildVcDelegate
    // 并且可以通过实现协议中的方法来加载不同的数据
    // 注意ZJScrollPageView不会保证viewWillAppear等生命周期方法一定会调用
    // 所以建议使用ZJScrollPageViewChildVcDelegate中的方法来加载不同的数据
//    TJBargainContentController *childVc = (TJBargainContentController *)reuseViewController;
//    if (!childVc) {
//
//        childVc = [[TJBargainContentController alloc]init];     childVc.dataArr = self.dataArr;
//
//    }
    TJBargainContentController *vc = [[TJBargainContentController alloc]init];
    vc.dataArr = self.dataArr;
    return vc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}
#pragma mark - searchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    DSLog(@"点了--");[self searchClick];
    return NO;
}

-(void)searchClick{
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.hotSearchArr searchBarPlaceholder:@"怪味少女装" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        TJSearchController * result = [[TJSearchController alloc] init];
        result.searchText = searchText;
        [searchViewController.navigationController pushViewController:result animated:YES];
    }];
    
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    
    
    //    换位置
    searchViewController.swapHotSeachWithSearchHistory = YES;
    // 4. Set delegate
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
}


@end
