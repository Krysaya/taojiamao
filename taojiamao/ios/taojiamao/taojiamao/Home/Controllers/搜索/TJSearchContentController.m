//
//  TJSearchContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/24.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSearchContentController.h"
#import "TJHomeFootShowCell.h"
#import "TJGoodsListCell.h"
#import "TJJHSuanCell.h"
#import "TJJHSGoodsListModel.h"
#import "TJDefaultGoodsDetailController.h"
#import "TJFiltrateView.h"
#import "TJMultipleChoiceView.h"

static NSString *TJSearchContentFootShowCell = @"TJSearchContentFootShowCell";
static NSString *TJSearchContentCollectionCell = @"TJSearchContentCollectionCell";

@interface TJSearchContentController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ZJScrollPageViewChildVcDelegate,TJFiltrateViewDelegate,TJMultipleChoiceViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)TJFiltrateView * filtrateView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataChooseArr;

@property(nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic, strong) NSString *oldStr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *type;
@end

@implementation TJSearchContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self.strsearch isEqualToString:self.oldStr]) {
        if (self.collectionView.hidden) {
            [self.tableView.mj_header beginRefreshing];
        }else{
            [self.collectionView.mj_header beginRefreshing];
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"0";
    self.page = 1;
    self.oldStr = self.strsearch;
    self.filtrateView = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, 0, S_W, 45) withMargin:22];
    self.filtrateView.backgroundColor = [UIColor whiteColor];
    self.filtrateView.deletage = self;
    [self.view addSubview:self.filtrateView];
    [self setUITableView];
    [self setUICollectionView];
    self.tableView.hidden = YES;
    WeakSelf
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf requestNormalSearchGoodsWithType:weakSelf.type];
    }];
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf requestSearchGoodsWithType:self.type];
    }];
    self.collectionView.mj_header = header;
    self.collectionView.mj_footer = footer;
    [self.collectionView.mj_header beginRefreshing];
    MJRefreshStateHeader *header2 = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf requestNormalSearchGoodsWithType:weakSelf.type];
    }];
    
    MJRefreshAutoStateFooter *footer2 = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf requestSearchGoodsWithType:weakSelf.type];
    }];
    [footer setTitle:@"----我们是有底线的----" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_header = header2;
    self.tableView.mj_footer = footer2;
    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(horizontalVerticalTransform:) name:TJHorizontalVerticalTransform object:nil];
}


- (void)requestNormalSearchGoodsWithType:(NSString *)type{
    self.dataArr = [NSMutableArray array];
    self.page = 1;
    WeakSelf
    [SVProgressHUD show];
    
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    NSString *str = [self.strsearch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [KConnectWorking requestNormalDataMD5Param:@{ @"keyword":str,@"order":type,@"page":pag,
                                                  @"page_num":@"10",} withNormlParams:@{@"keyword":self.strsearch,@"order":type,@"page":pag,@"page_num":@"10",} withRequestURL:SearchGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [weakSelf endRefrensh];

        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            [weakSelf.tableView reloadData];
            [weakSelf.collectionView reloadData];
        
        if (weakSelf.dataArr.count>0) {
            
        }else{
            weakSelf.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nolist"]];
            weakSelf.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nolist"]];
        }
        weakSelf.page++;

                                                      
    } withFailure:^(NSError * _Nullable error) {
        [weakSelf endRefrensh];
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"加载失败，请重试~"];
    }];
   
}

