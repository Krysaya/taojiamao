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

+(BOOL)judgeBlankString:(NSString *)aStr;
//-(void)judgeAuthcode;

+(BOOL)judgeMobile:(NSString *)mobile;

+(BOOL)judgeNumInputShouldNumber:(NSString *)str;

//+(BOOL)judgeStringIsNull:(NSArray*)array;

@end
