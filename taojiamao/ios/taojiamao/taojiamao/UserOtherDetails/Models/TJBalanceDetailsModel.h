//
//  TJBalanceDetailsModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJBalanceDetailsModel : NSObject
/*
 "err_code": 200,
 "err_msg": "success",
 "data": [
 {
 "money": "+2.00",
 "action": "兑换",
 "create_time": "2018-04-26 10:42:30"余额时间||"add_time" = "2018-05-05 13:30:01"集分时间
 },
 */
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * action;
@property(nonatomic,copy)NSString * create_time;
@property(nonatomic,copy)NSString * add_time;

@end
