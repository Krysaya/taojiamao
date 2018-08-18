
//
//  TJAllOrderContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAllOrderContentController.h"
#import "TJCourierTakeCell.h"

#import "TJOrderInfoController.h"//订单详情
#import "TJKdUserOrderList.h"

@interface TJAllOrderContentController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TJAllOrderContentController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.zj_currentIndex==0) {
        [self loadNormalOrderList:nil];

    }else if (self.zj_currentIndex==1){
        [self loadNormalOrderList:@"2"];
    }else if (self.zj_currentIndex==2){
        [self loadNormalOrderList:@"3"];
    }else{
        [self loadNormalOrderList:@"4"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-50-SafeAreaTopHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
      [tableView registerNib:[UINib nibWithNibName:@"TJCourierTakeCell" bundle:nil] forCellReuseIdentifier:@"CourierTakeCell"];
    [self.view addSubview:tableView];
    self.tableView =tableView;
}

- (void)loadNormalOrderList:(NSString *)status{
    
  
    self.dataArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    
    if (status==nil) {
        DSLog(@"---0===");
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"type":@"2",
                                    
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
//        DSLog(@"--%@--sign",md5Str);
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = KdOrderList;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{ @"type":@"2"};
        } onSuccess:^(id  _Nullable responseObject) {
            self.dataArr = [TJKdUserOrderList mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } onFailure:^(NSError * _Nullable error) {
          
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
  
            
        }];
    }else{
//
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"type":@"2",
                                    @"status":status,
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
                DSLog(@"--%@--sign",md5Str);

        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = KdOrderList;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{ @"type":@"2",
                                    @"status":status,};
        } onSuccess:^(id  _Nullable responseObject) {
            self.dataArr = [TJKdUserOrderList mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } onFailure:^(NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 258;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJCourierTakeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CourierTakeCell"];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJKdUserOrderList *model =  self.dataArr[indexPath.row];
        TJOrderInfoController *vc = [[TJOrderInfoController alloc]init];
    vc.kdid = model.id;
    vc.kdstatus = model.status;
    [self.navigationController pushViewController:vc animated:YES];
   
}

@end
