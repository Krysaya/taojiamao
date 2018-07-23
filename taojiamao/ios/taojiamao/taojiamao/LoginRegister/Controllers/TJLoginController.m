//
//  TJLoginController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJLoginController.h"
#import "TJRegisterController.h"
#import "TJTextFieldView.h"

#import "XMNetworking.h"


#define LoLoginTag          123321
#define RegisterTag         654123
#define ForgetTag           987456
#define CloseTag            561439

#define GetVerifyCodeTag    999555555
@interface TJLoginController ()<UIScrollViewDelegate,TJButtonDelegate>

//关闭按钮
@property (nonatomic, strong) TJButton *btn_close;

@property(nonatomic,strong)UIImageView* nameImage;
@property(nonatomic,strong)UIView * loginView;

@property(nonatomic,strong)UIView * loginMode;
/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;
/**内容视图*/
@property (nonatomic,strong)UIScrollView * contentScrollow;
@property(nonatomic,strong)UIView * userNameLogin;
@property(nonatomic,strong)UIView * phoneNumLogin;

@property(nonatomic,strong)TJTextFieldView * userNameF;
@property(nonatomic,strong)TJTextFieldView * passwordF;
@property(nonatomic,strong)TJTextFieldView * phoneNumF;
@property(nonatomic,strong)TJTextFieldView * verifyF;

@property(nonatomic,strong)TJButton * registerbut;
@property(nonatomic,strong)TJButton * forgetbut;
@property(nonatomic,strong)TJButton * getVerifyCode;
@property(nonatomic,strong)TJButton * loginbut;

@property(nonatomic,strong)UIImageView * cutOffRule;

@property(nonatomic,strong)UIView * shareView;

@end

