//
//  TJTqgTimesListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/20.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 
 {
 "hour": "08:00",    //时间
 "str": "抢购进行中",    //字符串
 "arg": "2018-07-19 08:00:00"    //请求数据的参数
 },
 
 */
#import <Foundation/Foundation.h>

@interface TJTqgTimesListModel : NSObject

@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *arg;
@end
