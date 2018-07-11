//
//  TJLaunchModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJLaunchModel : NSObject
/*
 {
 "err_code": 200,
 "err_msg": "ok",
 "data": {
    "id": "19",
    "url": "",
    "url_type": "0",
    "content": "http://www.taojiamao.net/data/upload/banner/1805/07/5aeff2bc9c11d.png",
    "app_page_id": "0"
    }
 }
 */
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * url_type;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * app_page_id;

@end
