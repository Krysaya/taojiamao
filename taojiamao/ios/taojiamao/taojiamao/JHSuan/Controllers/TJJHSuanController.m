//
//  TJJHSuanController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJJHSuanController.h"
#import "TJJHSuanCell.h"
#import "TJJHSGoodsListModel.h"
//#import "TJGoodsDetailsController.h"
#import "TJDefaultGoodsDetailController.h"

@interface TJJHSuanController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) int  page;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionView *collectionV;
@end

@implementation TJJHSuanController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = KALLRGB;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.page = 1;
    [self requestLoadNormalJHSList];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"jhs"]];
    self.navigationItem.titleView = headerImg;
    [self setCollectionVc];
    
   
}

- (void)requestLoadNormalJHSList{
//    商品列表页
    self.page = 1;
    self.dataArr = [NSMutableArray array];
    
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary * param = @{
//                                    @"page":@(self.page),
//                                    @"page_num":@"10",
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid": userid,
                                    }.mutableCopy;
    
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:param withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = JHSGoodsList;
        request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str,@"uid": userid};
//        request.parameters = @{ @"page":@(self.page),
//                                @"page_num":@"10",};
        request.httpMethod = kXMHTTPMethodPOST;
    }onSuccess:^(id responseObject) {
        [self endRefresh];

        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionV reloadData];
            if (self.dataArr.count<[param[@"page_num"] integerValue]) {
                self.collectionV.mj_footer.hidden = YES;
            }else{
                self.collectionV.mj_footer.hidden = NO;
            }
        });
        self.page++;
    } onFailure:^(NSError *error) {
        [self endRefresh];
    }];
    
}
- (void)requestLoadDataJHSList{

    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary * param = @{
                                    @"page":@(self.page),
                                    @"page_num":@"10",
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid": userid,
                                    }.mutableCopy;
    
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:param withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = JHSGoodsList;
        request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str,@"uid": userid};
        request.parameters = @{ @"page":@(self.page),
                                @"page_num":@"10",};
        request.httpMethod = kXMHTTPMethodPOST;
    }onSuccess:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionV reloadData];
        });
        self.page++;
        NSLog(@"jhsonSuccess:%@ =======",responseObject);
        
    } onFailure:^(NSError *error) {
        [self  endRefresh];
    }];
    
}
- (void)setCollectionVc{
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) collectionViewLayout:layou];
    collectV.delegate = self;
    collectV.dataSource = self;
    collectV.backgroundColor = RGB(245, 245, 245);
    [collectV registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil]
forCellWithReuseIdentifier:@"TJJHSuanCell"];
    [self.view addSubview:collectV];
    self.collectionV = collectV;
    
    [self addMjRefresh];
////    上拉加载
//    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestLoadDataJHSList:)];
////    下啦刷新
//    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestLoadNormalJHSList:)];
//    self.collectionV.mj_footer.hidden = YES;
}
#pragma mark - refreshSetting
-(void)addMjRefresh{
    WeakSelf
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf.dataArr removeAllObjects];
        weakSelf.page = 1;
        [self requestLoadNormalJHSList];
    }];
    
    NSMutableArray * temp = [NSMutableArray array];
    for (int i =1; i<20; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [temp addObject:image];
    }
    [header setImages:@[[UIImage imageNamed:@"1"]] forState:MJRefreshStateIdle];
    [header setImages:temp forState:MJRefreshStatePulling];
    [header setImages:temp duration:temp.count*0.2 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionV.mj_header =header;
  
    
    MJRefreshAutoStateFooter * footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
//        DSLog(@"%@",self.total);
//        if ([weakSelf.total integerValue]==weakSelf.page) {
//            weakSelf.collectionV.mj_footer.state = MJRefreshStateNoMoreData;
//            return ;
//        }
//        weakSelf.page++;
        [self requestLoadDataJHSList];
    }];
    [footer setTitle:@"我们是有底线的" forState:MJRefreshStateNoMoreData];
    self.collectionV.mj_footer = footer;
    
}
-(void)endRefresh{
    [self.collectionV.mj_header endRefreshing];
    [self.collectionV.mj_footer endRefreshing];
}

#pragma mark ---- UICollectionViewDataSource

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((S_W-10)/2, 275);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJJHSuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJJHSuanCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
//    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//   
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    [self.navigationController pushViewController:goodVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
