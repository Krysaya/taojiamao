
//
//  TJKdMyOrderContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyOrderContentController.h"
#import "TJKdUserOrderList.h"
#import "TJKdHomePageTwoCell.h"

#import "TJKdMeOrderInfoController.h"
@interface TJKdMyOrderContentController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TJKdMyOrderContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.zj_currentIndex==0) {
        [self loadRequestMemenbersOrderList:nil];

    }else if (self.zj_currentIndex==1){
        [self loadRequestMemenbersOrderList:@"2"];

    }else if (self.zj_currentIndex==2){
        [self loadRequestMemenbersOrderList:@"3"];

    }else{
        [self loadRequestMemenbersOrderList:@"4"];

    }
    self.view.backgroundColor = KBGRGB;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = KBGRGB;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = 200;
    [tableView registerNib:[UINib nibWithNibName:@"TJKdHomePageTwoCell" bundle:nil] forCellReuseIdentifier:@"KdHomePageTwoCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
#pragma mark - request
- (void)loadRequestMemenbersOrderList:(NSString *)status{
    self.dataArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    
    
    if (status==nil) {
        DSLog(@"qubu==");
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"type":@"1",
                                    
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = KdOrderList;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{ @"type":@"1",
                                    };
        } onSuccess:^(id  _Nullable responseObject) {
            self.dataArr = [TJKdUserOrderList mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            //        DSLog(@"sh----yjd---%@",responseObject);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } onFailure:^(NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
            
        }];
    }else{
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":@"1",
                                @"status":status,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdOrderList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"type":@"1",
                                @"status":status,};
    } onSuccess:^(id  _Nullable responseObject) {
        self.dataArr = [TJKdUserOrderList mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        //        DSLog(@"sh----yjd---%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        
    }];}
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdHomePageTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdHomePageTwoCell"];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdUserOrderList *model = self.dataArr[indexPath.row];
    TJKdMeOrderInfoController *vc = [[TJKdMeOrderInfoController alloc]init];
    vc.kdid = model.id;
    vc.kdstatus = model.status;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
