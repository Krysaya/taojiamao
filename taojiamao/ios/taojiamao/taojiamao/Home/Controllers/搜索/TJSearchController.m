//
//  TJSearchController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//   搜索

#import "TJSearchController.h"
#import "TJSearchContentController.h"
#import "TJFiltrateView.h"
#import "TJMultipleChoiceView.h"
#import "TJJHSGoodsListModel.h"
#import "TJSearchScreenView.h"
#import "TJSuperSearchController.h"

@interface TJSearchController ()<UITextFieldDelegate,TJFiltrateViewDelegate,TJSearchScreenViewDelegate,ZJScrollPageViewDelegate>

@property(nonatomic,strong)UIView * naview;
@property(nonatomic,strong)TJTextField * search;
@property (nonatomic, strong) ZJContentView *contentView;

@property(nonatomic,strong)TJFiltrateView * filtrateView;
@property(nonatomic,strong)TJSearchScreenView * superView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArr_super;
@property (nonatomic, strong) NSArray *childVCs;

@property (nonatomic, strong) TJSearchContentController *vc1;
@property (nonatomic, strong) TJSuperSearchController *vc2;
@end

@implementation TJSearchController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestSearchGoodsListWithOrderType:@"0"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(255, 255, 255);
    [self setNavSerachBar];
    // 必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    TJSearchContentController *vc1 = [[TJSearchContentController alloc]init];
    TJSuperSearchController *vc2 = [[TJSuperSearchController alloc]init];
    self.vc1 = vc1;
    self.vc2 = vc2;
    self.childVCs = @[vc1,vc2];
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KALLRGB;
    style.scrollLineColor = KALLRGB;
    style.scrollLineSize = CGSizeMake(70, 2);
    style.scrollContentView = NO;
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 10+SafeAreaTopHeight, 200, 30) segmentStyle:style delegate:self titles:@[@"本站搜索",@"超级搜索"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    segment.center = CGPointMake(self.view.center.x, 90);
    [self.view addSubview:segment];
    
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, SafeAreaTopHeight+55+30, S_W, S_H - SafeAreaTopHeight -85) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];
    [self setFiltrateViewWithStr:@"1"];

    
}