@implementation TJLoginController{
    BOOL isClick;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.isblack = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btn_close = [[TJButton alloc]initDelegate:self backColor:nil tag:CloseTag withBackImage:@"morentouxiang"];
    [self.view addSubview:self.btn_close];
    [self.btn_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35*H_Scale);
        make.width.height.mas_equalTo(20);
        make.left.mas_equalTo(20*W_Scale);
    }];
    
    [self setSubViewss];
    [self setLoginViewSubView];
    // 
    [self titleBtnClick:self.titleBtns[0]];
    [self customScrollview];
    //
    [self setTextFilesAndUnderline];
    //
    [self setFourButtons];
    //


}
#pragma mark -设置子控件
-(void)setSubViewss{
    self.nameImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    self.nameImage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nameImage];
    WeakSelf
    [self.nameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21*W_Scale+SafeAreaTopHeight);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(114*W_Scale);
        make.height.mas_equalTo(38*W_Scale);
    }];
    
    self.loginView  = [[UIView alloc]init];
    self.loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameImage.mas_bottom).offset(56*W_Scale);
        make.width.mas_equalTo(weakSelf.view.yj_width);
        make.height.mas_equalTo(179*W_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
    }];

}
#pragma mark -设置登录模式页
-(void)setLoginViewSubView{

    self.loginMode = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 34*W_Scale)];
    self.loginMode.backgroundColor = [UIColor whiteColor];
    [self.loginView addSubview:self.loginMode];
    //添加所有的标题按钮
    [self addAllTitleBtns];
    //添加下划线
    [self setupUnderLineView];
}
- (void)addAllTitleBtns{
    NSArray * titles = @[@"账号登录",@"快捷登录"];
    
    CGFloat btnW = 73*W_Scale;
    CGFloat btnH = self.loginMode.bounds.size.height;
    CGFloat b = (self.loginMode.bounds.size.width - (2*btnW)-59)*W_Scale/2;
    for (int i = 0; i < titles.count; i++) {
        UIButton * titleBtn = [[UIButton alloc]init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(b+(i * (btnW+59)), 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        //设置文字颜色
        [titleBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        //设置选中按键的文字颜色
        [titleBtn setTitleColor:KALLRGB forState:UIControlStateSelected];
        
        [self.loginMode addSubview:titleBtn];
        
        [self.titleBtns addObject:titleBtn];
        
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
//        NSLog(@"---frame--%f--%@",b,NSStringFromCGRect(titleBtn.frame));
    }
    
}
#pragma mark -切换登录模式点击
- (void)titleBtnClick:(UIButton *)titleBtn{
    
    isClick = YES;
    // 1.标题按钮点击三步曲
    self.preBtn.selected = NO;
    titleBtn.selected = YES;
    self.preBtn = titleBtn;
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.yj_centerX = titleBtn.yj_centerX;
        // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
        self.contentScrollow.contentOffset = CGPointMake(tag * S_W, 0);
    }];

}
#pragma mark setScrollview
- (void)customScrollview{
    
    UIScrollView * contentScrollow = [[UIScrollView alloc]init];
    self.contentScrollow = contentScrollow;
//    self.contentScrollow.backgroundColor = RandomColor;
    self.contentScrollow.contentSize = CGSizeMake(self.titleBtns.count*S_W, 0);
    [self.loginView addSubview:contentScrollow];
    contentScrollow.delegate = self;
    contentScrollow.pagingEnabled = YES;
    contentScrollow.bounces = NO;
    contentScrollow.showsHorizontalScrollIndicator = NO;
    WeakSelf
    [self.contentScrollow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.loginMode.mas_bottom);
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(147*W_Scale);
        make.centerX.mas_equalTo(weakSelf.loginView);
    }];
    //具体的登录界面
    self.userNameLogin = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 147*W_Scale)];
    self.userNameLogin.backgroundColor = [UIColor whiteColor];
    [self.contentScrollow addSubview:self.userNameLogin];
    
    self.phoneNumLogin = [[UIView alloc]initWithFrame:CGRectMake(S_W, 0, S_W, 147*W_Scale)];
    self.phoneNumLogin.backgroundColor = [UIColor whiteColor];
    [self.contentScrollow addSubview:self.phoneNumLogin];
    
}
#pragma mark -- uscrollviewDelegate
//开始拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isClick = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算拖拽的比例
    CGFloat ratio = scrollView.contentOffset.x / scrollView.yj_width;
    // 将整数部分减掉，保留小数部分的比例(控制器比例的范围0~1.0)
    ratio = ratio - self.preBtn.tag;
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    
    if (isClick) {
        UIButton * titleBtn = self.titleBtns[index];
        self.lineView.yj_centerX = titleBtn.yj_centerX;
        isClick = YES;
    }else{
        self.lineView.yj_centerX = self.preBtn.titleLabel.yj_centerX+scrollView.contentOffset.x/2.5;
    }
}
//结束拖动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    UIButton *titleBtn = self.titleBtns[index];
    
    // 调用标题按钮的点击事件
    [self titleBtnClick:titleBtn];
}
#pragma mark - 添加下滑线
- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = KALLRGB;
    // 下滑线高度
    CGFloat lineViewH = 2;
    CGFloat y = self.loginMode.yj_height - lineViewH;
    self.lineView.yj_height = lineViewH;
    self.lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    self.lineView.yj_width = titleBtn.titleLabel.yj_width + 2;
    self.lineView.yj_centerX = titleBtn.yj_centerX;
  
    [self.loginMode addSubview:self.lineView];
}
#pragma mark -setTextFilesAndUnderline
-(void)setTextFilesAndUnderline{
    WeakSelf
    self.userNameF = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入账号" image:@"account_gray" highlightImage:@"account_light"];
    self.passwordF = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入密码" image:@"psw_gray" highlightImage:@"psw_light"];
    
    [self.userNameLogin addSubview:self.userNameF];
    [self.userNameLogin addSubview:self.passwordF];
    
    [self.userNameF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*H_Scale);
        make.centerX.mas_equalTo(weakSelf.userNameLogin);
        make.width.mas_equalTo(260*W_Scale);
        make.height.mas_equalTo(42*W_Scale);
    }];
    [self.passwordF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.mas_equalTo(weakSelf.userNameF);
        make.top.mas_equalTo(weakSelf.userNameF.mas_bottom).offset(13*H_Scale);
    }];
    
    self.phoneNumF = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入手机号" image:@"phonenum_gray" highlightImage:@"phonenum_light"];
    self.verifyF = [[TJTextFieldView alloc]initWithPlaceholder:@"请输入验证码" image:@"checknum_gray" highlightImage:@"checknum_light"];
    [self.phoneNumLogin addSubview:self.phoneNumF];
    [self.phoneNumLogin addSubview:self.verifyF];
    [self.phoneNumF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.phoneNumLogin);
        make.top.height.width.mas_equalTo(weakSelf.userNameF);
    }];
    [self.verifyF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.mas_equalTo(weakSelf.phoneNumF);
        make.top.mas_equalTo(weakSelf.phoneNumF.mas_bottom).offset(13*H_Scale);
    }];
    
}
#pragma mark - setFourButtons
-(void)setFourButtons{

    self.registerbut = [[TJButton alloc]initWith:@"注册账号" delegate:self font:12*W_Scale titleColor:KALLRGB backColor:[UIColor whiteColor] tag:RegisterTag];
    self.forgetbut = [[TJButton alloc]initWith:@"忘记密码" delegate:self font:12*W_Scale titleColor:RGB(128, 128, 128) backColor:[UIColor whiteColor] tag:ForgetTag];
    self.loginbut = [[TJButton alloc]initWith:@"登录" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:KALLRGB tag:LoLoginTag cornerRadius:22.0];
    
    [self.view addSubview:self.registerbut];
    [self.view addSubview:self.forgetbut];
    [self.view addSubview:self.loginbut];
    WeakSelf
    [self.registerbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.passwordF);
        make.top.mas_equalTo(weakSelf.loginView.mas_bottom).offset(17*W_Scale);
    }];
    [self.forgetbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.passwordF);
        make.top.mas_equalTo(weakSelf.registerbut);
    }];
    [self.loginbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.loginView.mas_bottom).offset(65*W_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(260*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
    
    //分割线
    self.cutOffRule = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    self.cutOffRule.backgroundColor = RandomColor;
    [self.view addSubview:self.cutOffRule];
    [self.cutOffRule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.loginbut.mas_bottom).offset(50*H_Scale);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(S_W-10);
        make.height.mas_equalTo(21);
    }];
    
    //获取验证码
    self.getVerifyCode = [[TJButton alloc]initWith:@"获取验证码" delegate:self font:13*W_Scale titleColor:KALLRGB backColor:[UIColor whiteColor] tag:GetVerifyCodeTag];
    [self.phoneNumLogin addSubview:self.getVerifyCode];
    [self.getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(weakSelf.verifyF);
        make.bottom.mas_equalTo(weakSelf.verifyF).offset(-1);

    }];
    
