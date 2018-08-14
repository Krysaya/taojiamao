//
//  TJVipFansContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJVipFansContentController.h"
#import "TJVipFansContentCell.h"
#import "TJVipFensListModel.h"
static NSString * const VipFansContentCell = @"VipFansContentCell";

@interface TJVipFansContentController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJVipFansContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.index intValue]==0) {
        DSLog(@"1du");
        [self loadRequestVipFansListWithLeavel:@"1"];
    }else if ([self.index intValue]==1){
        DSLog(@"2du");

    }else{
        DSLog(@"3du");

    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight-76-44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TJVipFansContentCell class] forCellReuseIdentifier:VipFansContentCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark - request

- (void)loadRequestVipFansListWithLeavel:(NSString *)level{
    self.dataArr = @{}.mutableCopy;
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
                                @"fans_level":level,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = MemeberFans;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.parameters = @{@"fans_level":level,
                               };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"fans--%@",responseObject);
        self.dataArr = [TJVipFensListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJVipFansContentCell * cell = [tableView dequeueReusableCellWithIdentifier:VipFansContentCell forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
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
