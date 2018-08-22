//
//  TJVipFansController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJVipFansController.h"
#import "TJVipFansContentController.h"
#import "TJSearchView.h"
#import "TJVipFensListModel.h"
@interface TJVipFansController ()<TJSearchViewDelegate>

@property(nonatomic,strong)TJSearchView * searchView;
@property (nonatomic, strong) NSMutableArray *searchData;
@end

@implementation TJVipFansController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"我的粉丝";
    [self setSearchView];
    [self setControllers];
}
-(void)setControllers{

    self.titles = @[@"一度粉丝()",@"二度粉丝()",@"三度粉丝()"];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.selectIndex = 0;
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 15;
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = RGB(255, 71, 119);
    self.titleColorNormal = RGB(51, 51, 51);
    self.progressColor = RGB(255, 71, 119);
    
    [self reloadData];
}
-(void)setSearchView{
    self.searchView = [[TJSearchView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, S_W, 65) placeholder:@"请输入粉丝ID" title:@"搜粉丝"];
    self.searchView.delegate =self;
    [self.view addSubview:self.searchView];

}
#pragma mark - deletage DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
   TJVipFansContentController *vc = [[TJVipFansContentController alloc]init];
    vc.index = [NSString stringWithFormat:@"%ld",index];
    return vc;
    
}
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//        CGFloat width = [super menuView:menu widthForItemAtIndex:index];
//    return width;
//}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY+65, S_W - 2*leftMargin, 44*H_Scale);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

-(void)SearchButtonClick:(NSString *)text{
    DSLog(@"%@",text);
    self.searchData = @{}.mutableCopy;
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
                                @"id":text,
                                //                                @"fans_level":level,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = MemeberFans;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.parameters = @{
                                @"id":text,
                               //                               @"fans_level":level,
                               };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"fans--%@",responseObject);
        self.searchData = [TJVipFensListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
