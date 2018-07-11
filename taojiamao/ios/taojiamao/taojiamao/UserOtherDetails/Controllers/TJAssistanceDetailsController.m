//
//  TJAssistanceDetailsController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAssistanceDetailsController.h"

@interface TJAssistanceDetailsController ()

@end

@implementation TJAssistanceDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助详情";
    
    [XDNetworking postWithUrl:UserAssistanceDetails refreshRequest:NO cache:NO params:nil progressBlock:nil successBlock:^(id response) {
        DSLog(@"%@",response);
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
    }];
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
