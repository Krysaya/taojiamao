
//
//  KConnectWorking.m
//  taojiamao
//
//  Created by yueyu on 2018/9/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "KConnectWorking.h"

@implementation KConnectWorking

+ (void)requestShareUrlData:(NSString *)typeID withSuccessBlock:(nullable XMSuccessBlock)successBlock{
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
                                @"id":typeID,
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
        request.parameters = @{@"id":typeID};
    } onSuccess:successBlock onFailure:^(NSError * _Nullable error) {
    }];

}

+ (void)requestNormalDataParam:(NSDictionary *)params withRequestURL:(NSString *)URL withMethodType:(XMHTTPMethodType)type withSuccessBlock:(nullable XMSuccessBlock)successBlock withFailure:(nullable XMFailureBlock)failureBlock{
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
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = URL;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = type;
        request.parameters = params;
    } onSuccess:successBlock onFailure:failureBlock];

}
@end
