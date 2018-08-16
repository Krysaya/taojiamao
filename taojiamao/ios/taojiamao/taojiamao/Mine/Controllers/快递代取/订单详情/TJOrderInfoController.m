
//
//  TJOrderInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderInfoController.h"
#import "TJKdFabuController.h"


#import "TJOrderHeadViewCell.h"//头
#import "TJOrderInfoCell.h"//四个info
#import "TJOrderTypeCell.h"//快递类型
#import "TJOrderInfoOneCell.h"//取件码，时间
#import "TJOrderPersonCell.h"//头像
#import "TJAdressCell.h"
#import "TJAdressTwoCell.h"

#import "TJKdOrderInfoModel.h"

@interface TJOrderInfoController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) TJKdOrderInfoModel *model;
@end

@implementation TJOrderInfoController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DSLog(@"---status--%@",self.kdstatus);
    [self loadrequestOrderInfoList];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
//    self.navigationController.navigationBar.barTintColor = RGB(81, 162, 249);
    
   
    
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
   [tableView registerNib:[UINib nibWithNibName:@"TJOrderInfoCell" bundle:nil] forCellReuseIdentifier:@"OrderInfoCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    if ([self.kdstatus intValue]==0) {
        TJButton *button_right = [[TJButton alloc]initWith:@"取消订单" delegate:self font:15.0 titleColor:[UIColor whiteColor] backColor:nil tag:142];
        // 修改导航栏左边的item
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
        [self setBottmButtonWithBtnTitle:@"修改订单"];
    }
    
}
- (void)setBottmButtonWithBtnTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, S_H-50, S_W-30, 40)];
    btn.backgroundColor = KKDRGB;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(editOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)editOrderClick:(UIButton *)sender{
//    修改订单
   TJKdFabuController *vc  = [[TJKdFabuController alloc]init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tjbuttonDelegate
- (void)buttonClick:(UIButton *)but{
//    取消订单
    DSLog(@"cancel取消");
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
        ////            取消
            [SVProgressHUD showSuccessWithStatus:@"取消成功"];
            [self.navigationController popViewControllerAnimated:YES];
        
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];


}
#pragma mark - request
- (void)loadrequestOrderInfoList{
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
            TJKdOrderInfoModel *model = [TJKdOrderInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.model = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.kdstatus intValue]==0||[self.kdstatus intValue]==5||[self.kdstatus intValue]==6) {
        return 6;
    }else{
        return 7;}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJKdOrderInfoModel *model = self.model;
    if ([self.kdstatus intValue]==0||[self.kdstatus intValue]==5||[self.kdstatus intValue]==6) {
    
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
            //        送
            TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==4){
            //        取件
            TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
            cell.model = model;
            return cell;
        }else{
            //        订单号
            TJOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoCell"];
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
            //        人
            TJOrderPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderPersonCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==4){
            //        取件
            TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
            cell.model = model;
            return cell;
        }else if (indexPath.row==5){
            //        取件
            TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
            cell.model = model;
            return cell;
        }else{
            //        订单号
            TJOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoCell"];
            cell.model = model;
            return cell;
        }
    }
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.kdstatus intValue]==0||[self.kdstatus intValue]==5||[self.kdstatus intValue]==6) {
        if (indexPath.row==0) {
            return 65;
        }else if (indexPath.row==1){
            return 85;
        }else if (indexPath.row==2){
            return 85;
        }else if (indexPath.row==3){
            return 100;
        }else if (indexPath.row==4){
            return 70;
        }else{
            return 147;
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
        }else if (indexPath.row==5){
            return 70;
        }else{
            return 147;
        }
    }
}


@end
