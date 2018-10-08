
//
//  TJBargainContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBargainContentController.h"
#import "TJBargainHeadCell.h"
#import "TJGoodsListCell.h"
#import "TJGoodsCollectModel.h"
#import "TJGoodCatesMainListModel.h"
#import "TJDefaultGoodsDetailController.h"

@interface TJBargainContentController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataGoodsArr;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSString *indes;
@property (nonatomic, strong) NSString *cidd;
@end

@implementation TJBargainContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *indexx = [NSString stringWithFormat:@"%ld",self.zj_currentIndex];
    self.indes = indexx;
    if (self.zj_currentIndex==0||self.zj_currentIndex==1||self.zj_currentIndex==2) {
      
        [self loadReuqestNormalDataWithType:indexx  withcateType:nil];
    }else{
        TJGoodCatesMainListModel *model = self.dataArr[self.zj_currentIndex-3];
        self.cidd = model.cid;
        [self loadReuqestNormalDataWithType:indexx  withcateType:model.cid];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-116) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource =self;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJBargainHeadCell" bundle:nil] forCellReuseIdentifier:@"BargainHeadCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
   WeakSelf
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadReuqestDataWithType:self.indes withcid:self.cidd];
    }];
    [footer setTitle:@"----我们是有底线的----" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadReuqestNormalDataWithType:(NSString *)type  withcateType:(NSString *)cid{
    self.dataGoodsArr = [NSMutableArray array];
    self.page = 1;
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    
    if ([TJOverallJudge sharedJudge].netStatus==0) {
        [SVProgressHUD showInfoWithStatus:@"没有网络啦~"];
    }else{
        [SVProgressHUD show];
        WeakSelf
        NSMutableDictionary *param = @{}.mutableCopy;
        param[@"page"] = pag;
        param[@"page_num"] = @"10";
        if ([type intValue]==0) {//精选
            param[@"is_jing"] = @"1";
        }else if([type intValue]==1){
            //        9.9
        }else if([type intValue]==2){
            param[@"is_jiu"] = @"1";
        }else{
            param[@"cid"] = cid;
        }
        [KConnectWorking requestNormalDataParam:param withRequestURL:GoodsJiuJiuList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                    [SVProgressHUD dismiss];
            weakSelf.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
             [weakSelf.tableView reloadData];
            weakSelf.page++;

            } withFailure:^(NSError * _Nullable error) {
                            [SVProgressHUD dismiss];
            }];
        
    }
}

- (void)loadReuqestDataWithType:(NSString *)type withcid:(NSString *)cid{
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    WeakSelf
    NSMutableDictionary *param = @{}.mutableCopy;
    param[@"page"] = pag;
    param[@"page_num"] = @"10";
    if ([type intValue]==0) {//精选
        param[@"is_jing"] = @"1";
    }else if([type intValue]==1){
        //        9.9
    }else if([type intValue]==2){
        param[@"is_jiu"] = @"1";
    }else{
        param[@"cid"] = cid;
    }
    [KConnectWorking requestNormalDataParam:param withRequestURL:GoodsJiuJiuList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        NSArray *arr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        if (arr.count==0) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.dataGoodsArr addObjectsFromArray:arr];
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        }
       
    } withFailure:^(NSError * _Nullable error) {
    }];
    
}
#pragma mark - tableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataGoodsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    [cell cellWithArr:self.dataGoodsArr forIndexPath:indexPath isEditing:NO withType:@"1"];
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        return 134;
//    }
    return 160;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJGoodsCollectModel *model = self.dataGoodsArr[indexPath.row];
    goodVC.gid = model.itemid;
    //    goodVC.price = model.itemprice;goodVC.priceQuan = model.itemendprice;
    [self.navigationController pushViewController:goodVC animated:YES];
}




@end
