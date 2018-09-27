
//
//  TJAgentAddressController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAgentAddressController.h"
#import "TJAddAddressController.h"
#import "TJAgentAdreessCell.h"
#import "TJMyAddressModel.h"
#import "TJAgentPayView.h"
#import "TJAliPayOrderInfo.h"
#import <AlipaySDK/AlipaySDK.h>

@interface TJAgentAddressController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,PayTypeBtnDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) TJAgentPayView  *payView;
@property (nonatomic, strong) NSString *aid;
@property (nonatomic, strong) NSString *oid;

@property (nonatomic, assign) NSInteger  type;
@end

@implementation TJAgentAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestMyAddressList];
    self.title = @"我的地址";
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame =CGRectMake(0,0, 60, 44);
    [addBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [addBtn setTitle:@"添加新地址"forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn addTarget:self action:@selector(addBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = barBut;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.yj_y, S_W, S_H-50) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.allowsMultipleSelectionDuringEditing = YES;
    tableView.backgroundColor = KBGRGB;
    
    [tableView registerNib:[UINib nibWithNibName:@"TJAgentAdreessCell" bundle:nil] forCellReuseIdentifier:@"AgentAdreessCell"];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];self.tableView = tableView;
    
    TJButton *sureBtn = [[TJButton alloc]initWith:@"确定" delegate:self font:16 titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:4899];
    sureBtn.frame = CGRectMake(0, S_H-49, S_W, 49);
    [self.view addSubview:sureBtn];
    
}
- (void)buttonClick:(UIButton *)but{
    if (self.aid) {
        //    r弹窗
        WeakSelf
        [KConnectWorking requestNormalDataParam:@{@"gid":self.gid,@"aid":self.aid,} withRequestURL:BuyAgentsCreatList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
            DSLog(@"creat-success-%@",responseObject);
            weakSelf.oid = responseObject[@"data"];
        } withFailure:^(NSError * _Nullable error) {
            
        }];
        TJAgentPayView  *payView = [[TJAgentPayView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) withMoney:self.money];
        payView.backgroundColor = RGBA(1, 1, 1, 0.2);
        [payView.btn_pay addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
        payView.delegate = self;
        self.type = 101;
        [self.view addSubview:payView];
        self.payView = payView;
    }else{
        [SVProgressHUD showInfoWithStatus:@"请选择先地址！"];
    }

}
#pragma mark - pay
- (void)payTypeButtonClick:(NSInteger)sender{
    DSLog(@"-payyyy--%ld",sender);
    self.type = sender;
}
- (void)pay{
    if (self.type==101) {
        DSLog(@"yue==pay");
        [KConnectWorking requestNormalDataParam:@{@"oid":self.oid,} withRequestURL:BuyAgentsPay withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
            DSLog(@"--%@--pay-",responseObject);
            if ([responseObject[@"msg"] isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"购买成功!"];
                [self.payView removeFromSuperview];
            }

        } withFailure:^(NSError * _Nullable error) {

        }];
    }else{
        DSLog(@"zfb==pay");            [SVProgressHUD showProgress:1 status:@"加载中~"];
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        TJAliPayOrderInfo* order = [TJAliPayOrderInfo new];
        // NOTE: 商品数据
        order.biz_content = [APBizContent new];
        order.biz_content.body = @"石家庄月雨科技有限公司";
        order.biz_content.subject = @"购买会员等级";
        order.biz_content.out_trade_no = self.oid; //订单ID（由商家自行制定）
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount = self.money; //====0.01商品价格
        NSString *body = [self encodeingStr:order.biz_content.body];
        NSString *subj = [self encodeingStr:order.biz_content.subject];
        [KConnectWorking requestNormalDataMD5Param:@{@"body":body,@"subject":subj,@"out_trade_no":order.biz_content.out_trade_no,@"timeout_express":order.biz_content.timeout_express,@"total_amount":order.biz_content.total_amount,@"type":@"level",} withNormlParams:@{@"body":order.biz_content.body,@"subject":order.biz_content.subject,@"out_trade_no":order.biz_content.out_trade_no,@"timeout_express":order.biz_content.timeout_express,@"total_amount":order.biz_content.total_amount,@"type":@"level",} withRequestURL:KdOrderAliPaySign withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            DSLog(@"--%@--",responseObject);
            if (responseObject[@"data"]) {
                NSString *appScheme = @"taojiamaoscheme";
                NSString *orderString = responseObject[@"data"];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut =啥啥啥s's's %@",resultDic);
                    if ([resultDic[@"resultStatus"] intValue]==9000) {
                        [SVProgressHUD showSuccessWithStatus:@"支付成功!"];
                      
                    }else{
                        [SVProgressHUD showSuccessWithStatus:resultDic[@"memo"]];
                    }
                }];
            }
        } withFailure:^(NSError * _Nullable error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"网络异常，请重试！"];
        }];
        
    }
}
- (void)addBtnClick:(UIButton *)sender{
    TJAddAddressController * aevc = [[TJAddAddressController alloc]init];
    [self.navigationController pushViewController:aevc animated:YES];
//    WeakSelf
//
//    [KConnectWorking requestNormalDataMD5Param:@{} withNormlParams:@{} withRequestURL:AddAddress withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
//
//    } withFailure:^(NSError * _Nullable error) {
//
//    }];
}
-(void)loadRequestMyAddressList{
    WeakSelf
    [KConnectWorking requestNormalDataParam:nil withRequestURL:AddressList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
          weakSelf.dataArray = [TJMyAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [weakSelf.tableView reloadData];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJAgentAdreessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AgentAdreessCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.selectedIndexPath isEqual:indexPath]) {
        cell.btn.selected = YES;
    }else{
        cell.btn.selected = NO;

    }
//    cell.model = self.dataArray[indexPath.section];
//    cell.deletage =self;
//    cell.indexPath = indexPath;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndexPath) {
        TJAgentAdreessCell * cell = (TJAgentAdreessCell *)[tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.btn.selected = NO;
    }
    TJAgentAdreessCell * cell = (TJAgentAdreessCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.btn.selected = YES;
    TJMyAddressModel *model = self.dataArray[indexPath.section];
    self.aid = model.id;
    self.selectedIndexPath = indexPath;
}

- (NSString *)encodeingStr:(NSString *)str{
    NSString *codestr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return codestr;
}

@end
