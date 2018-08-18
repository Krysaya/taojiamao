
//
//  TJKdMyQuanController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyQuanController.h"
#import "TJKdMyQuanModel.h"
#import "TJKdMyQuanCell.h"
@interface TJKdMyQuanController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJKdMyQuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的抵用券";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-50) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 160;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJKdMyQuanCell" bundle:nil] forCellReuseIdentifier:@"MyQuanCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self loadRequestQuan];
}

#pragma mark - request

- (void)loadRequestQuan{
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
                                @"type":@"2",
                                @"status":@"0",
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    //        DSLog(@"--%@--sign",md5Str);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdMyQuan;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"status":@"0", @"type":@"2"};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"=--quan-=--%@",responseObject);
        self.dataArr = [TJKdMyQuanModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdMyQuanCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MyQuanCell"];
//    cell.deletage = self;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdMyQuanModel *model = self.dataArr[indexPath.row];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getQuanInfoValue:)]) {
        [self.delegate getQuanInfoValue:model];
    }
}
@end
