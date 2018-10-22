
//
//  KSortingAndMD5.m
//  TEST
//
//  Created by yueyu on 2018/6/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "KSortingAndMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KSortingAndMD5



- (NSString *) md5:(NSString *) input {
    
    const char *cStr = [input UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

- (NSString *)timeStr{
//    本地时间戳-13转--10位
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
    //    NSString *timeString = [NSString stringWithFormat:@"%f", a];
        NSString *timeStr = [[NSString stringWithFormat:@"%f", a] substringWithRange:NSMakeRange(0, 10)];
    
    return timeStr;
       
}
- (NSString *)sortingAndMD5SignWithParam:(NSMutableDictionary *)param withSecert:(NSString *)secert{
    
    ////    排序
    //    NSMutableDictionary *param = @{@"page":@"5",
    //                                   @"timestamp": timeStr,
    //                                   @"key": @"test1",
    //                                   }.mutableCopy;
    NSArray *sortedKeys = [[param allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *tempStr = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        id val = param[key];
        if (![key isEqualToString:@"sign"] && [val isKindOfClass:[NSString class]]) {
            [tempStr appendFormat:@"%@=%@&", key, val];
        }
    }
    //    最后拼接secret
    [tempStr appendString:secert];
    
    //-----加密
    NSString *md5String = [self md5:tempStr];
    
   return  [md5String uppercaseString];//大写加密sign
    
}


@end
