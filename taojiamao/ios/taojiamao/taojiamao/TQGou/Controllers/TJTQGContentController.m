
//
//  TJTQGContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTQGContentController.h"
#import "TJTqgGoodsModel.h"
#import "TJTQGCell.h"

static NSString * const TQGContentCell = @"GContentCell";

@interface TJTQGContentController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJTQGContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (self.tableView) {
//        DSLog(@"有了");
//    }else{
        UITableView *tabelV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight-50) style:UITableViewStylePlain];
        tabelV.delegate = self;
        tabelV.dataSource = self;
        tabelV.rowHeight = 157;
        tabelV.tableFooterView = [UIView new];
//        [tabelV registerClass:[TJTQGContentCell class] forCellReuseIdentifier:TQGContentCell];
        [tabelV registerNib:[UINib nibWithNibName:@"TJTQGCell" bundle:nil] forCellReuseIdentifier:TQGContentCell];
        [self.view addSubview:tabelV];
        self.tableView = tabelV;
//    }
}


- (void)requestGoodsListWithModel:(TJTqgTimesListModel *)model{
    //    商品列表
    self.dataArr  = [NSArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary * param = @{
                                    @"page_size":@"5",
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid": userid,
                                    @"start_time": model.arg,
                                    
                                    }.mutableCopy;
    
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:param withSecert:@"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = TQGGoodsList;
        request.parameters = @{  @"page_size":@"5",@"start_time": model.arg};
        request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str,@"uid": userid};
        request.httpMethod = kXMHTTPMethodPOST;
    }onSuccess:^(id responseObject) {
//        NSLog(@"onSuccess:=tjjjjjj==%@",responseObject);
        
        self.dataArr = [TJTqgGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        
    } onFailure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TJTQGCell *cell = [tableView dequeueReusableCellWithIdentifier:TQGContentCell];
    
    cell.model = self.dataArr[indexPath.row];
    return cell;
}


@end
