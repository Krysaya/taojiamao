
//
//  TJHelpDetailController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHelpDetailController.h"
#import "TJAssistanceInfoModel.h"
@interface TJHelpDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;

@end

@implementation TJHelpDetailController

- (void)viewDidLoad {
    [super viewDidLoad];    self.title = @"帮助详情";
 [self requestHelpInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestHelpInfo{

    [KConnectWorking requestNormalDataParam:@{  @"id":self.detailsID,} withRequestURL:[NSString stringWithFormat:@"%@/%@",MineAssistanceHelp,self.detailsID] withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        TJAssistanceInfoModel  *m = [TJAssistanceInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.lab_title.text = m.title;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[m.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.tv_content.attributedText = attrStr;

    } withFailure:^(NSError * _Nullable error) {
         [SVProgressHUD showInfoWithStatus:@"暂无数据"];[self.navigationController popViewControllerAnimated:YES];
    }];
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
