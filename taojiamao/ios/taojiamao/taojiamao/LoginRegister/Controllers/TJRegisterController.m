//
//  TJRegisterController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJRegisterController.h"
#import "TJTextFieldView.h"

#define GetVerify   222555
#define SureTag    333555
#define CloseTag    848652
@interface TJRegisterController ()<TJButtonDelegate>

@property(nonatomic,strong)UILabel * label;
@property (nonatomic, strong) TJButton *btn_close;
@property(nonatomic,strong)TJTextFieldView * mobile;
@property(nonatomic,strong)TJTextFieldView * verify;
@property(nonatomic,strong)TJTextFieldView * password;
@property(nonatomic,strong)TJButton * getVerifiCode;
@property(nonatomic,strong)TJButton * sure;

@end

@implementation TJRegisterController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.btn_close = [[TJButton alloc]initDelegate:self backColor:nil tag:CloseTag withBackImage:@"kd_close" withSelectImage:nil];
    self.btn_close.layer.cornerRadius = 15;
    self.btn_close.layer.masksToBounds = YES;
    [self.view addSubview:self.btn_close];
    [self.btn_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35*H_Scale);
        make.width.height.mas_equalTo(30);
        make.left.mas_equalTo(20*W_Scale);
    }];
    
    [self setHeadViews];
    [self setTextFields];
    [self setButtons];
}
#pragma mark - setHeadViews
-(void)setHeadViews{
    
    self.label = [[UILabel alloc]init];
    if (self.isRegister) {
        self.label.text = @"注册账号";
    }else{
        self.label.text = @"忘记密码";
    }
    self.label.textColor = KALLRGB;
    self.label.font = [UIFont systemFontOfSize:23*W_Scale];
    [self.view addSubview:self.label];
    WeakSelf
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(51*H_Scale+SafeAreaTopHeight);
    }];
}
#pragma mark -setTextFiless
-(void)setTextFields{
    WeakSelf
    self.mobile = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入手机号" image:@"phonenum_gray" highlightImage:@"phonenum_light" with:NO];
    [self.view addSubview:self.mobile];
    
    [self.mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.label.mas_bottom).offset(53*H_Scale);
        make.width.mas_equalTo(260*W_Scale);
        make.height.mas_equalTo(42*H_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    
    self.verify = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入验证码" image:@"checknum_gray" highlightImage:@"checknum_light" with:NO];
    [self.view addSubview:self.verify];
    [self.verify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mobile.mas_bottom).offset(13*H_Scale);
        make.centerX.width.height.mas_equalTo(weakSelf.mobile);
    }];
    if (self.isRegister) {
        self.password = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入密码" image:@"psw_gray" highlightImage:@"psw_light" with:YES] ;
    }else{
        self.password = [[TJTextFieldView alloc]initWithPlaceholder:@"请设置新密码(长度不超过16位)" image:@"psw_gray" highlightImage:@"psw_light" with:YES];
    }
    
    [self.view addSubview:self.password];;
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.verify.mas_bottom).offset(13*H_Scale);
        make.centerX.width.height.mas_equalTo(weakSelf.mobile);
    }];
}
#pragma mark - setButtons
-(void)setButtons{
    self.getVerifiCode  = [[TJButton alloc]initWith:@"获取验证码" delegate:self font:13*W_Scale titleColor:KALLRGB backColor:[UIColor whiteColor] tag:GetVerify];
//    CGFloat a = self.verify.frame.size.height-1;
//    self.getVerifiCode.frame = CGRectMake(0, 0, 0, a);
    [self.view addSubview:self.getVerifiCode];
    WeakSelf
    [self.getVerifiCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(weakSelf.verify);
        make.bottom.mas_equalTo(weakSelf.verify).offset(-1);

    }];
    
    self.sure = [[TJButton alloc]initWith:@"确定" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:KALLRGB tag:SureTag cornerRadius:22.0];
    [self.view addSubview:self.sure];
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
    make.top.mas_equalTo(weakSelf.password.mas_bottom).offset(75*H_Scale);
        make.width.mas_equalTo(260*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}
