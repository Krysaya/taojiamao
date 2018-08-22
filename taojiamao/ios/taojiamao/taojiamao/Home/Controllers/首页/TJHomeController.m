//
//  TJHomeController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomeController.h"
#import "TJGoodsCategory.h"
#import "TJContentController.h"
#import "TJFirstAllController.h"
#import "TJSearchController.h"
#import "TJNoticeController.h"
#import "TJHomePageController.h"

#import "TJGoodCatesMainListModel.h"

#define AllId @"5558888"
#define RightMargin 44*W_Scale
#define TopHeight 34*H_Scale

@interface TJHomeController ()<PYSearchViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray * contents;
@property(nonatomic,strong)NSMutableArray<TJGoodsCategory*>*category;
@property(nonatomic,strong)UIButton * triangleBut;
@property(nonatomic,strong)UIView * coverView;
@property (nonatomic, strong) NSArray *hotSearchArr;
@property (nonatomic, strong) NSArray *goodsArr;

@property (nonatomic, strong) NSMutableArray *dataArr_left;
//@property (nonatomic, strong) NSMutableArray *dataArr_right;
@end

@implementation TJHomeController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadGoodsCatesList];
    [self requestSearchGoodsList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.dataArr_left[self.index];
    self.title = self.title_class;
    //
    self.menuViewStyle = WMMenuViewStyleLine;
    
    self.selectIndex = self.index;
    self.titleSizeNormal = 13;
    self.titleSizeSelected = 14;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(102, 102, 102);
    self.progressColor = RGB(255, 71, 119);
    [self reloadData];
    [self setNavTitleItems];
    
}

#pragma mark -设置nav
-(void)setNavTitleItems{
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action: @selector(searchClick)];

    self.navigationItem.rightBarButtonItem = searchItem;
    
}
#pragma mark - search
- (void)requestSearchGoodsList{
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

#pragma mark - classic
- (void)loadGoodsCatesList{
    self.dataArr_left = [NSMutableArray array];
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
            [self.dataArr_left addObject:model.catname];

        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
      
    }];
}
-(void)searchClick{
    // 1. Create an Array of popular search
//    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.hotSearchArr searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"怪味少女装") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        TJSearchController * result = [[TJSearchController alloc] init];
        result.searchText = searchText;
        [searchViewController.navigationController pushViewController:result animated:YES];
    }];
    // 3. Set style for popular search and search history
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
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
-(NSMutableArray<TJGoodsCategory *> *)category{
    if (!_category) {
        _category = [NSMutableArray array];
    }
    return _category;
}
//-(UIView *)coverView{
//    if (_coverView == nil) {
//        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+TopHeight, S_W, S_H-SafeAreaTopHeight-TopHeight)];
//        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        //test
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        [_coverView addGestureRecognizer:tap];
//    }
//    return _coverView;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    DSLog(@"%s",__func__);
}

@end
