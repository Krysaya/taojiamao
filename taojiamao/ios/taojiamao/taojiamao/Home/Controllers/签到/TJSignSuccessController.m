
//
//  TJSignSuccessController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSignSuccessController.h"

@interface TJSignSuccessController ()

@end

@implementation TJSignSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle =UIModalPresentationCustom;

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

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
