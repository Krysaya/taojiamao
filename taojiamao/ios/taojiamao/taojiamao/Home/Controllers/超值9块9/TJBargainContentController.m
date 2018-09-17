
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
@end

@implementation TJBargainContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.zj_currentIndex==0||self.zj_currentIndex==1||self.zj_currentIndex==2) {
        NSString *indexx = [NSString stringWithFormat:@"%ld",self.zj_currentIndex];
        [self loadReuqestNormalDataWithType:indexx  withcateType:nil];
    }else{
        TJGoodCatesMainListModel *model = self.dataArr[self.zj_currentIndex-3];
        NSString *indexx = [NSString stringWithFormat:@"%ld",self.zj_currentIndex];
        [self loadReuqestNormalDataWithType:indexx  withcateType:model.cid];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource =self;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJBargainHeadCell" bundle:nil] forCellReuseIdentifier:@"BargainHeadCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadReuqestNormalDataWithType:(NSString *)type  withcateType:(NSString *)cid{
    self.dataGoodsArr = [NSMutableArray array];
    if ([TJOverallJudge sharedJudge].netStatus==0) {
        [SVProgressHUD showInfoWithStatus:@"没有网络啦~"];
    }else{
        [SVProgressHUD show];
        WeakSelf
        if ([type intValue]==0) {//精选
            
            [KConnectWorking requestNormalDataParam:@{ @"is_jing":@"1",} withRequestURL:GoodsJiuJiuList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                weakSelf.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                //            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                
                //            });
            } withFailure:^(NSError * _Nullable error) {
                [SVProgressHUD dismiss];
            }];
        }else if([type intValue]==1){
            //        9.9
            [KConnectWorking requestNormalDataParam:nil withRequestURL:GoodsJiuJiuList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                weakSelf.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                //            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                
                //            });
            } withFailure:^(NSError * _Nullable error) {
                [SVProgressHUD dismiss];
            }];
            
        }else if([type intValue]==2){
            
            [KConnectWorking requestNormalDataParam:@{ @"is_jiu":@"1",} withRequestURL:GoodsJiuJiuList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                weakSelf.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                //            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                
                //            });
            } withFailure:^(NSError * _Nullable error) {
                [SVProgressHUD dismiss];
            }];
        }else{
            
            [KConnectWorking requestNormalDataParam:@{@"cid":cid,} withRequestURL:GoodsJiuJiuList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                weakSelf.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                [weakSelf.tableView reloadData];
            } withFailure:^(NSError * _Nullable error) {
                [SVProgressHUD dismiss];
            }];
            
        }
    }
    
  
    
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
