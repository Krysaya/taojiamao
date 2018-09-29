
//
//  TJNoticeInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJNoticeInfoController.h"
#import "TJNoticeInfoModel.h"
@interface TJNoticeInfoController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_titel;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;

@property (nonatomic, strong) TJNoticeInfoModel *model;
@end

@implementation TJNoticeInfoController

- (void)viewDidLoad {
    self.title = @"通知详情";
    [super viewDidLoad];[self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
    
    
    [KConnectWorking requestNormalDataParam:nil withRequestURL:[NSString stringWithFormat:@"%@/%@",MessageNotice,self.infoId] withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        DSLog(@"--%@--info",responseObject);
        TJNoticeInfoModel *m = [TJNoticeInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = m;
        self.lab_titel.text = m.message;
        NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:[m.addtime doubleValue]];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *timeS = [formatter stringFromDate:myDate];
        self.lab_time.text = timeS;
        
    } withFailure:^(NSError * _Nullable error) {
        
    }];
   
}

@end
