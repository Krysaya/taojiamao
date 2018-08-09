
//
//  TJKdAllOrdersController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdAllOrdersController.h"
#import "TJAllOrderContentController.h"

#import "TJKdUserOrderList.h"

@interface TJKdAllOrdersController ()<ZJScrollPageViewDelegate>
@property (nonatomic, strong) ZJContentView *contentView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJKdAllOrdersController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNormalOrderList:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBGRGB;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KKDRGB;
    style.scrollLineColor = KKDRGB;
    style.scrollLineSize = CGSizeMake(50, 2);
    style.scrollContentView = NO;
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 50) segmentStyle:style delegate:self titles:@[@"全部",@"待完成",@"待评价",@"已完成"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    [self.view addSubview:segment];
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, SafeAreaTopHeight+50, S_W, S_H - SafeAreaTopHeight-50) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];

}

- (void)loadNormalOrderList:(NSString *)type{
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
                                @"type":@"2",

                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = OrderList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"type":@"2"};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----kdorder=-success-===%@",responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } onFailure:^(NSError * _Nullable error) {
//                    NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//                    NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
//                    DSLog(@"--order-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
        DSLog(@"--error-%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
          
        });
        
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return 4;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    TJAllOrderContentController *vc = [[TJAllOrderContentController alloc]init];
    return vc;
}


- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

@end
