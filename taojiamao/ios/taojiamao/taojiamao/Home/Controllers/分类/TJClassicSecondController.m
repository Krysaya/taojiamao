
//
//  TJClassicSecondController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassicSecondController.h"
#import "TJFiltrateView.h"
#import "TJMultipleChoiceView.h"
#import "TJJHSuanCell.h"
#import "TJDefaultGoodsDetailController.h"
#import "TJGoodsListCell.h"
#import "TJJHSGoodsListModel.h"
#import "TJSearchScreenView.h"

@interface TJClassicSecondController ()<TJFiltrateViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,TJMultipleChoiceViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,strong)TJFiltrateView *filtrate;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *type;

//@property (nonatomic, strong)MJRefreshStateHeader *header;
//@property (nonatomic, strong) MJRefreshAutoStateFooter *footer;
@end

@implementation TJClassicSecondController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;

    self.type = @"0";
    

    self.view.backgroundColor = RGB(245, 245, 245);
    self.title = self.title_class;
    
//    [self setNavgation];
    [self setFiltrateView];

    [self setUITableView];
    [self setUICollectionView];
    self.tableView.hidden = YES;
    WeakSelf
   
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf loadRequestNormalClassicGoodsList:self.type];
    }];
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadRequestClassicGoodsList:self.type];
    }];
    self.collectionView.mj_header = header;
    self.collectionView.mj_footer = footer;
    MJRefreshStateHeader *header2 = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf loadRequestNormalClassicGoodsList:self.type];
    }];
    
    MJRefreshAutoStateFooter *footer2 = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadRequestClassicGoodsList:self.type];
    }];
    [footer setTitle:@"----我们是有底线的----" forState:MJRefreshStateNoMoreData];
 
    self.tableView.mj_header = header2;
    self.tableView.mj_footer = footer2;
    if (self.tableView.hidden) {
    
        [self.collectionView.mj_header beginRefreshing];
    }else{
    
        [self.tableView.mj_header beginRefreshing];
    }
//    self.footer = footer;
//    self.header = header;
  

    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(horizontalVerticalTransformClass:) name:TJHorizontalVerticalTransformClass object:nil];
 
}
- (void)setFiltrateView{
    
        self.filtrate = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 45) withMargin:28];
        self.filtrate.backgroundColor = [UIColor whiteColor];
        self.filtrate.deletage = self;
        [self.view addSubview:self.filtrate];
    
}
- (void)loadRequestNormalClassicGoodsList:(NSString *)type{
    self.page = 1;
    self.dataArr = [NSMutableArray array];

    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    [SVProgressHUD show];
    NSString *str = [self.title_class stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *mdparam = @{ @"keyword":str,
                               @"order":type,@"page":pag,
                               @"page_num":@"10",};
    NSDictionary *param = @{ @"keyword":self.title_class,
                             @"order":type,@"page":pag,
                             @"page_num":@"10",};
    [KConnectWorking requestNormalDataMD5Param:mdparam withNormlParams:param withRequestURL:SearchGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject[@"data"];
        weakSelf.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        DSLog(@"-%lu-分类小分类-arr==",(unsigned long)weakSelf.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.collectionView reloadData];
        });
        weakSelf.page++;

        if (self.dataArr.count>0) {
            
        }else{
            self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nolist"]];
            self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nolist"]];
        }
        
        [weakSelf endRefrenshHeader];

    } withFailure:^(NSError * _Nullable error) {
        [weakSelf endRefrenshHeader];

        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
        [SVProgressHUD dismiss];
    }];
}

- (void)loadRequestClassicGoodsList:(NSString *)type{
    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    NSString *str = [self.title_class stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *mdparam = @{ @"keyword":str,
                               @"order":type,@"page":pag,
                               @"page_num":@"10",};
    NSDictionary *param = @{ @"keyword":self.title_class,
                             @"order":type,@"page":pag,
                             @"page_num":@"10",};
    [KConnectWorking requestNormalDataMD5Param:mdparam withNormlParams:param withRequestURL:SearchGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [weakSelf endRefrenshFooter];
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
       
    }];
}

