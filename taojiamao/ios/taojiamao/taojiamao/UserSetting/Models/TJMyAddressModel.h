//
//  TJMyAddressModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJMyAddressModel : NSObject
/*
 {
 "err_code": 200,
 "err_msg": "ok",
 "data": [
    {
    "id": "4",
    "name": "小鱼儿",
    "tel": "18231192500",
    "address": "沙河北大桥",
    "full_address": "北京市 北京市 东城区 沙河北大桥"
    }
 ]
 }
 */
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *full_address;


















@end
