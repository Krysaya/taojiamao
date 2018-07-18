//
//  TJContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentController.h"
#import "TJContentCollectionCell.h"
#import "TJHomeFootShowCell.h"
#import "TJHomeFootShowModel.h"
#import "TJMiddleClickController.h"
#import "TJClassicSecondController.h"

static NSString * const ContentMiddleCollectionCell = @"ContentMiddleCollectionCell";
static NSString * const ContentHomeFootShowCell = @"ContentHomeFootShowCell";

@interface TJContentController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)SDCycleScrollView * bannerView;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * tableData;

@end

@implementation TJContentController

#pragma mark -requestFootShowModels
-(void)requestFootShowModelsWithPage:(NSInteger)page{
    
//    if (self.tableData.count>0) {
//        [self.tableData removeAllObjects];
//    }
    
    NSDictionary * dict = @{@"page":@(page)};
    [XDNetworking postWithUrl:HomeFootRecommend refreshRequest:YES cache:NO params:dict progressBlock:nil successBlock:^(id response) {
//        [self endRefresh];
//        //        DSLog(@"%@",response);
//        self.current = response[@"now_page"];
//        self.total = response[@"total_page"];
        [self.tableData removeAllObjects];
        NSArray * temp = response[@"data"];
        for (NSDictionary * d in temp) {
            TJHomeFootShowModel * model = [TJHomeFootShowModel yy_modelWithDictionary:d];
            [self.tableData addObject:model];
        }
        DSLog(@"%lu",(unsigned long)self.tableData.count);
        [self.tableView reloadData];
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
//        [self endRefresh];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestFootShowModelsWithPage:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIViews];
}
-(void)setUIViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight) style:UITableViewStyleGrouped];
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TJHomeFootShowCell class] forCellReuseIdentifier:ContentHomeFootShowCell];
    [self.view addSubview:self.tableView];
    
    self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, S_W, 160) delegate:self placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    
    self.tableView.tableHeaderView = self.bannerView;
    
    
}

#pragma mark - sdc deleagte

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点了谁---%ld",index);
   
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJHomeFootShowCell * cell = [tableView dequeueReusableCellWithIdentifier:ContentHomeFootShowCell forIndexPath:indexPath];
    cell.model = self.tableData[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*H_Scale;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor =RandomColor;
    [self.headView addSubview:self.collectView];
    
    WeakSelf
    UIView * titleV =  [self setViewForHeaderInSectionWith:[NSString stringWithFormat:@"精选%@",self.testName] withFrame:CGRectZero];
    [self.headView addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.headView);
        make.height.mas_equalTo(68*H_Scale);
    }];
    
    return self.headView;
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
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJContentCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContentMiddleCollectionCell forIndexPath:indexPath];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TJClassicSecondController *vc = [[TJClassicSecondController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UICollectionView *)collectView{
    if (_collectView==nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        layout.itemSize = CGSizeMake(70, 95);
        layout.minimumLineSpacing= 10;
        layout.minimumInteritemSpacing = 0;
        
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 13, S_W, 95) collectionViewLayout:layout];
        _collectView.backgroundColor = RandomColor;
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
