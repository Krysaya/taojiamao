
//
//  TJKdHomePaContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
// 未接单

#import "TJKdHomePaContentController.h"
#import "TJKdHomeOrderCell.h"
#import "TJKdUserOrderList.h"

#import "TJOrderInfoController.h"//订单详情
@interface TJKdHomePaContentController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TJKdHomePaContentController


- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 255;
    tableView.backgroundColor = KBGRGB;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJKdHomeOrderCell" bundle:nil] forCellReuseIdentifier:@"KdHomeOrderCell"];
    [self.view addSubview:tableView];
    [self loadRequestMemenbersOrderList:@"2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":@"1",
                                @"jie_status":status,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = OrderList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"type":@"1",
                                @"jie_status":status,};
    } onSuccess:^(id  _Nullable responseObject) {
        self.dataArr = [TJKdUserOrderList mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
//        DSLog(@"sh----djd---%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        
    }];
}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdHomeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdHomeOrderCell"];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
