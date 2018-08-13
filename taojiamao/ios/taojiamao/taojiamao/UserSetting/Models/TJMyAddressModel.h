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
 "id": 5,
 
 "uid": 1,
 
 "name": "一一",
 
 "sex": 1,
 
 "telephone": "13111221010",
 
 "school_id": 1,
 
 "address": "学府路576号",
 
 "addtime": 1533607032,
 
 "edittime": null,
 
 "is_default": null
    }
 ]
 }
 */
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *telephone;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *sex;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *is_default;
@property (nonatomic, strong) NSString *school_id;

















@end
