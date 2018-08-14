
//
//  TJRankingListContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJRankingListContentController.h"
#import "TJRankingListContentCell.h"

#import "TJRankListModel.h"
static NSString * const RankingListContentCell = @"RankingListContentCell";

@interface TJRankingListContentController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJRankingListContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type_main intValue]==1) {
        DSLog(@"rank---奖励");
        if ([self.time intValue]==0) {
            DSLog(@"jl===benz");
            [self laodRequestRankList:@"1" withTime:@"1"];
        }else{
            DSLog(@"jl===sshangz");
            [self laodRequestRankList:@"1" withTime:@"2"];
            
        }
    }else{
        DSLog(@"ramk===邀请");
        if ([self.time intValue]==0) {
            DSLog(@"yq===benz");
            [self laodRequestRankList:@"2" withTime:@"1"];
            
        }else{
            DSLog(@"yq===sshangz");
            [self laodRequestRankList:@"2" withTime:@"2"];
            
        }
    }
   
    self.tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TJRankingListContentCell class] forCellReuseIdentifier:RankingListContentCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)laodRequestRankList:(NSString *)type withTime:(NSString *)time{
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
                                @"type":type,
                                @"time":time,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = RanksList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.parameters = @{@"type":type,
                               @"time":time,
                               };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"rank--%@",responseObject);
        self.dataArr = [TJRankListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
//    }
    TJRankingListContentCell * cell = [tableView dequeueReusableCellWithIdentifier:RankingListContentCell forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
