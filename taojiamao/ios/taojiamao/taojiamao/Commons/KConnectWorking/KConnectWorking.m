
//
//  KConnectWorking.m
//  taojiamao
//
//  Created by yueyu on 2018/9/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "KConnectWorking.h"
#import <AlibabaAuthSDK/ALBBSDK.h>

@implementation KConnectWorking

+(void)getTaoBaoAuthor:(UIViewController *)vc successCallback:(loginSuccessCallback) onSuccess  failureCallback:(loginFailureCallback) onFailure{
    ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
    [albbSDK setAppkey:@"25038195"];
    [albbSDK setAuthOption:NormalAuth];
    [albbSDK auth:vc successCallback:onSuccess failureCallback:onFailure];
}
+ (void)requestShareUrlData:(NSString *)type withIDStr:(NSString *)IDStr withSuccessBlock:(nullable XMSuccessBlock)successBlock{
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
                                @"id":IDStr,
                                @"type":type,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KShareUrl;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{  @"id":IDStr,
                                 @"type":type,};
    } onSuccess:successBlock onFailure:^(NSError * _Nullable error) {

        
    }];

}

+ (void)requestNormalDataParam:(NSDictionary *)params withRequestURL:(NSString *)URL withMethodType:(XMHTTPMethodType)type withSuccessBlock:(nullable XMSuccessBlock)successBlock withFailure:(nullable XMFailureBlock)failureBlock {
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
    [md addEntriesFromDictionary:params];
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    if ([TJOverallJudge sharedJudge].netStatus==0) {
        [SVProgressHUD showInfoWithStatus:@"没有网络啦~"];
    }else{
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = URL;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = type;
            request.timeoutInterval = 10;
            request.parameters = params;
        } onSuccess:successBlock onFailure:failureBlock];
    }
    

}

+ (void)requestNormalDataMD5Param:(NSDictionary *)params withNormlParams:(NSDictionary *)normalPara withRequestURL:(NSString *)URL withMethodType:(XMHTTPMethodType)type withSuccessBlock:(nullable XMSuccessBlock)successBlock withFailure:(nullable XMFailureBlock)failureBlock{
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
    [md addEntriesFromDictionary:params];
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    if ([TJOverallJudge sharedJudge].netStatus==0) {
        [SVProgressHUD showInfoWithStatus:@"没有网络啦~"];
    }else{
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = URL;
            request.timeoutInterval = 10;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = type;
            request.parameters = normalPara;
        } onSuccess:successBlock onFailure:failureBlock];
    }
   
}

@end
