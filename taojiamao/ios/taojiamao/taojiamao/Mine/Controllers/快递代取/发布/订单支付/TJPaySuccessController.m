
//
//  TJPaySuccessController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPaySuccessController.h"
#import "TJCourierTakeController.h"
@interface TJPaySuccessController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_total;
@property (weak, nonatomic) IBOutlet UILabel *lab_type;
@property (weak, nonatomic) IBOutlet UILabel *lab_sjf;
@property (weak, nonatomic) IBOutlet UILabel *lab_jjf;

@end

@implementation TJPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)finishBtnClick:(UIButton *)sender {
    TJCourierTakeController *vc = [[TJCourierTakeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
