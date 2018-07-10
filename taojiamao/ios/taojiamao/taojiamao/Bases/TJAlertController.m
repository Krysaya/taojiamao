//
//  TJAlertController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAlertController.h"

@interface TJAlertController ()

@end

@implementation TJAlertController

+(TJAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message style:(UIAlertControllerStyle)style sureClick:(sureClick)sure cancelClick:(cancelClick)cancel{
    TJAlertController * alert = [TJAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sure(action);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancel(action);
    }]];
    
    return alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
