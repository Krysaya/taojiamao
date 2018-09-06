
//
//  TJProjectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJProjectController.h"
#import "TJGoodsListCell.h"
#import "TJGoodsCollectModel.h"
#import "TJKallAdImgModel.h"
@interface TJProjectController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) SDCycleScrollView *scrollV;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@end

@implementation TJProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestAdImg];
    [self  requestHomePageGoodsJingXuan];
    self.title = @"推荐好货";

    //    广告滑动
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, S_W, 160) delegate:self placeholderImage:[UIImage imageNamed:@"ad_img"]];
    cycleScrollView.showPageControl = NO;
    [self.view addSubview:cycleScrollView];
    self.scrollV = cycleScrollView;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 160+64, S_W, S_H-160-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 160;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    self.tableView = tableView;
}

- (void)requestAdImg{
    self.bannerArr = [NSMutableArray array];self.imgArr = [NSMutableArray array];
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"posid":@"2",
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = [NSString stringWithFormat:@"%@2",KAllAdPosters];
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"---banner-%@",responseObject);
        self.bannerArr = [TJKallAdImgModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (TJKallAdImgModel *m in self.bannerArr) {
            [self.imgArr addObject:m.imgurl];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollV.imageURLStringsGroup = self.imgArr;
        });
        
    } onFailure:^(NSError * _Nullable error) {
    }];
}

- (void)requestHomePageGoodsJingXuan{
    //    精选
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
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = HomePageGoods;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        self.dataArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
    }];
}

#pragma mark = delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:NO withType:@"1"];
    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *bgView = [[UIView alloc]init];
////    ad
//
//
//    return bgView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 160;
//}

#pragma mark - ad  delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//    TJHomePageModel *m = self.imgDataArr[index];
//    TJAdWebController *vc = [[TJAdWebController alloc]init];vc.url = m.flag;
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
