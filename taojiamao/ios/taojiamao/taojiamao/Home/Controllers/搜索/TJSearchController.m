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
@interface TJSearchController ()<UITextFieldDelegate,TJFiltrateViewDelegate>

@property(nonatomic,strong)UIView * naview;
@property(nonatomic,strong)TJTextField * search;

@property(nonatomic,strong)TJFiltrateView * filtrateView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJSearchController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestSearchGoodsList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavSerachBar];
    [self setFiltrateView];
    [self setControllers];
    
}

- (void)requestSearchGoodsList{
    self.dataArr = [NSMutableArray array];
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
                                @"keyword":self.searchText,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    DSLog(@"sign==%@,times==%@,uid==%@,key==%@",md5Str,timeStr,userid,self.searchText);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SearchGoodsList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"keyword":self.searchText};
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"----search-success-===%@",responseObject);
        
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        DSLog(@"-%lu--arr==",(unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--搜索-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
}
-(void)setControllers{
    
    self.titles = @[@"本站搜索",@"超级搜索"];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.selectIndex = 0;
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 15;
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(51, 51, 51);
    self.progressColor = RGB(255, 71, 119);
    self.preloadPolicy = WMPageControllerPreloadPolicyNear;
    
    [self reloadData];
}
-(void)setFiltrateView{

    self.filtrateView = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+40, S_W, 45) withMargin:22];
    self.filtrateView.deletage = self;
    [self.view addSubview:self.filtrateView];

}
-(void)setNavSerachBar{

    self.naview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 32)];
//    self.naview.backgroundColor = RandomColor;
    
    self.search = [TJTextField setTextFieldWith:@"请输入搜索内容" font:15 textColor:RGB(51, 51, 51) backColor:[UIColor orangeColor]];
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
#pragma mark - deletage DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    TJSearchContentController *vc = [[TJSearchContentController alloc]init];
    vc.dataArr = self.dataArr;
    return vc;
    
}
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
        CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width+30;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, S_W - 2*leftMargin, 40*H_Scale);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY+45, self.view.frame.size.width, self.view.frame.size.height - originY-45);
}

-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
    TJMultipleChoiceView * mcv = [[TJMultipleChoiceView alloc]initWithFrame:self.view.bounds];
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    [window addSubview:mcv];
}
-(void)requestWithKind:(NSString *)kind{
    DSLog(@"%@",kind);
}
#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DSLog(@"%@",textField.text);
    return YES;
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
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
