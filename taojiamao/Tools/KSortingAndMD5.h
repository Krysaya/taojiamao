//
//  KSortingAndMD5.h
//  TEST
//
//  Created by yueyu on 2018/6/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSortingAndMD5 : NSObject
/*
 获取本地当前时间戳 10位
 */
- (NSString *)timeStr;

/*
 排序所有参数 且MD5加密后返回sign
 */
- (NSString *)sortingAndMD5SignWithParam:(NSMutableDictionary *)param withSecert:(NSString *)secert;
@end
