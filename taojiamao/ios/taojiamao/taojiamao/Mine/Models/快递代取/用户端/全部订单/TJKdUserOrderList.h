//
//  TJKdUserOrderList.h
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 "data": [
 
 {
 
 "id": 3,
 
 "shou_username": "张",
 
 "shou_telephone": "13111221010",
 
 "song_address": "平安大街1号",
 
 "qu_address": "建华大街1号",
 
 "song_start_time": 111111,
 
 "song_end_time": 222222222,
 
 "status": 1,
 
 "is_ji": 2
 
 },
 

 */

#import <Foundation/Foundation.h>

@interface TJKdUserOrderList : NSObject

@property (nonatomic, strong) NSString *id;//快递订单id
@property (nonatomic, strong) NSString *shou_username;
@property (nonatomic, strong) NSString *shou_telephone;
@property (nonatomic, strong) NSString *song_address;
@property (nonatomic, strong) NSString *qu_address;
@property (nonatomic, strong) NSString *song_start_time;
@property (nonatomic, strong) NSString *song_end_time;
@property (nonatomic, strong) NSString *status;//订单状态 0：待接单；1：已接单；2：待完成；3待评价；4：已完成；5：已失效；6：已取消
@property (nonatomic, strong) NSString *is_ji; //是否加急   0：不加急；1：1元加急；2：2元加急；3：3元加急；4：4元加急；5：5元加急；6：10元加急
@end
