
//
//  TJKdMyOpintionMyController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyOpintionMyController.h"
#import "XMTextView.h"
@interface TJKdMyOpintionMyController ()

@property(nonatomic,strong)NSString *content;
@end

@implementation TJKdMyOpintionMyController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = KBGRGB;
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(15, 15+SafeAreaTopHeight, S_W-30, 225)];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.masksToBounds = YES;
    bg.layer.cornerRadius = 6;
    [self.view addSubview:bg];
    XMTextView *tv = [[XMTextView alloc]initWithFrame:CGRectMake(0, 0, S_W-30, 225)];
    tv.placeholder = @"聊聊您的看法，欢迎您参与我们的产品建设，说不定您的一句吐槽将成为下一次产品改进的指导。（140字范围内）";
    tv.placeholderColor =RGB(151, 151, 151);
    tv.textMaxNum = 140;
    tv.borderLineWidth = 0;
    tv.textFont = [UIFont systemFontOfSize:15];
    tv.textViewListening = ^(NSString *textViewStr) {
        DSLog(@"tv监听输入的内容：%@",textViewStr);
        self.content = textViewStr;
    };
    [bg  addSubview:tv];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 275+SafeAreaTopHeight, S_W-20, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
}
-(void)btnClick:(UIButton *)sender
{
    if (self.content.length<=0) {
        [SVProgressHUD showInfoWithStatus:@"输入不能为空！"];
    }
// 提交
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSString *content = [self.content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"content":content,      
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = FeedBack;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"content":self.content,
                                };
    } onSuccess:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        [self.navigationController  popViewControllerAnimated:YES];
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