- (void)endRefrenshHeader{
    
    if (self.tableView.hidden) {
        [self.collectionView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_header endRefreshing];
    }
}
- (void)endRefrenshFooter{
    
    if (self.tableView.hidden) {
        [self.collectionView.mj_footer endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)relodData{
    if (self.tableView.hidden) {
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }else{
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }
}
- (void)setNavgation{

    //    1边按钮
    TJButton *button_left = [[TJButton alloc]initDelegate:self backColor:nil tag:885 withBackImage:@"search" withSelectImage:nil];
//    //    you2边按钮
//    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:896 withBackImage:@"notice" withSelectImage:nil];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:button_left];
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:button_right];
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = item1;
}
-(void)setUITableView{
   UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+45+10, S_W, S_H-SafeAreaTopHeight-45-10) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"tabListCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setUICollectionView{
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+45+10, S_W, S_H-SafeAreaTopHeight-45-10) collectionViewLayout:layou];
    collectV.delegate = self;
    collectV.dataSource = self;
    collectV.backgroundColor = RGB(245, 245, 245);
    [collectV registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil]
forCellWithReuseIdentifier:@"TJJHSuanCell"];
    [self.view addSubview:collectV];
    self.collectionView = collectV;
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
    
    return CGSizeMake((S_W-5)/2, 270);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJJHSuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJJHSuanCell" forIndexPath:indexPath];
    cell.cell_type = @"search";
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tabListCell" forIndexPath:indexPath];
//        cell.model = self.dataArr[indexPath.row];
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
#pragma mark - TJFiltrateViewDelegate
-(void)requestWithKind:(NSString *)kind{
    if ([kind isEqualToString:@"综合"]) {
        DSLog(@"%@",kind);
        self.type = @"0";
        
    }else if ([kind isEqualToString:@"销量"]){
        DSLog(@"%@",kind);
        self.type = @"6";

//        [self loadRequestClassicGoodsList:@"6"];
    }else if ([kind isEqualToString:@"价格"]){
        DSLog(@"%@",kind);
        self.type = @"2";

//        [self loadRequestClassicGoodsList:@"2"];//高--低
        
        
    }else if ([kind isEqualToString:@"优惠券"]){
        DSLog(@"%@",kind);
        self.type = @"4";

//        [self loadRequestClassicGoodsList:@"4"];
        
    }else{
        DSLog(@"%@",kind);
        
    }
    
    [self loadRequestNormalClassicGoodsList:self.type];

}

-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
    TJMultipleChoiceView * mcv = [[TJMultipleChoiceView alloc]initWithFrame:self.view.bounds];
    mcv.deletage = self;
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:mcv];
}

- (void)buttonSureSelectString:(NSMutableDictionary *)sureDict{
//    筛选
    if (sureDict.count>0) {
        NSString *shoptype = sureDict[@"type"];
        NSString *str = [self.title_class stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        DSLog(@"筛选--？？？？")
        
        [KConnectWorking requestNormalDataMD5Param:@{ @"keyword":str,@"shoptype":shoptype,} withNormlParams:@{@"keyword":self.title_class, @"shoptype":shoptype,} withRequestURL:SearchGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
            NSDictionary *dict = responseObject[@"data"];
            if (dict.count>0) {
                self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                    [self.tableView reloadData];
                });
            }
            
        } withFailure:^(NSError * _Nullable error) {
            
        }];
    }
}
#pragma mark - 通知
-(void)horizontalVerticalTransformClass:(NSNotification*)info{
    DSLog(@"%@",info.userInfo[@"hsClassBool"]);
    NSNumber * num = info.userInfo[@"hsClassBool"];
    BOOL hs = [num boolValue];
    self.tableView.hidden = !hs;
    self.collectionView.hidden = hs;
    if (self.tableView.hidden) {
        
    }else{
        
    }
    
}
#pragma mark - btndelegte
- (void)buttonClick:(UIButton *)but{
    if (but.tag ==885) {
        
        //        搜索
    }else{
        //        TJNoticeController *noticeV = [[TJNoticeController alloc]init];
        //        [self.navigationController pushViewController:noticeV animated:YES];
    }
}



@end
