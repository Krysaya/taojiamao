//
//  TJTQGouController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//


#import "TJTQGouController.h"
#import "TJTQGContentController.h"
#import "WMPageController.h"
#import "XMNetworking.h"
#import "MJExtension.h"
#import "TJGoodsInfoListModel.h"
#import "TJTqgTimesListModel.h"
#import "TJTqgGoodsModel.h"
#define RightMargin 44*W_Scale
#define TopHeight 50*H_Scale


@interface TJTQGouController ()<WMPageControllerDelegate>

@property(nonatomic,strong)NSMutableArray * timesArr;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *childVCs;

@end

@implementation TJTQGouController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIImageView *headerImg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"tqg"]];
    self.navigationItem.titleView = headerImg;
    
    [self requestGoodsChooseNet];
}


#pragma mark 初始化代码
- (instancetype)init{
    if (self = [super init]) {
        
        self.menuViewStyle = WMMenuViewStyleLine;
        self.selectIndex = 0;
        self.titleSizeNormal = 13;
        self.titleSizeSelected = 14;
        self.menuItemWidth = 93*W_Scale;
        self.menuView.tintColor = [UIColor blackColor];
        self.progressHeight = 50*H_Scale;
        self.progressColor = KALLRGB;
        self.titleColorNormal = [UIColor whiteColor];
        self.titleColorSelected = [UIColor redColor];
        self.menuViewStyle = WMMenuViewStyleFlood;
        self.progressViewCornerRadius = 0.f;
        self.postNotification = YES;
        self.delegate = self;
        
    }
    return self;
}

#pragma mark - requestGoodsChooseNet
-(void)requestGoodsChooseNet{
//    时间list
    self.timesArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary * param = @{
        //                              @"page":@"5",
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid": userid,
                                    
                                    }.mutableCopy;
    
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:param withSecert:SECRET];
    //
    
    kWeakSelf(self);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = TQGTimeChoose;
        request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str,@"uid": userid};
        request.httpMethod = kXMHTTPMethodGET;
    }onSuccess:^(id responseObject) {
        kStrongSelf(self);
        NSDictionary *dict = responseObject[@"data"];
        NSArray *arr = dict[@"times"];
        self.timesArr = [TJTqgTimesListModel mj_objectArrayWithKeyValuesArray:arr];
        
//        TJTqgTimesListModel *model = self.timesArr[0];
//        NSLog(@"-----mmdoel---arg===%@",model.arg);
//        [self requestGoodsListWithModel:model];
        
        self.childVCs = @[].mutableCopy;
        for (int i = 0; i < self.timesArr.count; i ++) {
            TJTQGContentController * ccvc = [[TJTQGContentController alloc] init];
            [self.childVCs addObject:ccvc];
        }
        

        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
            self.menuView.backgroundColor = [UIColor blackColor];
        });
        
    } onFailure:^(NSError *error) {
       
        
    }];
}


#pragma mark -WMPageControllerSetting
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.timesArr.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    TJTqgTimesListModel *model = self.timesArr[index];
    return model.hour;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    TJTQGContentController * ccvc = [self.childVCs objectAtIndex:index];
    if (ccvc) {
        return ccvc;
    }
    return [UIViewController new];
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    NSLog(@"dianle====%@",info[@"index"]);
    NSInteger indexxx = [info[@"index"] integerValue];
    if (self.timesArr==nil) {
        
    }else{
//        if (indexxx==0) {
//
//        }else{
        TJTqgTimesListModel *model = self.timesArr[indexxx];
        NSLog(@"-----mmdoel---arg===%@",model.arg);
        TJTQGContentController * ccvc = self.childVCs[indexxx];
        [ccvc requestGoodsListWithModel:model];
        

//        }
    }
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
- (WMMenuItem *)menuView:(WMMenuView *)menu initialMenuItem:(WMMenuItem *)initialMenuItem atIndex:(NSInteger)index{
    
    TJTqgTimesListModel *model = self.timesArr[index];
    NSString *time = model.hour;
    NSString *status = model.str;
    NSString *info = [NSString stringWithFormat:@"%@\n%@",time,status];
    initialMenuItem.font = [UIFont systemFontOfSize:15];
    initialMenuItem.text = info;
    return initialMenuItem;
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index{
    
    return [UIColor whiteColor];
    
}


#pragma mark - lazyloading


@end
