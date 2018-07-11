//
//  TJAssistanceModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJAssistanceModel : NSObject
/*
 {
 "err_code": 200,
 "err_msg": "ok",
 "data": [
 {
 "id": "1",
 "title": "H币可以兑换现金吗？"
 },
 */
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * title;

@end
