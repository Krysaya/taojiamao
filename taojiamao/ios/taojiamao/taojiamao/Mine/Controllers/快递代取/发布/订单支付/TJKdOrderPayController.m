
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
        
    }];
}

- (void)doAliPay
{
//    NSString *appID = @"2018081861059806";
//    NSString *rsa2PrivateKey = @"MIIEpAIBAAKCAQEAxhfAyxUf7DFFGRrBiO7GCeAyWvbaSXZ+7kcciWLQU7ztEgTZlsrpHoiVn+sD5L19y9HFfaf8By+Zf5DUz00v4qyfGx9myqLdvEms95fmBBEsCfGh2bx1PdZ4MDjat7oDHJA2rgeUOGjSISzlufuMU9VgSfzEmz9Y/LSjNxKECmGh/uiJ8xo1PXG3b1EgDUvMHBpMb9RK6LE/rMnQkJIUtSOvR3uK/wF6NQeUX3m3EH/szTTWNgAtKxZpZ2zn8TctZUBw9t7Z9WSU8qSQmsIIYdvEb9zYzraHMKAyft3XZHggXkLpuWXpje+dVQJIbW/koxYJE3BjafX68NnpwlT4AQIDAQABAoIBAH3BdJY4SfTC7o/aaYTJuJVqa+1NixRaEoioQliBj6mpZYMr6wqMtGO65+oG44jiNysed9amvxu8vyC5zC/yW3T2i2dHjxUTQdsXlqP0HYT1ddS2Pj6hInjoX5KVdVxvzSvj7aKbkyAgg02mWAyywcoyypcNza6VD6QV9QuwSHzhkFrgrhn5M8sX5uxCgvVq8nUrYuW8EcAo7/TdYrNrJBGljpuUTOJdYSKZphY3l+pNimo4NqIpB1x5c/pumPZGX4mjiQio3etLLfxt5PzVIIbVr/Ab1j7sIO5vQhupyWYoqtMwMQLHWkITci3goyYOY5v1b/cUbwLZ/eUPMdl0OhUCgYEA/gSb+z4p7pfuSw6iYJJb3XlSyNEKnINeU9RiqGuPoT22/Prx/LOZCewnQ4JEZsvJnGIoqH6gnKK4WXxbvk3/qUw8gIfr3TIZ3GUQXtIboy97vk35UkatWYlIlmH7R8yleamJdqeLGM9emeFx4wYsnx+qY1pqGXz/xAfO49uFhv8CgYEAx6NveGXTgvnWYSKLvdmfL4tUsMuuW8OqTpXfm0bMGP+przvgEmKnHG+43TR5PKQApTjERKP2WwWtNPEyubUKVCimZUFMxRnSiWXl8r80SjWg9xoCDheK3kZvj35Ifi4bHc5ulu4jzzpktaS1xRkuxX1cAbI6pR57Ya+4XN8sgP8CgYEA580S/kGrCDSS2uF+4fuNY1zcY68HLO5gfMU6RpDpH+3ud4sUmlLWHAzpg5xziQ78av3UNnZfYLDI47gtDEunOzn7mBrw7QhUOx/qwWygldi15mLHWwJuHF+/4qOFJ+8jLhO9Ao8/yqMpo+jsAYzX2VmPJl0SpzG/QIcTkDD598cCgYEAq8NAKvRhELVn71bLqGJOhZd5HEuCDk3Af7CPHIfDHlcJZU08slTStrKg+SEmljf8nirDItN3KEUwCvbiz8ilxFbdIw0Vwhc/fxt+xmYf1SFjBncIAZvbzPYJEgpy0K1Wg0SS/aSShr8U2vuFsLjD9wKuYH852crqGNgY5T7WiX0CgYB8ioz8Rye5e5HA1bsGNkjBvc3XLT25ydudmRoKSujS7uwFLTal47gUfQEiweSd6TEnf/qxHjVTrxidHQc6jptL2eVgWqHN0JS5LzfZj4mXFJyX+oeFzgrByY0eYuqNrh41y8jgdgAI9RNcpRKKWAhYae0VbW9UU1w7AdVvZbodmQ==";
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    TJAliPayOrderInfo* order = [TJAliPayOrderInfo new];
    
    // NOTE: app_id设置
//    order.app_id = appID;
//
//    // NOTE: 支付接口名称
//    order.method = @"alipay.trade.app.pay";
//
//    // NOTE: 参数编码格式
//    order.charset = @"utf-8";
//
//    // NOTE: 当前时间点
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = [formatter stringFromDate:[NSDate date]];
//
//    // NOTE: 支付版本
//    order.version = @"1.0";
//
//    // NOTE: sign_type 根据商户设置的私钥来决定
//    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"发布订单";
    order.biz_content.out_trade_no = self.model.id; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
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
    
   
    [SVProgressHUD show];

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
                    [SVProgressHUD showSuccessWithStatus:@"支付成功"];[SVProgressHUD dismissWithDelay:1];
                    TJPaySuccessController *vc = [[TJPaySuccessController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"支付失败"];[SVProgressHUD dismissWithDelay:1];
                    TJPayFailController *vc = [[TJPayFailController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
      
    }onFailure:^(NSError * _Nullable error) {
        DSLog(@"-error--%@---",error);[SVProgressHUD showErrorWithStatus:@"网络异常，请重试！"];
        [SVProgressHUD dismissWithDelay:1];

    }];
   
}
- (NSString *)encodeingStr:(NSString *)str{
    NSString *codestr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return codestr;
}
@end
