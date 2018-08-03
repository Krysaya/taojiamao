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

#define AllId @"5558888"
#define RightMargin 44*W_Scale
#define TopHeight 34*H_Scale

@interface TJHomeController ()<PYSearchViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray * contents;
@property(nonatomic,strong)NSMutableArray<TJGoodsCategory*>*category;
@property(nonatomic,strong)UIButton * triangleBut;
@property(nonatomic,strong)UIView * coverView;

@end

@implementation TJHomeController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.isblack = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品分类";
//    [self setChooseHeadview];
    //
    self.menuViewStyle = WMMenuViewStyleLine;
    
    self.selectIndex = self.index;
    self.titleSizeNormal = 13;
    self.titleSizeSelected = 14;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(102, 102, 102);
    self.progressColor = RGB(255, 71, 119);
    
        //
//    [self setNavTitleItems];
    
}

#pragma mark -设置nav
-(void)setNavTitleItems{
//
//    UIImageView * title = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
//    title.frame = CGRectMake(0, 0, 124, 42);
//    title.center = CGPointMake(self.view.center.x, 0);
//    self.navigationItem.titleView = title;
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action: @selector(searchClick)];
    UIBarButtonItem *notifiItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(notification)];
    NSArray *itemsArr = @[notifiItem,searchItem];
    self.navigationItem.rightBarButtonItems = itemsArr;
    
}

-(void)searchClick{
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"怪味少女装") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
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
-(void)notification{
    DSLog(@"通知哦");
}

#pragma mark - tap
-(void)tapAction:(UITapGestureRecognizer*)tap{
    self.coverView.hidden = YES;
    self.triangleBut.selected = NO;
}
#pragma mark - PYSearchViewControllerDelegate
//- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
//{
//    if (searchText.length) {
//        // Simulate a send request to get a search suggestions
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // Refresh and display the search suggustions
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
//    }
//}
#pragma mark -WMPageControllerSetting
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
//    if(index==0) return [[TJFirstAllController alloc]init];
    if (index==0) {
        return nil;
//         return [self.navigationController popViewControllerAnimated:NO];
    }else{
            TJContentController * ccvc = [[TJContentController alloc] init];
            ccvc.testName = self.titles[index];
            return ccvc;}
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
