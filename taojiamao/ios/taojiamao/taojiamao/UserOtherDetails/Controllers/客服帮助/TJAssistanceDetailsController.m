//
//  TJAssistanceDetailsController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAssistanceDetailsController.h"
#import "TJAssistanceInfoModel.h"
@interface TJAssistanceDetailsController ()
@property(nonatomic,strong)UILabel *lab_title;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UILabel *lab_content;
@property (nonatomic, strong) TJAssistanceInfoModel *model;
@end

@implementation TJAssistanceDetailsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    [self requestHelpInfo];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助详情";

    self.lab_title  = [[UILabel alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight, S_W-20, 50)];
    self.lab_title.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.lab_title];
    
    self.line = [[UIImageView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight+55, S_W-30, 1)];
    self.line.backgroundColor = KBGRGB;
    [self.view addSubview:self.line];
    
    self.lab_content = [[UILabel alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight+60, S_W-20, S_H-SafeAreaTopHeight-60)];
    self.lab_content.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.lab_content];
   
    self.lab_title.text = self.model.title;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.lab_content.attributedText = attrStr;
}

- (void)requestHelpInfo{
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
        request.url = [NSString stringWithFormat:@"%@/%@",MineAssistanceHelp,self.detailsID];
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
        
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--help==%@",responseObject);
        TJAssistanceInfoModel  *m = [TJAssistanceInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = m;
    } onFailure:^(NSError * _Nullable error) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
