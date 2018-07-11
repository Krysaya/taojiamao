//
//  TJHomeBanner.h
//  taojiamao
//
//  Created by yueyu on 2018/4/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJHomeBanner : NSObject

/*
 "id": "20",
 "url": "",
 "url_type": "0",
 "content": "http://www.taojiamao.net/data/upload/banner/1804/26/5ae1ab611ec98.PNG",
 "app_page_id": "0",
 "app_page_para": ""
 */

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * url_type;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * app_page_id;
@property(nonatomic,copy)NSString * app_page_para;


@end
