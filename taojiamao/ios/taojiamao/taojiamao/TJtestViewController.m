//
//  TJtestViewController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJtestViewController.h"
#import <WebKit/WebKit.h>

@interface TJtestViewController ()
@property(nonatomic,strong)UIButton * test;

@property(nonatomic,strong)WKWebView * webView;
@end

@implementation TJtestViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://hws.m.taobao.com/cache/mtop.wdetail.getItemDescx/4.1/?data={item_num_id:%20%22559622264020%22}"]]];
    [self.view addSubview:self.webView];
    return;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.test = [[UIButton alloc]init];
    self.test.backgroundColor = [UIColor orangeColor];
    self.test.titleLabel.textColor = [UIColor blackColor];
    [self.test setTitle:@"woshikongde " forState:UIControlStateNormal];
    self.test.frame = CGRectMake(20, 100, 200, 50);
    [self.test addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.test];
    
    
}

-(void)click{
    [self.navigationController popViewControllerAnimated:YES];
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
