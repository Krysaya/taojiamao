//
//  TJBalanceDetailsController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBalanceDetailsController.h"
#import "TJAssetsDetailListModel.h"
#import "TJDetailListCell.h"

static NSString * const TJUserBalanceDetailsCell = @"TJUserBalanceDetailsCell";

@interface TJBalanceDetailsController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation TJBalanceDetailsController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    if ([self.title isEqualToString:@"兑换记录"]) {
        DSLog(@"兑换");
    }else if ([self.title isEqualToString:@"提现记录"]){
        DSLog(@"提现");
        [self requestDetailWithType:nil];
    }else if ([self.title isEqualToString:@"余额明细"]){
        DSLog(@"余额明细");
        [self loadYueMingXi];
    }
}
- (void)requestDetailWithType:(NSString *)type{
//    提现
    WeakSelf
    [KConnectWorking requestNormalDataParam:@{@"type":self.tx_type,} withRequestURL:UserBalanceTakeList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        weakSelf.dataArray = [TJAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [weakSelf.tableView reloadData];

    } withFailure:^(NSError * _Nullable error) {
        
    }];
}

- (void)loadMembersList{
    WeakSelf
    [KConnectWorking requestNormalDataParam:@{@"user_type":@"1",@"type":@"3"} withRequestURL:UserBalanceDetail withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        weakSelf.dataArray = [TJAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [weakSelf.tableView reloadData];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}

- (void)loadYueMingXi{
    WeakSelf
    [KConnectWorking requestNormalDataParam:@{@"user_type":@"1",@"style":@"1"} withRequestURL:UserBalanceDetail withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        weakSelf.dataArray = [TJAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [weakSelf.tableView reloadData];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJDetailListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
