//
//  KConnectWorking.h
//  taojiamao
//
//  Created by yueyu on 2018/9/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlibabaAuthSDK/ALBBSDK.h>

@interface KConnectWorking : NSObject
/* 获取淘宝授权*/
+(void)getTaoBaoAuthor:(UIViewController *)vc successCallback:(loginSuccessCallback) onSuccess  failureCallback:(loginFailureCallback) onFailure;
+ (void)requestShareUrlData:(NSString *)type withIDStr:(NSString *)IDStr withSuccessBlock:(nullable XMSuccessBlock)successBlock;
+ (void)requestNormalDataParam:(NSDictionary *)params withRequestURL:(NSString *)URL withMethodType:(XMHTTPMethodType)type withSuccessBlock:(nullable XMSuccessBlock)successBlock withFailure:(nullable XMFailureBlock)failureBlock;
+ (void)requestNormalDataMD5Param:(NSDictionary *)params withNormlParams:(NSDictionary *)normalPara withRequestURL:(NSString *)URL withMethodType:(XMHTTPMethodType)type withSuccessBlock:(nullable XMSuccessBlock)successBlock withFailure:(nullable XMFailureBlock)failureBlock;
@end
