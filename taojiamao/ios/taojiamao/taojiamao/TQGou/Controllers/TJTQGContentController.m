
//
//  TJTQGContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTQGContentController.h"
#import "TJTQGContentCell.h"
#import "TJTqgGoodsModel.h"
#import "TJTqgTimesListModel.h"
static NSString * const TQGContentCell = @"TQGContentCell";

@interface TJTQGContentController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJTQGContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
//    [self.tableView reloadData];
}
//- (void)requestGoodsListWithModel:(NSString *)agr{
//    //    列表
//    self.dataArr  = [NSArray array];
//    NSString *userid = GetUserDefaults(UID);
//    if (userid) {
//    }else{
//        userid = @"";
//    }
//    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
//    NSString *timeStr = [MD5 timeStr];
//    NSMutableDictionary * param = @{
//                                    @"page_size":@"10",
//                                    @"timestamp": timeStr,
//                                    @"app": @"ios",
//                                    @"uid": userid,
//                                    @"start_time": agr,
//                                    
//                                    }.mutableCopy;
//    
//    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:param withSecert:@"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"];
//    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
//        request.url = TQGGoodsList;
//        request.parameters = @{   @"page_size":@"10",
//                                  @"start_time": agr};
//        request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str,@"uid": userid};
//        request.httpMethod = kXMHTTPMethodPOST;
//        //        request.requestSerializerType = kXMRequestSerializerRAW;
//    }onSuccess:^(id responseObject) {
//        self.dataArr = [TJTqgGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            
//        });
//        
//        NSLog(@"onSuccess:==tqgggggg=%@===%ld",responseObject,self.dataArr.count);
//        
//    } onFailure:^(NSError *error) {
//        
//    }];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tabelV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaBottomHeight) style:UITableViewStylePlain];
    tabelV.delegate = self;
    tabelV.dataSource = self;
    tabelV.rowHeight = 157;
    tabelV.tableFooterView = [UIView new];
    [tabelV registerClass:[TJTQGContentCell class] forCellReuseIdentifier:TQGContentCell];
    [self.view addSubview:tabelV];
    self.tableView = tabelV;
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJTQGContentCell *cell = [tableView dequeueReusableCellWithIdentifier:TQGContentCell forIndexPath:indexPath];
    NSLog(@"-子-cell-------%ld",self.dataArr.count);
//    if (self.dataArr.count==0) {
//        
//    }else{
//        self.dataArr = nil;
//    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)reloadTableViewData{
    
    NSLog(@"--ccview-%ld--",self.dataArr.count);
//    self.dataArr = nil;
   

    [self.tableView reloadData];
}


@end
