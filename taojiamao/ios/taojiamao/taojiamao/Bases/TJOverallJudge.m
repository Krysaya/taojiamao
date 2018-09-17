//
//  TJOverallJudge.m
//  taojiamao
//
//  Created by yueyu on 2018/4/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOverallJudge.h"
@interface TJOverallJudge()


@end

@implementation TJOverallJudge

+(instancetype)sharedJudge{
    
    static TJOverallJudge * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TJOverallJudge alloc]init];
    });
    return instance;
    
}
+(NSInteger)judgeNet{
    //网络检查
    
    NSInteger status = [[XMEngine sharedEngine] reachabilityStatus];
//    [[XMEngine sharedEngine] networkReachability];
    return status;
}

//检查字符非空 nil null @“” <null>
+(BOOL)judgeBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

-(BOOL)judgeFirstOpen{

    NSString * isFirst = GetUserDefaults(ISFIRST);
    if (isFirst==nil || isFirst.length==0) {
        SetUserDefaults(@"isFirst", ISFIRST)
        return YES;
    }else{
        return NO;
    }

}

//http传输过程的数据转换
+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

//-(void)judgeAuthcode{
//    
//    NSString * authcode = GetUserDefaults(Auth_code);
//    DSLog(@"%@",authcode);
//    if (authcode==nil || authcode.length==0) {
//        [self setUserDefaultss];
//    }else{
//        NSString * year = GetUserDefaults(@"year");
//        if(![year isEqualToString:@"2018"]){
//            [self setUserDefaultss];
//        }else{
//            DSLog(@"年份一致");
//        }
//    }
//}
//-(void)setUserDefaultss{
//    NSDate * date = [NSDate date];
//    NSDateFormatter * forMatter = [[NSDateFormatter alloc]init];
//    [forMatter setDateFormat:@"yyyy"];
//    NSString * dateStr = [forMatter stringFromDate:date];
//    SetUserDefaults(dateStr, @"year");
//    SetUserDefaults(dateStr, @"year");
//    NSString * str = [NSString stringWithFormat:@"ios_%@_ios_",dateStr];
//    str = [str md5String];
//    NSString * result = [str stringByAppendingString:CompanyID];
//    result = [result md5String];
//    SetUserDefaults(result, Auth_code)
////    NSString * authcode = GetUserDefaults(Auth_code);
////    DSLog(@"%@",authcode);
//}
+(BOOL)judgeLoginStatus{
    NSString * uidStr = GetUserDefaults(UID);
    NSString * token = GetUserDefaults(TOKEN);
    if (uidStr.length==0 || uidStr==nil ||token.length==0 ||token ==nil) {
        return NO;
    }else{
        return YES;
    }
}
//判断手机号码格式是否正确
+ (BOOL)judgeMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
//正则判断全是数字
+(BOOL)judgeNumInputShouldNumber:(NSString *)str{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
/*过滤所有空格*/
+ (NSString *)stringContainCharactersInSet:(NSString *)str{
    NSString *topstr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *endStr = [topstr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return endStr;
}
/*过滤emoji*/
+(BOOL)stringContainsEmoji:(NSString *)string
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}





@end
