
//
//  TJKdOrderPayController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdOrderPayController.h"
#import "TJKdMyQuanController.h"
#import "TJKdMyQuanModel.h"
#import "TJAliPayOrderInfo.h"
#import "TJKdOrderInfoModel.h"
#import "TJPaySuccessController.h"
#import "TJPayFailController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface TJKdOrderPayController ()<MyQuanControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_total;
@property (weak, nonatomic) IBOutlet UILabel *lab_sjf;
@property (weak, nonatomic) IBOutlet UILabel *lab_dyq;
@property (weak, nonatomic) IBOutlet UILabel *lab_jjf;

@property (weak, nonatomic) IBOutlet UIButton *btn_zfb;
@property (weak, nonatomic) IBOutlet UIButton *btn_wx;
@property (weak, nonatomic) IBOutlet UIButton *btn_yue;

@property (weak, nonatomic) IBOutlet UILabel *lab_status;
@property (weak, nonatomic) IBOutlet UIView *view_bottom;

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSString *select_status;
@property (nonatomic, strong) NSString *qid;

@end

@implementation TJKdOrderPayController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self showModel];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseQuan)];
    [self.view_bottom addGestureRecognizer: tap];
    self.selectBtn = self.btn_zfb;

    [self showModel];
}

- (void)showModel{
    self.lab_sjf.text = [NSString  stringWithFormat:@"¥ %@.00", self.model.qu_fee];
    self.lab_jjf.text =  [NSString  stringWithFormat:@"¥ %@.00", self.model.is_ji];;
    
    if ([self.model.is_ji intValue]==6) {
        self.lab_jjf.text = @"¥ 10.00";
    }
    int a = [self.model.qu_fee intValue];
    int b = [self.model.is_ji intValue];
    self.lab_total.text = [NSString stringWithFormat:@"%d.00",a+b];
}
- (void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选优惠券
- (void)chooseQuan{
    TJKdMyQuanController *vc = [[TJKdMyQuanController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getQuanInfoValue:(TJKdMyQuanModel *)quanModel{
    self.qid = quanModel.id;
    self.lab_dyq.text = [NSString  stringWithFormat:@"-¥ %@.00", quanModel.coupon];
    self.lab_status.text = [NSString  stringWithFormat:@"- ¥ %@.00", quanModel.coupon];
    self.lab_sjf.text = [NSString  stringWithFormat:@"¥ %@.00", self.model.qu_fee];
    if ([self.model.is_ji intValue]==6) {
        self.lab_jjf.text = @"¥ 10.00";
    }
    self.lab_jjf.text =  [NSString  stringWithFormat:@"¥ %@.00", self.model.is_ji];;

    
    int sjf;
    int jjf;
    int dyq;
    
    sjf = [self.model.qu_fee intValue];
    if ([self.model.is_ji intValue]==6) {jjf = 10;}else{jjf = [self.model.is_ji intValue];}
    dyq = [quanModel.coupon intValue];

    int total = sjf+jjf-dyq;
    if (total>0) {
        self.lab_total.text = [NSString stringWithFormat:@"%d.00",total];
    }else{
        self.lab_total.text = @"0.00";
    }
}
- (IBAction)choosePayType:(UIButton *)sender {
    if (!sender.selected) {
        self.selectBtn.selected = !self.selectBtn.selected;
        sender.selected = !sender.selected;
        self.selectBtn = sender;
    }
    
    if (self.selectBtn==_btn_zfb) {
        self.select_status = @"1";
    }else if(self.selectBtn==_btn_wx){
        self.select_status = @"2";
    }else{
        self.select_status = @"3";
    }
}

- (IBAction)payButtonClick:(UIButton *)sender {
//    ===========支付类型-----------------判断状态
    if (self.selectBtn==_btn_yue) {
        DSLog(@"余额支付");[self requestYuePay];
    }else if (self.selectBtn==_btn_zfb){
        DSLog(@"支付宝支付");[self doAliPay];
    }else{
        DSLog(@"微信支付");
    }
    
}

- (void)requestYuePay{
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    
    if (!self.qid) {
        DSLog(@"===%@--qid",self.qid);
        self.qid = @"0";
    }else{
        DSLog(@"==zzzzzz=%@--qid",self.qid);
        
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"quan_id":self.qid,
                                @"kuaidi_id":self.model.id,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdOrderYuePay;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"quan_id":self.qid,
                                @"kuaidi_id":self.model.id,};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----pay=-success-===%@",responseObject);
        
        TJPaySuccessController *vc = [[TJPaySuccessController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
}

- (void)doAliPay
{

    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    TJAliPayOrderInfo* order = [TJAliPayOrderInfo new];

    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"发布订单";
    order.biz_content.out_trade_no = self.model.id; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%@", self.lab_total.text]; //====0.01商品价格
    NSString *userid = GetUserDefaults(UID);
    if (userid) {}else{userid = @"";}
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSString *body = [self encodeingStr:order.biz_content.body];
    NSString *subj = [self encodeingStr:order.biz_content.subject];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"body":body,
                                @"subject":subj,
                                @"out_trade_no":order.biz_content.out_trade_no,
                                @"timeout_express":order.biz_content.timeout_express,
                                @"total_amount":order.biz_content.total_amount,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    
   

    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdOrderAliPaySign;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
//        request.timeoutInterval = 100;
        request.parameters = @{  @"body":order.biz_content.body,
                                 @"subject":order.biz_content.subject,
                                 @"out_trade_no":order.biz_content.out_trade_no,
                                 @"timeout_express":order.biz_content.timeout_express,
                                 @"total_amount":order.biz_content.total_amount,};
    }onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"---%@---",responseObject);
        [SVProgressHUD dismiss];

        if (responseObject[@"data"]) {
            NSString *appScheme = @"taojiamaoscheme";
            NSString *orderString = responseObject[@"data"];
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut =啥啥啥s's's %@",resultDic);
                if ([resultDic[@"resultStatus"] intValue]==9000) {
                    [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                    TJPaySuccessController *vc = [[TJPaySuccessController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"支付失败"];
                    TJPayFailController *vc = [[TJPayFailController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
      
    }onFailure:^(NSError * _Nullable error) {
        DSLog(@"-error--%@---",error);[SVProgressHUD showErrorWithStatus:@"网络异常，请重试！"];
      

    }];
   
}
- (NSString *)encodeingStr:(NSString *)str{
    NSString *codestr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return codestr;
}
@end
