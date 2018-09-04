
//
//  TJSignRuleController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/11.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSignRuleController.h"

@interface TJSignRuleController ()
@property (weak, nonatomic) IBOutlet UITextView *tv_content;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@end

@implementation TJSignRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle =UIModalPresentationCustom;
    if ([self.title isEqualToString: @"活动规则"]) {
        self.lab_title.text = @"活动规则";
    }else{
        
    }
}
- (IBAction)closeClick:(UIButton *)sender {
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
