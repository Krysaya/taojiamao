//
//  TJKdQuAddressModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 "data": [
 
 {
 
 "id": 1,
 "school_id": 1,
 "address": "取件地址学校1 "
 
 },
 */

#import <Foundation/Foundation.h>

@interface TJKdQuAddressModel : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *school_id;
@property (nonatomic, strong) NSString *address;
@end
