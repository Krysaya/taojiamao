//
//  ViewController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "ViewController.h"
#import "TJtestViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()


@property(nonatomic,strong)UIButton * test;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.test = [[UIButton alloc]init];
    self.test.titleLabel.textColor = [UIColor blackColor];
    [self.test setTitle:@"" forState:UIControlStateNormal];
    
    [self.view addSubview:self.test];
    [self.test mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(30);
//        make.bottom.mas_equalTo(300);
        make.edges.mas_equalTo(10);
    }];
    
    //test
    
    DSLog(@"%f----%f",W_Scale,H_Scale);
    DSLog(@"%d----%d",SafeAreaTopHeight,SafeAreaBottomHeight);
    
 
    if (IsX) {
        DSLog(@"X");
    }else{
        DSLog(@"bushi");
    }
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /*
     auth_code    是    string    IOS：md5(md5('ios_'.date(‘Y’).'_ios_').企业ID)
     st    是    string    系统类型（1：手机网站，2：android，3：ios）
     auth_client_id    是    string    企业ID
     tel    是    string    手机号码
     sms_type    是    int    短信类型—验证码（1新用户注册、用户登录,2修改绑定手机,3用户设置支付密码,4用户设置/修改登录密码）
     */
//    NSDictionary * dic = @{
//                           Auth_code:GetUserDefaults(Auth_code),
//                           ST:IOS,
//                           Auth_client_id:CompanyID,
//                           @"tel":@"17731934096",
//                           @"sms_type":@(1)
//                           };
//    [XDNetworking postWithUrl:@"http://www.feihutaoke.com/api36/common/send_sms.php" refreshRequest:NO cache:NO params:dic progressBlock:nil successBlock:^(id response) {
//        
//        //        NSString * dict =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        NSDictionary * dict = (NSDictionary*)response;
//        DSLog(@"%@",dict);
//        
//        [self.test setTitle:@"我有值啦 " forState:UIControlStateNormal];
//        
//        
//    } failBlock:^(NSError *error) {
//        
//    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
