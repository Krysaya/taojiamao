//
//  TJBindTBController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBindTBController.h"
#import <AlibabaAuthSDK/ALBBSDK.h>

#define BindButton 125478

@interface TJBindTBController ()<TJButtonDelegate>

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * TBAccount;
@property(nonatomic,strong)UILabel * hadBind;
@property(nonatomic,strong)UILabel * noBind;
@property(nonatomic,strong)UIImageView * jj;
@property(nonatomic,strong)TJButton * cancel;

@property (nonatomic, strong) NSString *bind_tb;
@end

@implementation TJBindTBController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户绑定";
    [self setUI];
    
    self.bind_tb = GetUserDefaults(Bind_TB);
    if ([self.bind_tb intValue]==0) {
        self.hadBind.hidden = YES;self.noBind.hidden = NO;
        [self.cancel setTitle:@"去绑定"];self.jj.hidden = NO;
    }else{
        self.hadBind.hidden = NO;self.noBind.hidden = YES;
        [self.cancel setTitle:@"取消绑定"];self.jj.hidden = NO;
    }
}
-(void)setUI{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, S_W, 55*H_Scale)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    WeakSelf
    self.imageView = [[UIImageView alloc]init];[self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imgurl] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.headView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*W_Scale);
        make.centerY.mas_equalTo(weakSelf.headView);
        make.width.height.mas_equalTo(35*W_Scale);
    }];
    
    self.TBAccount = [self setLabelWith:self.nickname font:14 color:RGB(51, 51, 51)];
    [self.headView addSubview:self.TBAccount];
    [self.TBAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageView.mas_right).offset(15*W_Scale);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
    
    self.jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.headView addSubview:self.jj];
//    self.jj.hidden = YES;
    [self.jj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headView);
        make.right.mas_equalTo(-30*W_Scale);
        make.width.mas_equalTo(6*W_Scale);
        make.height.mas_equalTo(11*H_Scale);
    }];
    
    self.noBind =[self setLabelWith:@"未绑定" font:14 color:RGB(128, 128, 128)];
    [self.headView addSubview:self.noBind];
    self.noBind.hidden = YES;
    [self.noBind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.jj.mas_left).offset(-50*W_Scale);
        make.centerY.mas_equalTo(weakSelf.jj);
    }];
    
    self.cancel = [[TJButton alloc]initWith:@"去绑定" delegate:self font:14*W_Scale titleColor:[UIColor redColor] backColor:[UIColor whiteColor] tag:BindButton];
    [self.headView addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30*W_Scale);
        make.centerY.mas_equalTo(weakSelf.headView);
    }];
    
    self.hadBind = [self setLabelWith:@"(已绑定)" font:14 color:RGB(128, 128, 128)];
    [self.headView addSubview:self.hadBind];
    [self.hadBind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.cancel.mas_left).offset(-16*W_Scale);
        make.centerY.mas_equalTo(weakSelf.headView);
    }];
}
-(void)buttonClick:(UIButton *)but{
    if ([but.titleLabel.text isEqualToString:@"取消绑定"]) {
        DSLog(@"cancel");
        [self requestCancelBind];
    }else{
        DSLog(@"bind");
        [self requestBindTaoBao];
    }
}

- (void)requestBindTaoBao{
    ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
    [albbSDK setAppkey:@"25038195"];
    [albbSDK setAuthOption:NormalAuth];
    
    [albbSDK auth:self successCallback:^(ALBBSession *session){
        ALBBUser *user = [session getUser];
        [self requestTaoBaoLoginWithTaoToken:user.openId withImage:user.avatarUrl withNickName:user.nick];
    } failureCallback:^(ALBBSession *session,NSError *error){
    }];
    
    
}
- (void)requestTaoBaoLoginWithTaoToken:(NSString *)openid withImage:(NSString *)img withNickName:(NSString *)nick{

    NSString *bimg = [TJOverallJudge encodeToPercentEscapeString:img];
    NSString *bnick = [nick stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"tao_openid":openid,
                                @"tao_image":bimg,
                                @"tao_nick":bnick,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = BindTaoBao;
        request.parameters = @{ @"tao_openid":openid,
                                @"tao_image":img,
                                @"tao_nick":nick,};
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,};
        request.httpMethod = kXMHTTPMethodPOST;
    }onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"---%@---",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"绑定成功！"];
        SetUserDefaults(@"1", Bind_WX);
        self.hadBind.hidden = NO;self.noBind.hidden = YES;
        [self.cancel setTitle:@"取消绑定"];self.jj.hidden = NO;

    } onFailure:^(NSError * _Nullable error) {
        [SVProgressHUD showSuccessWithStatus:@"绑定失败！"];

    }];
    
}
- (void)requestCancelBind
{
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
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = CancelBindTaoBao;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"解绑成功！"];
        ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
        [albbSDK logout];
    } onFailure:^(NSError * _Nullable error) {
    }];
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
