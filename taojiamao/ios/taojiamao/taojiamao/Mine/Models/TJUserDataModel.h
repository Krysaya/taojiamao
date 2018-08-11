//
//  TJUserDataModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJUserDataModel : NSObject

/*
 {
 "err_code": 200,
 "err_msg": "success",
 "data": {
    "id": "17",
    "uc_uid": "0",
    "nickname": null,
    "share_money": "0.00",
    "invite_friend_count": "0",
    "pay_total": "0",
    "name": "普通会员",
    "headimg": "/avatar/default_100.jpg"
 }
 }
 */

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * telephone;
@property(nonatomic,copy)NSString * nickname;
//@property(nonatomic,copy)NSString * share_money;
//@property(nonatomic,copy)NSString * invite_friend_count;
//@property(nonatomic,copy)NSString * pay_total;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * image;
@property (nonatomic, strong) NSString *tao_account;
@property (nonatomic, strong) NSString *ali_account;
@property (nonatomic, strong) NSString *ali_true_name;
@property (nonatomic, strong) NSString *points;

@end