#pragma mark - TJButtonDelegate
-(void)buttonClick:(UIButton *)but{
    [self.view endEditing:YES];
    if (but.tag==GetVerify) {
        if (self.mobile.text==nil || self.mobile.text.length==0) {
            DSLog(@"手机号不能为空");
        }else{
            if ([TJOverallJudge judgeMobile:self.mobile.text]) {
                [[TJGetVerifyCode sharedInstance] getVerityWithURL:GETVerfityCode withParams:@{@"telephone":self.mobile.text} withButton:self.getVerifiCode withBlock:^(BOOL isGood) {
                    if (isGood) {
                        DSLog(@"收到短信了 ");
                    }else{
                        DSLog(@"服务器或者手机格式错误等造成发送失败");
                    }
                }];
                
            }else{
                [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号！"];
            }
           
        }
    }else if(but.tag==CloseTag){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
       
        
        if (self.mobile.text==nil || self.mobile.text.length==0 ||self.verify.text==nil || self.verify.text.length==0 ||self.password.text==nil || self.password.text.length==0 ) {
            [SVProgressHUD showInfoWithStatus:@"输入不能为空！"];

        }else{
            
            if ([TJOverallJudge judgeMobile:self.mobile.text]) {
                KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
                NSString *timeStr = [MD5 timeStr];
                
                NSDictionary * dict =@{
                                       @"telephone":self.mobile.text,
                                       @"code":self.verify.text,
                                       @"password":self.password.text
                                       };
                
                NSMutableDictionary *mdstr = @{
                                               @"timestamp": timeStr,
                                               @"app": @"ios",
                                               @"telephone":self.mobile.text,
                                               @"code":self.verify.text,
                                               @"password":self.password.text
                                               }.mutableCopy;
                
                NSString *md5Str = [MD5 sortingAndMD5SignWithParam:mdstr withSecert:@"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"];
                if (self.isRegister) {
                    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                        request.url = RegisterApp;
                        request.httpMethod = kXMHTTPMethodPOST;
                        request.parameters = dict;
                        request.headers = @{ @"timestamp": timeStr,
                                             @"app": @"ios",
                                             @"sign":md5Str,
                                             };
                    } onSuccess:^(id  _Nullable responseObject) {
                        DSLog(@"注册成功===%@",responseObject[@"id"]);
                        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                        //                    写入
                        SetUserDefaults(responseObject[@"id"], UID);
                        // SetUserDefaults(data[@"ptoken"], TOKEN);
                        SetUserDefaults(HADLOGIN, HADLOGIN);
                        SetUserDefaults(self.mobile.text, UserPhone);
                        //控制器跳转
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } onFailure:^(NSError * _Nullable error) {
                        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
                        DSLog(@"----注册-≈≈error-%@",dic_err[@"msg"]);
                        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
                        
                    }];
                    
                }else{
                    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                        request.url = SubmitNewPass;
                        request.httpMethod = kXMHTTPMethodPOST;
                        request.parameters = dict;
                        request.headers = @{ @"timestamp": timeStr,
                                             @"app": @"ios",
                                             @"sign":md5Str,
                                             };
                    } onSuccess:^(id  _Nullable responseObject) {
                        DSLog(@"修改mm成功===%@",responseObject);
                        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                        //控制器跳转
                                            [self.navigationController popViewControllerAnimated:YES];
                        //                    //这里是否要自动登录？
                    } onFailure:^(NSError * _Nullable error) {
                        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
                        DSLog(@"----修改mm-≈≈error-%@",dic_err[@"msg"]);
                        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
                    }];
                    
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"手机号格式有误！"];

            }
           
        }
    }
}

#pragma mark - setter getter

-(void)dealloc{
//    DSLog(@"%s",__func__);
    [[TJGetVerifyCode sharedInstance]cancelTimer];
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
