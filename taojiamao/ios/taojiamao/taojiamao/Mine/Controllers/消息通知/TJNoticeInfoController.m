
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
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = [NSString stringWithFormat:@"%@/%@",MessageNotice,self.infoId];
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        TJNoticeInfoModel *m = [TJNoticeInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = m;

    } onFailure:^(NSError * _Nullable error) {
        
    }];
}

@end
