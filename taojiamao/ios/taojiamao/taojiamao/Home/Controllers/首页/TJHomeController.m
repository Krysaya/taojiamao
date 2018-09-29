//
//  TJHomeController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomeController.h"
//#import "TJGoodsCategory.h"
#import "TJContentController.h"
//#import "TJFirstAllController.h"
#import "TJSearchController.h"
#import "TJNoticeController.h"
#import "TJHomePageController.h"

#import "TJGoodCatesMainListModel.h"

#define AllId @"5558888"
#define RightMargin 44*W_Scale
#define TopHeight 34*H_Scale

@interface TJHomeController ()<PYSearchViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray * contents;
//@property(nonatomic,strong)NSMutableArray<TJGoodsCategory*>*category;
@property(nonatomic,strong)UIButton * triangleBut;
@property(nonatomic,strong)UIView * coverView;
@property (nonatomic, strong) NSArray *hotSearchArr;
@property (nonatomic, strong) NSArray *goodsArr;

@property (nonatomic, strong) NSMutableArray *dataArr_left;
//@property (nonatomic, strong) TJGoodCatesMainListModel *cmodel;
@end

@implementation TJHomeController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    int indexpath = [self.index intValue]-100;DSLog(@"--%d--22222",indexpath);

    self.menuViewStyle = WMMenuViewStyleLine;
    self.selectIndex = indexpath;
    self.titleSizeNormal = 13;
    self.titleSizeSelected = 14;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(102, 102, 102);
    self.progressColor = RGB(255, 71, 119);
//    [self setNavTitleItems];
    [self loadGoodsCatesList];
    [self requestSearchGoodsList];
}

#pragma mark -设置nav
-(void)setNavTitleItems{
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action: @selector(searchClick)];
    self.navigationItem.rightBarButtonItem = searchItem;
    
}
#pragma mark - search
- (void)requestSearchGoodsList{
    self.hotSearchArr = [NSArray array];
    WeakSelf
    [KConnectWorking requestNormalDataParam:nil withRequestURL:SearchGoods withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        weakSelf.hotSearchArr = responseObject[@"data"][@"hot"];
    } withFailure:^(NSError * _Nullable error) {
    }];
    
}

#pragma mark - classic
- (void)loadGoodsCatesList{
    
    self.dataArr_left = [NSMutableArray array];
    WeakSelf
    [KConnectWorking requestNormalDataParam:nil withRequestURL:GoodsClassicList withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        for (int i=1; i<dict.count+1; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            TJGoodCatesMainListModel *model = [TJGoodCatesMainListModel mj_objectWithKeyValues:dict[str]];
            [weakSelf.dataArr_left addObject:model.catname];
        }
        [weakSelf reloadData];
        int indexpath = [weakSelf.index intValue]-100;
        if (weakSelf.dataArr_left.count>0) {
            weakSelf.title = weakSelf.dataArr_left[indexpath];
        }
    } withFailure:^(NSError * _Nullable error) {
        
    }];

}
-(void)searchClick{

    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.hotSearchArr searchBarPlaceholder:@"秋季新款女装外套" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        TJSearchController * result = [[TJSearchController alloc] init];
        result.searchText = searchText;
        [searchViewController.navigationController pushViewController:result animated:YES];
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    searchViewController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
}
#pragma mark - tap
-(void)tapAction:(UITapGestureRecognizer*)tap{
    self.coverView.hidden = YES;
    self.triangleBut.selected = NO;
}
#pragma mark - PYSearchViewControllerDelegate

#pragma mark -WMPageControllerSetting
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArr_left.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    self.title = self.dataArr_left[index];
    return self.dataArr_left[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
            TJContentController * ccvc = [[TJContentController alloc] init];
            ccvc.testName = self.dataArr_left[index];
            ccvc.index = index;
            return ccvc;
}
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, S_W - 2*leftMargin,TopHeight);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}
#pragma mark - lazyloading
- (NSMutableArray *)contents{
    if (_contents==nil) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}
//-(NSMutableArray<TJGoodsCategory *> *)category{
//    if (!_category) {
//        _category = [NSMutableArray array];
//    }
//    return _category;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    DSLog(@"%s",__func__);
}

@end
