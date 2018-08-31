//
//  TJContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentController.h"
#import "TJDefaultGoodsDetailController.h"

#import "TJContentCollectionCell.h"
#import "TJHomeFootShowCell.h"
#import "TJGoodsListCell.h"

#import "TJHomeFootShowModel.h"
#import "TJMiddleClickController.h"
#import "TJClassicSecondController.h"
#import "TJGoodCatesMainListModel.h"
#import "TJGoodsCollectModel.h"
static NSString * const ContentMiddleCollectionCell = @"ContentMiddleCollectionCell";
static NSString * const ContentHomeFootShowCell = @"ContentHomeFootShowCell";

@interface TJContentController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)SDCycleScrollView * bannerView;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * tableData;
@property (nonatomic, strong) NSMutableArray *dataArr_top;
@property (nonatomic, strong) NSMutableArray *dataArr_bottom;


@end

@implementation TJContentController

#pragma mark -requestFootShowModels

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadGoodsCatesList];
    [self requestHomePageGoodsJingXuan];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIViews];
}
-(void)setUIViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.view addSubview:self.tableView];
    
    self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, S_W, 160) delegate:self placeholderImage:[UIImage imageNamed:@"ad_img"]];
    self.bannerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.bannerView;
    
    
}

- (void)loadGoodsCatesList{
    self.dataArr_top = [NSMutableArray array];
    NSMutableArray *arr = @[].mutableCopy;

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
    DSLog(@"--sign==%@",md5Str);
    
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
            [arr addObject:model];
            
        }
        
        TJGoodCatesMainListModel *m = [arr objectAtIndex:self.index];
        [self.dataArr_top addObjectsFromArray:m.managedSons];
        DSLog(@"---%ld===%ld",self.dataArr_top.count,m.managedSons.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
      
    }];
}

- (void)requestHomePageGoodsJingXuan{
    //    精选
    self.dataArr_bottom = [NSMutableArray array];
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
        self.dataArr_bottom = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        
    } onFailure:^(NSError * _Nullable error) {
       
    }];
}
#pragma mark - sdc deleagte

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点了谁---%ld",index);
   
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr_bottom.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    [cell cellWithArr:self.dataArr_bottom forIndexPath:indexPath isEditing:NO withType:@"1"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*H_Scale;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = KBGRGB;
    [self.headView addSubview:self.collectView];
    
    WeakSelf
    UIView * titleV =  [self setViewForHeaderInSectionWith:[NSString stringWithFormat:@"精选%@",self.testName] withFrame:CGRectZero];
    [self.headView addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.headView);
        make.height.mas_equalTo(58*H_Scale);
    }];
    
    return self.headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsCollectModel *m = self.dataArr_bottom[indexPath.row];
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    goodVC.gid = m.itemid;
    [self.navigationController pushViewController:goodVC animated:YES];

}
-(UIView*)setViewForHeaderInSectionWith:(NSString*)title withFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    TJLabel * titleL = [TJLabel setLabelWith:title font:15 color:RGB(255, 71, 119)];
    [view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
    }];
    
    UIView * left = [[UIView alloc]init];
    left.backgroundColor =RGB(255, 71, 119);
    [view addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleL);
        make.right.mas_equalTo(titleL.mas_left).offset(-10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    
    UIView * right = [[UIView alloc]init];
    right.backgroundColor =RGB(255, 71, 119);
    [view addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.centerY.mas_equalTo(left);
        make.left.mas_equalTo(titleL.mas_right).offset(10);
    }];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 188*H_Scale;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArr_top.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJContentCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContentMiddleCollectionCell forIndexPath:indexPath];

        cell.model = self.dataArr_top[indexPath.row];
       return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    TJClassicSecondController *vc = [[TJClassicSecondController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
-(UICollectionView *)collectView{
    if (_collectView==nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        layout.itemSize = CGSizeMake(70, 95);
        layout.minimumLineSpacing= 10;
        layout.minimumInteritemSpacing = 0;
        
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 15, S_W, 110) collectionViewLayout:layout];
        _collectView.backgroundColor = [UIColor whiteColor];
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        [_collectView registerClass:[TJContentCollectionCell class] forCellWithReuseIdentifier:ContentMiddleCollectionCell];
    }
    return _collectView;
}
-(NSMutableArray *)tableData{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
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
