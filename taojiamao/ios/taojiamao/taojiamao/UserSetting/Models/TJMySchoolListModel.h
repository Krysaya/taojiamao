//
//  TJMySchoolListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 
 data = (
 {
 status = 1;
 addtime = 1533525431;
 city_id = 3;
 id = 1;
 province_id = 1;
 daili_id = 1;
 city = 石家庄;
 type = 0;
 name = 北京大学;
 province = 河北;
 }

 */

#import <Foundation/Foundation.h>

@interface TJMySchoolListModel : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, strong) NSString *daili_id;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *province;

@end
