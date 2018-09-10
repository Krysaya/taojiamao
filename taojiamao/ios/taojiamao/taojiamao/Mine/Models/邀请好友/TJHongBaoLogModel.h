//
//  TJHongBaoLogModel.h
//  taojiamao
//
//  Created by yueyu on 2018/9/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 "data": [
 
 {
 
 "user_id": 1,
 
 "image": "/static/images/default_head.jpg",
 
 "money": "19",
 
 "status": 1
 
 },
 
 */
#import <Foundation/Foundation.h>

@interface TJHongBaoLogModel : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *status;
@end
