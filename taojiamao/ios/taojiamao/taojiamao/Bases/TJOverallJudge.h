//
//  TJOverallJudge.h
//  taojiamao
//
//  Created by yueyu on 2018/4/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJOverallJudge : NSObject

+(instancetype)sharedJudge;

+(void)judgeNet;

-(BOOL)judgeFirstOpen;

+(BOOL)judgeLoginStatus;

/*验证字符型非空*/
+(BOOL)judgeBlankString:(NSString *)aStr;
//-(void)judgeAuthcode;

/*验证手机号*/
+(BOOL)judgeMobile:(NSString *)mobile;

/*验证字符串都是数字*/
+(BOOL)judgeNumInputShouldNumber:(NSString *)str;

//+(BOOL)judgeStringIsNull:(NSArray*)array;
/*过滤emoji*/
+(BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)encodeToPercentEscapeString:(NSString *)input;

@end
