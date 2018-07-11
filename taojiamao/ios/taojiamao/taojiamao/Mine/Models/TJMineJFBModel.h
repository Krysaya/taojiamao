//
//  TJMineJFBModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJMineJFBModel : NSObject
/*
 {
 "err_code": 200,
 "err_msg": "ok",
 "data": {
    "money": "940",
    "reward_money": "0",
    "total": 940
    }
 }
 */
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *reward_money;
@property(nonatomic,copy)NSString *total;
@end
