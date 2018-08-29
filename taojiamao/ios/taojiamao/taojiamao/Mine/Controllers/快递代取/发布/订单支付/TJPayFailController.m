
//
//  TJPayFailController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPayFailController.h"

@interface TJPayFailController ()

@end

@implementation TJPayFailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)aginPayClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)checkOrderInfo:(UIButton *)sender {
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
