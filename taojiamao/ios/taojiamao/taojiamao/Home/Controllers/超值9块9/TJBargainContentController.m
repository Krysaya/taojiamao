
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
    [SVProgressHUD show];
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    
    if ([type intValue]==0) {//精选
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"is_jing":@"1",
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = GoodsJiuJiuList;
            request.timeoutInterval = 20;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{      @"is_jing":@"1",};
        } onSuccess:^(id  _Nullable responseObject) {
            DSLog(@"--jingx99==%@",responseObject);
            [SVProgressHUD dismiss];
            self.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];

            });
        } onFailure:^(NSError * _Nullable error) {
            [SVProgressHUD dismiss];
        }];
    }else if([type intValue]==1){
//        9.9
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
//                                    @"is_jiu":@"",
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = GoodsJiuJiuList;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
//            request.parameters = @{      @"is_jiu":jjtype,};
        } onSuccess:^(id  _Nullable responseObject) {
            DSLog(@"--909==%@",responseObject);
            [SVProgressHUD dismiss];

            self.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
            
                        });
        } onFailure:^(NSError * _Nullable error) {            [SVProgressHUD dismiss];
        }];
    }else if([type intValue]==2){
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"is_jiu":@"1",
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = GoodsJiuJiuList;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{      @"is_jiu":@"1",};
        } onSuccess:^(id  _Nullable responseObject) {
            DSLog(@"--1909==%@",responseObject);
            [SVProgressHUD dismiss];

             self.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
            
                        });
        } onFailure:^(NSError * _Nullable error) { [SVProgressHUD dismiss];
        }];
    }else{
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"cid":cid,
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = GoodsJiuJiuList;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{      @"cid":cid,};
        } onSuccess:^(id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
                        DSLog(@"--ccc==%@",responseObject);
             self.dataGoodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
            
                        });
        } onFailure:^(NSError * _Nullable error) {            DSLog(@"--111==%@",error);
            [SVProgressHUD dismiss];
        }];
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
