//
//  KConnectWorking.h
//  taojiamao
//
//  Created by yueyu on 2018/9/4.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KConnectWorking : NSObject
+ (void)requestShareUrlData:(NSString *)typeID withSuccessBlock:(nullable XMSuccessBlock)successBlock;
+ (void)requestNormalDataParam:(NSDictionary *)params withRequestURL:(NSString *)URL withMethodType:(XMHTTPMethodType)type withSuccessBlock:(nullable XMSuccessBlock)successBlock withFailure:(nullable XMFailureBlock)failureBlock;
@end
