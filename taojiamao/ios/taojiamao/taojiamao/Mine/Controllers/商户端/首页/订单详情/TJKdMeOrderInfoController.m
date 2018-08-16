
//
//  TJKdMeOrderInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMeOrderInfoController.h"
#import "TJOrderHeadViewCell.h"//头
//#import "TJOrderInfoCell.h"//四个info
#import "TJOrderTypeCell.h"//快递类型
#import "TJOrderInfoOneCell.h"//取件码，时间
#import "TJOrderPersonCell.h"//头像
#import "TJAdressCell.h"
#import "TJAdressTwoCell.h"

#import "TJKdOrderInfoModel.h"

@interface TJKdMeOrderInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TJKdOrderInfoModel *model;

@end

@implementation TJKdMeOrderInfoController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-60) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJOrderHeadViewCell" bundle:nil] forCellReuseIdentifier:@"OrderHeadViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJOrderInfoOneCell" bundle:nil] forCellReuseIdentifier:@"OrderInfoOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJOrderTypeCell" bundle:nil] forCellReuseIdentifier:@"OrderTypeCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressCell" bundle:nil] forCellReuseIdentifier:@"AdressCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressTwoCell" bundle:nil] forCellReuseIdentifier:@"AdressTwoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJOrderPersonCell" bundle:nil] forCellReuseIdentifier:@"OrderPersonCell"];

    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self loadrequestOrderInfoList];
    if ([self.kdstatus intValue]==0) {
//        绿
        [self setBottmButtonWithBtnTitle:@"抢单" withBtnBackGroundColor:[UIColor greenColor]];
    }else if([self.kdstatus intValue]==4){
//----完成
    }else if([self.kdstatus intValue]==1){
        [self setBottmButtonWithBtnTitle:@"已接单" withBtnBackGroundColor:KKDRGB];

    }else{
    }
    
}
- (void)setBottmButtonWithBtnTitle:(NSString *)title withBtnBackGroundColor:(UIColor *)color
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, S_H-50, S_W-30, 40)];
    btn.backgroundColor = color;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:btn];
}
#pragma mark  -request

- (void)loadrequestOrderInfoList{
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
                                @"id":self.kdid,
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    //        DSLog(@"--%@--sign",md5Str);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdUserOrderDetail;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"id":self.kdid};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----kdorder=-success-===%@",responseObject);
        TJKdOrderInfoModel *model = [TJKdOrderInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = model;
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
    // Dispose of any resources that can be recreated.
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.kdstatus intValue]==0) {
        return 4;
    }else{
        return 6;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJKdOrderInfoModel *model = self.model;
//等待接单-----12送取
    if ([self.kdstatus intValue]==0) {
      
        if (indexPath.row==0) {
            //        订单状态
            TJOrderHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeadViewCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==1){
            //        订单信息
            TJOrderInfoOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoOneCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==2){
            //        送
            TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
            cell.model = model;

            return cell;
        }else {
            //        取件
            TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
            cell.model = model;

            return cell;
        }
    }else{
        if (indexPath.row==0) {
            //        订单状态
            TJOrderHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeadViewCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==1){
            //        订单信息
            TJOrderInfoOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoOneCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==2){
            //        快递类型
            TJOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTypeCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==3){
            TJOrderPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderPersonCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==4){
            //        送
            TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
            cell.model = model;
            return cell;
        }else {
            //        取件
            TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
            cell.model = model;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.kdstatus intValue]==0) {
        if (indexPath.row==0) {
            return 65;
        }else if (indexPath.row==1){
            return 85;
        }else if (indexPath.row==2){
            return 100;
        }else {
            return 70;
        }
    }else{
        if (indexPath.row==0) {
            return 65;
        }else if (indexPath.row==1){
            return 85;
        }else if (indexPath.row==2){
            return 85;
        }else if (indexPath.row==3){
            return 90;
        }else if (indexPath.row==4){
            return 100;
        }else {
            return 70;
        }
    }
}


@end