- (void)requestSearchGoodsWithType:(NSString *)type{
    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    NSString *str = [self.strsearch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [KConnectWorking requestNormalDataMD5Param:@{ @"keyword":str,@"order":type,@"page":pag,@"page_num":@"10",} withNormlParams:@{@"keyword":self.strsearch,@"order":type,@"page":pag,@"page_num":@"10",} withRequestURL:SearchGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
        [weakSelf endRefrensh];
        NSDictionary *dict = responseObject[@"data"];
        NSArray *arr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
       
        if (arr.count==0) {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            weakSelf.collectionView.mj_footer.state = MJRefreshStateNoMoreData;
            [weakSelf.tableView.mj_footer resetNoMoreData];
            [weakSelf.collectionView.mj_footer resetNoMoreData];
        }else{
            [weakSelf.dataArr addObjectsFromArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [weakSelf.collectionView reloadData];
            });
            weakSelf.page++;
        }
    
    } withFailure:^(NSError * _Nullable error) {
        [weakSelf endRefrensh];

    }];
}

- (void)endRefrensh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
}
-(void)setUITableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, S_W, S_H-SafeAreaTopHeight-85) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = KBGRGB;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:TJSearchContentFootShowCell];
    [self.view addSubview:self.tableView];
   
}
-(void)setUICollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((S_W-5)*0.5, 275);
    layout.minimumLineSpacing= 5;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, S_W, S_H-SafeAreaTopHeight-50) collectionViewLayout:layout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor = KBGRGB;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil] forCellWithReuseIdentifier:TJSearchContentCollectionCell];
    [self.view addSubview:self.collectionView];
   

}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell * cell = [tableView dequeueReusableCellWithIdentifier:TJSearchContentFootShowCell forIndexPath:indexPath];
//    cell.model = self.dataArr[indexPath.row];
    [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:NO withType:@"0"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJJHSuanCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TJSearchContentCollectionCell forIndexPath:indexPath];
    cell.cell_type = @"search";
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((S_W-5)/2, 275);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - 通知
-(void)horizontalVerticalTransform:(NSNotification*)info{
    DSLog(@"%@",info.userInfo[@"hsBool"]);
    NSNumber * num = info.userInfo[@"hsBool"];
    BOOL hs = [num boolValue];
    self.tableView.hidden = !hs;
    self.collectionView.hidden = hs;

}

-(void)dealloc{
//    DSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - FiltrateViewdelegte

-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
    TJMultipleChoiceView * mcv = [[TJMultipleChoiceView alloc]initWithFrame:S_F];
//    mcv.backgroundColor = RGBA(1, 1, 1, 0.2);
    mcv.deletage = self;
    [[UIApplication sharedApplication].keyWindow addSubview:mcv];
}
-(void)requestWithKind:(NSString *)kind{
    if ([kind isEqualToString:@"综合"]) {
        DSLog(@"%@--0",kind);
        self.type = @"0";

    }else if ([kind isEqualToString:@"销量"]){
        DSLog(@"%@---6",kind);
        self.type = @"6";
    }else if ([kind isEqualToString:@"价格"]){
        DSLog(@"%@---2",kind);
        self.type = @"2";

    }else if ([kind isEqualToString:@"优惠券"]){
        DSLog(@"%@---4",kind);
        self.type = @"4";
    }
    
    [self requestNormalSearchGoodsWithType:self.type];
}

- (void)buttonSureSelectString:(NSMutableDictionary *)sureDict{
    if (sureDict.count>0) {
        DSLog(@"筛选--？？？？")
        self.dataChooseArr = [NSMutableArray array];
        NSString *userid = GetUserDefaults(UID);
        
        if (userid) {
        }else{
            userid = @"";
        }
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSString *str = [self.strsearch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *shoptype = sureDict[@"type"];
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"keyword":str,
                                    @"shoptype":shoptype,
//                                    @"cid":@"1",
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
            request.parameters = @{@"keyword":self.strsearch, @"shoptype":shoptype,
//                                   @"cid":@"1",
                                   
                                   };
        } onSuccess:^(id  _Nullable responseObject) {
            DSLog(@"---SXX---%@",responseObject);
            NSDictionary *dict = responseObject[@"data"];
            if (dict.count>0) {
                self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                    [self.tableView reloadData];
                });
            }
           
            
        } onFailure:^(NSError * _Nullable error) {
        }];
    }
   
}


@end
