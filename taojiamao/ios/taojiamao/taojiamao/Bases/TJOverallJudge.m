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
+(void)judgeNet{
    //网络检查
    [XDNetworking checkNetworkStatus];
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
//+(BOOL)judgeStringIsNull:(NSArray*)array{
//    for (NSString*str in array) {
//        if (str.length==0 ||str==nil) {
//            return YES;
//        }
//    }
//    return NO;
//}







@end
