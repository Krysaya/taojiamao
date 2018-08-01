//
//  TJBalanceDetailsController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBalanceDetailsController.h"
#import "TJBalanceDetailsModel.h"
#import "TJBalanceDetailsCell.h"

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
    }else if ([self.title isEqualToString:@"集分明细"]) {
//        [self networkWithURL:UserJFBDetails];
    }else if ([self.title isEqualToString:@"余额明细"]){
//        [self networkWithURL:UserBalanceDetail];
    }else if ([self.title isEqualToString:@"提现记录"]){
        DSLog(@"提现");
    }
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TJBalanceDetailsCell class] forCellReuseIdentifier:TJUserBalanceDetailsCell];
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJBalanceDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:TJUserBalanceDetailsCell forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70*H_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)networkWithURL:(NSString*)url{
//    NSDictionary * dict =@{@"uid":GetUserDefaults(UID)};
    NSDictionary *dict = @{@"uid":@"1"};//test
    [XDNetworking postWithUrl:url refreshRequest:NO cache:NO params:dict progressBlock:nil successBlock:^(id response) {
        DSLog(@"%@",response);
        NSArray * array = response[@"data"];
        for (NSDictionary*d in array) {
            TJBalanceDetailsModel * model = [TJBalanceDetailsModel yy_modelWithDictionary:d];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
    }];
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
