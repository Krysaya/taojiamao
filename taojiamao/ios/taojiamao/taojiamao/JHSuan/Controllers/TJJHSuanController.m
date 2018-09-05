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
#import "KRefreshGifHeader.h"
#import "TJDefaultGoodsDetailController.h"

@interface TJJHSuanController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) int  page;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionView *collectionV;
@end

@implementation TJJHSuanController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = KALLRGB;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"jhs_nav_bg"] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"jhs"]];
    self.navigationItem.titleView = headerImg;
    [self setCollectionVc];
    
   
}

- (void)requestLoadNormalJHSList{
//    商品列表页
    self.page = 1;
    self.dataArr = [NSMutableArray array];
    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%d",self.page];
    NSDictionary *param = @{@"page":pag,
                            @"page_num":@"10",};
    [KConnectWorking requestNormalDataParam:param withRequestURL:JHSGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [weakSelf endRefresh];
        NSDictionary *dict = responseObject[@"data"];
        weakSelf.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionV reloadData];
        });
        
        if (weakSelf.dataArr.count<[param[@"page_num"] integerValue]) {
            weakSelf.collectionV.mj_footer.hidden = YES;
        }else{
            weakSelf.collectionV.mj_footer.hidden = NO;
        }
        weakSelf.page++;
    } withFailure:^(NSError * _Nullable error) {
        [weakSelf endRefresh];
    }];
}
- (void)requestLoadDataJHSList{

    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%d",self.page];
    NSDictionary *param = @{@"page":pag,
                            @"page_num":@"10",};
    [KConnectWorking requestNormalDataParam:param withRequestURL:JHSGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [weakSelf  endRefresh];
        NSDictionary *dict = responseObject[@"data"];
        NSArray *Arr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.dataArr addObjectsFromArray:Arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionV reloadData];
        });
        weakSelf.page++;
    } withFailure:^(NSError * _Nullable error) {
        [weakSelf endRefresh];
    }];
}
- (void)setCollectionVc{
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-49) collectionViewLayout:layou];
    collectV.delegate = self;
    collectV.dataSource = self;
    collectV.backgroundColor = RGB(245, 245, 245);
    [collectV registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil]
forCellWithReuseIdentifier:@"TJJHSuanCell"];
    [self.view addSubview:collectV];
    self.collectionV = collectV;
    [self addMjRefresh];
    [self.collectionV.mj_header beginRefreshing];
}
#pragma mark - refreshSetting
-(void)addMjRefresh{
    WeakSelf
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
     
        [weakSelf requestLoadNormalJHSList];
    }];
    NSMutableArray * temp = [NSMutableArray array];
    for (int i =1; i<20; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [temp addObject:image];
    }
    [header setImages:@[[UIImage imageNamed:@"1"]] forState:MJRefreshStateIdle];
    [header setImages:temp forState:MJRefreshStatePulling];
    [header setImages:temp duration:temp.count*0.025 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionV.mj_header = header;
  
    
    MJRefreshAutoStateFooter * footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf requestLoadDataJHSList];
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
    
    return CGSizeMake((S_W-5)/2, 275);
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
////定义每个Section的四边间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 0, 0, 0);//分别为上、左、下、右
//}
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
//    goodVC.price = model.itemprice;goodVC.priceQuan = model.itemendprice;
    [self.navigationController pushViewController:goodVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
