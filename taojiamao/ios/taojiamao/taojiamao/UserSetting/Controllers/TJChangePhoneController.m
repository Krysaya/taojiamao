//
//  TJChangePhoneController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJChangePhoneController.h"

#define CPGetVerify 875849
#define CPSure 630741
@interface TJChangePhoneController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;

@property(nonatomic,strong)UILabel * phoneLabel;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UIView * phoneLine;

@property(nonatomic,strong)UILabel * verifyLabel;
@property(nonatomic,strong)UITextField * verifyField;
@property(nonatomic,strong)TJButton * getVerify;
@property(nonatomic,strong)UIView * verifyLine;

@property(nonatomic,strong)UILabel * passLabel;
@property(nonatomic,strong)UITextField * passField;
@property(nonatomic,strong)UIView * passLine;

@property(nonatomic,strong)UILabel * sureLabel;
@property(nonatomic,strong)UITextField * sureField;

@property(nonatomic,strong)TJButton * sure;

@end

@implementation TJChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.vcID) {
        case 0:
            self.title = @"修改手机号";
            break;
        case 1:
            self.title = @"设置提现账户";
            break;
        default:
            self.title = @"修改密码";
            break;
    }
    [self setUI];
}
-(void)setUI{
    CGFloat headViewH;
    switch (self.vcID) {
        case 0:
            headViewH =158*H_Scale;
            break;
        case 1:
            headViewH =104*H_Scale;
            break;
        default:
            headViewH = 207*H_Scale;
            break;
    }
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, S_W,headViewH)];
    self.headView.backgroundColor = RandomColor;
    [self.view addSubview:self.headView];
    
    WeakSelf
    self.phoneLabel = [self setLabelWith:@"" font:15*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17*H_Scale);
        make.left.mas_equalTo(20*W_Scale);
    }];
    self.phoneLabel.text = self.vcID==1?@"支付宝账号":@"手机号码";
    
    self.phoneField = [[UITextField alloc]init];
    self.phoneField.backgroundColor = [UIColor grayColor];
    if (self.vcID==0) {
//        self.phoneField.text = GetUserDefaults(UserPhone);
        self.phoneField.text = @"17731934096";
        self.phoneField.userInteractionEnabled  = NO;
    }else if (self.vcID==1){
        self.phoneField.placeholder = @"请填写支付宝账号";
    }else{
        self.phoneField.placeholder = @"请输入要设置的手机号";
    }
    self.phoneField.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.headView addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.phoneLabel);
        make.right.mas_equalTo(-20*W_Scale);
        make.width.mas_equalTo(243*W_Scale);
        make.height.mas_equalTo(25*H_Scale);
    }];
    
    self.phoneLine = [[UIView alloc]init];
    self.phoneLine.backgroundColor = RGB(51, 51, 51);
    [self.headView addSubview:self.phoneLine];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneLabel.mas_bottom).offset(17*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(1);
    }];
    
    //--------------
    self.verifyLabel = [self setLabelWith:@"" font:15*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.verifyLabel];
    [self.verifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneLine.mas_bottom).offset(17*H_Scale);
        make.left.mas_equalTo(20*W_Scale);
    }];
    self.verifyLabel.text = self.vcID==1?@"支付宝实名":@"验证码";
    
    self.verifyField = [[UITextField alloc]init];
    self.verifyField.backgroundColor = [UIColor grayColor];
    self.verifyField.placeholder = self.vcID==1?@"请填写支付宝账号实名":@"请输入验证码";
    self.verifyField.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.headView addSubview:self.verifyField];
    [self.verifyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.verifyLabel);
        make.right.mas_equalTo(-20*W_Scale);
        make.width.mas_equalTo(243*W_Scale);
        make.height.mas_equalTo(25*H_Scale);
    }];
    
    self.verifyLine = [[UIView alloc]init];
    self.verifyLine.backgroundColor = RGB(51, 51, 51);
    self.verifyLine.hidden = self.vcID==1?YES:NO;
    [self.headView addSubview:self.verifyLine];
    [self.verifyLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.verifyLabel.mas_bottom).offset(17*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(1);
    }];
    
    self.getVerify = [[TJButton alloc]initWith:@"获取验证码" delegate:self font:14*W_Scale titleColor:[UIColor redColor] backColor:[UIColor whiteColor] tag:CPGetVerify];
    self.getVerify.hidden = self.vcID==1?YES:NO;
    [self.headView addSubview:self.getVerify];
    [self.getVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.verifyField);
        make.centerY.mas_equalTo(weakSelf.verifyField);
    }];
    
    //-----
    if (!(self.vcID==1)) {
        self.passLabel = [self setLabelWith:@"" font:15*W_Scale color:RGB(51, 51, 51)];
        self.passLabel.text = self.vcID==2?@"新密码":@"登录密码";
        [self.headView addSubview:self.passLabel];
        [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.verifyLine.mas_bottom).offset(17*H_Scale);
            make.left.mas_equalTo(20*W_Scale);
        }];
        
        self.passField = [[UITextField alloc]init];
        self.passField.backgroundColor = [UIColor grayColor];
        self.passField.placeholder = self.vcID==2?@"请输入新密码":@"登录密码(6-16位字符)";
        self.passField.font = [UIFont systemFontOfSize:15*W_Scale];
        [self.headView addSubview:self.passField];
        [self.passField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.passLabel);
            make.right.mas_equalTo(-20*W_Scale);
            make.width.mas_equalTo(243*W_Scale);
            make.height.mas_equalTo(25*H_Scale);
        }];
        
        
        if (self.vcID==2) {
            self.passLine = [[UIView alloc]init];
            self.passLine.backgroundColor = RGB(51, 51, 51);
            [self.headView addSubview:self.passLine];
            [self.passLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.passLabel.mas_bottom).offset(17*H_Scale);
                make.centerX.mas_equalTo(weakSelf.headView);
                make.width.mas_equalTo(335*W_Scale);
                make.height.mas_equalTo(1);
            }];
            
            self.sureLabel = [self setLabelWith:@"确认密码" font:15*W_Scale color:RGB(51, 51, 51)];
            [self.headView addSubview:self.sureLabel];
            [self.sureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.passLine.mas_bottom).offset(17*H_Scale);
                make.left.mas_equalTo(20*W_Scale);
            }];
            
            self.sureField = [[UITextField alloc]init];
            self.sureField.backgroundColor = [UIColor grayColor];
            self.sureField.placeholder = @"确认新密码";
            self.sureField.font = [UIFont systemFontOfSize:15*W_Scale];
            [self.headView addSubview:self.sureField];
            [self.sureField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(weakSelf.sureLabel);
                make.right.mas_equalTo(-20*W_Scale);
                make.width.mas_equalTo(243*W_Scale);
                make.height.mas_equalTo(25*H_Scale);
            }];
        }
    }
    
    self.sure = [[TJButton alloc]initWith:@"确定" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:CPSure cornerRadius:20.0];
    [self.view addSubview:self.sure];
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headView.mas_bottom).offset(40*W_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}
#pragma mark - TJButtonDeletage
-(void)buttonClick:(UIButton *)but{
    
    if (but.tag == CPGetVerify) {
        DSLog(@"获取验证码");
        if (self.phoneField.text==nil || self.phoneField.text.length==0) {
            DSLog(@"手机号不能为空");
        }else{
            
            [[TJGetVerifyCode sharedInstance] getVerityWithURL:GETVerfityCode withParams:@{@"telephone":self.phoneField.text} withButton:self.getVerify withBlock:^(BOOL isGood) {
                if (isGood) {
                    DSLog(@"收到短信了 ");
                }else{
                    DSLog(@"服务器或者手机格式错误等造成发送失败");
                }
            }];
            
            
        }
        
    }else{
        
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSDictionary * dict =@{
                               @"telephone":self.phoneField.text,
                               @"code":self.verifyField.text,
                               @"password":self.passField.text
                               };
        
        NSMutableDictionary *mdstr = @{
                                       @"timestamp": timeStr,
                                       @"app": @"ios",
                                       @"telephone":self.phoneField.text,
                                       @"code":self.verifyField.text,
                                       @"password":self.passField.text
                                       }.mutableCopy;
        
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:mdstr withSecert:@"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"];
        
        

        if (self.vcID==0) {
            DSLog(@"修改手机号");
            [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                request.url = EditTelePhoneNum;
                request.httpMethod = kXMHTTPMethodPOST;
                request.parameters = dict;
                request.headers = @{ @"timestamp": timeStr,
                                     @"app": @"ios",
                                     @"sign":md5Str,
                                     };
            } onSuccess:^(id  _Nullable responseObject) {
                DSLog(@"修改成功===%@",responseObject);
                
            } onFailure:^(NSError * _Nullable error) {
                
            }];
            
        }else if (self.vcID==1){
            DSLog(@"绑定账户");
        }else{
            DSLog(@"修改密码");
            if (self.phoneField.text==nil || self.phoneField.text.length==0 ||self.verifyField.text==nil || self.verifyField.text.length==0 ||self.passField.text==nil || self.passField.text.length==0 ) {
                DSLog(@"有选项为空");
            }else{
                
                [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                    request.url = EditPassWord;
                    request.httpMethod = kXMHTTPMethodPOST;
                    request.parameters = dict;
                    request.headers = @{ @"timestamp": timeStr,
                                         @"app": @"ios",
                                         @"sign":md5Str,
                                         };
                } onSuccess:^(id  _Nullable responseObject) {
                    DSLog(@"修改成功===%@",responseObject);

                } onFailure:^(NSError * _Nullable error) {
                
                }];
            }
        }
    }
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