- (void)setFiltrateViewWithStr:(NSString *)type{
    
    if ([type intValue]==1) {
        
        self.superView.hidden = YES;
        self.filtrateView = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+40, S_W, 45) withMargin:22];
        self.filtrateView.backgroundColor = [UIColor whiteColor];
        self.filtrateView.deletage = self;
        [self.view addSubview:self.filtrateView];
    }else if([type intValue]==2){
        
        self.filtrateView.hidden = YES;

        self.superView = [[TJSearchScreenView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+40, S_W, 45) withMargin:25];
        self.superView.backgroundColor  = [UIColor whiteColor];
        self.superView.deletage = self;
        [self.view addSubview:self.superView];
    }
    
    
}
- (void)requestSearchGoodsListWithOrderType:(NSString *)type{
    self.dataArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSString *str = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"keyword":str,
                                @"order":type,
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SearchGoodsList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"keyword":self.searchText,@"order":type};
    } onSuccess:^(id  _Nullable responseObject) {
//        NSLog(@"----search-success-===%@",responseObject);
        
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        DSLog(@"-%lu--arr==",(unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setFiltrateViewWithStr:@"1"];

            self.vc1.dataArr = self.dataArr;
            [self.vc1.collectionView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
//        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
//        DSLog(@"--搜索-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
}

- (void)requestSuperSearchListWithSuperSort:(NSString *)sort{
    self.dataArr_super = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSString *str = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"keyword":str,
                                @"sort":sort,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SuperSearchGoodsList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"keyword":self.searchText,                                @"sort":sort};
    } onSuccess:^(id  _Nullable responseObject) {
//        NSLog(@"---super-search-success-===%@",responseObject);
        
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr_super = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        DSLog(@"-%lu--arr==",(unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setFiltrateViewWithStr:@"2"];

            self.vc2.dataArr = self.dataArr_super;
            [self.vc2.collectionView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--super搜索-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
}



-(void)setNavSerachBar{

    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_left"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    self.naview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 32)];
//    self.naview.backgroundColor = RandomColor;
    
    self.search = [TJTextField setTextFieldWith:@"请输入搜索内容" font:15 textColor:RGB(51, 51, 51) backColor:RGB(222, 222, 222)];
    self.search.text = self.searchText;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    label.backgroundColor = [UIColor clearColor];
    self.search.leftViewMode = UITextFieldViewModeAlways;
    self.search.leftView = label;
    self.search.frame = self.naview.bounds;
    self.search.layer.cornerRadius = 16;
    self.search.layer.masksToBounds = YES;
    self.search.returnKeyType = UIReturnKeySearch;
    self.search.delegate = self;
    
    [self.naview addSubview:self.search];
    self.navigationItem.titleView = self.naview;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//#pragma mark - deletage DataSource
//- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
//    return self.titles.count;
//}
//- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
//
//    return self.titles[index];
//}
//- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
//    if (index==0) {
//        TJSearchContentController *vc = [[TJSearchContentController alloc]init];
//        vc.dataArr = self.dataArr;
//        return vc;
//    }else{
//        TJSuperSearchController *vc = [[TJSuperSearchController alloc]init];
//        vc.dataArr = self.dataArr;
//        return vc;
//    }
//
//}
//- (void)menuView:(WMMenuView *)menu didSelectedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
//
//    self.currentIndex = [NSString stringWithFormat:@"%ld",currentIndex];
//    if (index==1) {
//        DSLog(@"super");
//        [self setFiltrateViewWithStr:@"2"];
//        [self requestSuperSearchListWithSuperSort:@"0"];
//    }else{
//        [self setFiltrateViewWithStr:@"1"];
//        [self requestSearchGoodsListWithOrderType:@"0"];
//
//    }
//}
//
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//        CGFloat width = [super menuView:menu widthForItemAtIndex:index];
//    return width+30;
//}
//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
//    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
//    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    return CGRectMake(leftMargin, originY, S_W - 2*leftMargin, 40*H_Scale);
//}
//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
//    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
//    return CGRectMake(0, originY+45, self.view.frame.size.width, self.view.frame.size.height - originY-45);
//}

#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return _childVCs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
  
    if (index==0) {
    

        [self requestSearchGoodsListWithOrderType:@"0"];

    }else{

        [self requestSuperSearchListWithSuperSort:@"0"];

    }
    return _childVCs[index];
    
}


- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

#pragma mark - FiltrateViewdelegte

-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
    TJMultipleChoiceView * mcv = [[TJMultipleChoiceView alloc]initWithFrame:self.view.bounds];
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    [window addSubview:mcv];
}
-(void)requestWithKind:(NSString *)kind{
    if ([kind isEqualToString:@"综合"]) {
        DSLog(@"%@",kind);
        [self requestSearchGoodsListWithOrderType:@"0"];

    }else if ([kind isEqualToString:@"销量"]){
        DSLog(@"%@",kind);
        [self requestSearchGoodsListWithOrderType:@"6"];
    }else if ([kind isEqualToString:@"价格"]){
        DSLog(@"%@",kind);
        [self requestSearchGoodsListWithOrderType:@"2"];//高--低
        

    }else if ([kind isEqualToString:@"优惠券"]){
        DSLog(@"%@",kind);
        [self requestSearchGoodsListWithOrderType:@"4"];

    }else{
        DSLog(@"%@",kind);

    }
}

-(void)superPopupFiltrateView{
    DSLog(@"呼出筛选框");
    TJMultipleChoiceView * mcv = [[TJMultipleChoiceView alloc]initWithFrame:self.view.bounds];
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    [window addSubview:mcv];
}
-(void)superRequestWithKind:(NSString *)kind{
    if ([kind isEqualToString:@"综合"]) {
        DSLog(@"%@",kind);
        [self requestSuperSearchListWithSuperSort:@"0"];
        
    }else if ([kind isEqualToString:@"销量"]){
        DSLog(@"%@",kind);
        [self requestSuperSearchListWithSuperSort:@"2"];

    }else if ([kind isEqualToString:@"价格"]){
        DSLog(@"%@",kind);
        [self requestSuperSearchListWithSuperSort:@"5"];

        
        
    }else if ([kind isEqualToString:@"有券"]){
        DSLog(@"%@",kind);
        
        
    }else{
        DSLog(@"%@",kind);
        
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DSLog(@"%@",textField.text);
    return YES;
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
}


@end