//    分享
    self.shareView = [[UIView alloc]init];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shareView];
    
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.cutOffRule.mas_bottom).offset(35);
        
        make.bottom.left.right.equalTo(weakSelf.view);
    }];
    
    
    CGFloat btnW = 50*W_Scale;
    CGFloat btnH = 50*H_Scale;
    CGFloat b = (S_W-2*35-3*btnW)/2;
    for (int i = 0; i<3; i++) {
        UIButton * shareBtn = [[UIButton alloc]init];
        shareBtn.tag = i;
        shareBtn.frame = CGRectMake(b+(btnW+35)*i, 0, btnW, btnH);
        
        [shareBtn setImage:[UIImage imageNamed:@[@"login_tb",@"login_wx",@"login_qq"][i]] forState:UIControlStateNormal];
        [self.shareView addSubview:shareBtn];
        
        [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchDown];
        
        
    }
    
}
#pragma mark - TJButtonDelegate
-(void)buttonClick:(UIButton *)but{
    [self.view endEditing:YES];
    if (but.tag==RegisterTag) {
        TJRegisterController * rgvc = [[TJRegisterController alloc]init];
        rgvc.isRegister = YES;
        [self presentViewController:rgvc animated:YES completion:nil];

//        [self.navigationController pushViewController:rgvc animated:YES];
    }else if(but.tag==ForgetTag){
        TJRegisterController * rgvc = [[TJRegisterController alloc]init];
        rgvc.isRegister = NO;
        [self presentViewController:rgvc animated:YES completion:nil];
//        [self.navigationController pushViewController:rgvc animated:YES];
    }else if (but.tag==GetVerifyCodeTag){
        DSLog(@"获取验证码");
//        点击后的状态  改变-----
        if (self.phoneNumF.text==nil || self.phoneNumF.text.length==0) {
            DSLog(@"手机号不能为空");
        }else{
            [[TJGetVerifyCode sharedInstance] getVerityWithURL:GETVerfityCode withParams:@{@"telephone":self.phoneNumF.text} withButton:self.getVerifyCode withBlock:^(BOOL isGood) {
                if (isGood) {
                    DSLog(@"收到短信了 ");
                }else{
                    DSLog(@"服务器或者手机格式错误等造成发送失败");
                }
            }];
        }
    }else if(but.tag==CloseTag){
//        关闭vc
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{

            DSLog(@"账号登录");
            if (self.userNameF.text==nil || self.userNameF.text.length==0||self.passwordF.text==nil||self.passwordF.text.length==0) {
                DSLog(@"有值为空");
            }else{
                NSDictionary * dict = @{
                                        @"telephone":self.userNameF.text,
                                        @"password":self.passwordF.text,
                                        @"status":@(self.preBtn.tag+1),
                                        };
                KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
                NSString *timeStr = [MD5 timeStr];
                NSMutableDictionary *md = @{
                                               @"timestamp": timeStr,
                                               @"app": @"ios",
                                               @"telephone":self.userNameF.text,
                                               @"password":self.passwordF.text,
                                               @"status":@(self.preBtn.tag+1),
                                               }.mutableCopy;
                
                NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:@"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"];
                [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                    request.url =LoginWithUserName;
                    request.parameters = dict;
                    request.headers = @{@"timestamp": timeStr,
                                        @"app": @"ios",
                                        @"sign":md5Str,};
                    request.httpMethod = kXMHTTPMethodPOST;
                }onSuccess:^(id  _Nullable responseObject) {
                    
                    
                    //写入
                    NSDictionary * data = responseObject[@"data"];
                    SetUserDefaults(data[@"id"], UID);
                    SetUserDefaults(HADLOGIN, HADLOGIN);
                    NSLog(@"----login-success-%@===ID%@",responseObject,data[@"id"]);
                    //控制器跳转
                    [self dismissViewControllerAnimated:YES completion:nil];
                } onFailure:^(NSError * _Nullable error) {
                    NSLog(@"----login-≈≈error-%@",error);

                }];

            }

    }
}


#pragma mark - 切换登录方式
- (void)shareBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
//            tb
            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
        default:
            break;
    }
    
}
#pragma mark -lazyloading
- (NSMutableArray *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    DSLog(@"%s",__func__);
    [[TJGetVerifyCode sharedInstance]cancelTimer];
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
