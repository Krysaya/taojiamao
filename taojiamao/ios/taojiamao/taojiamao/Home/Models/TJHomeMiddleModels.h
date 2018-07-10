//
//  TJHomeMiddleModels.h
//  taojiamao
//
//  Created by yueyu on 2018/5/2.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJHomeMiddleModels : NSObject

/*
 "id": "4",
 "ui_id": "3",
 "name": "签到红包",
 "img": "http://www.taojiamao.net/data/upload/ui_item_user/1711/08/7fdf68c5550fe.png",
 "img_type": "1",
 "visited_img": "",
 "visited_img_type": "1",
 "url": "http://www.taojiamao.net/data/upload/ui_item_user/",
 "url_type": "2",
 "app_page_id": "9",
 "content": "http://www.taojiamao.net/data/upload/ui_item_user/",
 "ordid": "1",
 "app_page_para": ""
 */
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * ui_id;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * img_type;
@property(nonatomic,copy)NSString * visited_img;
@property(nonatomic,copy)NSString * visited_img_type;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * url_type;
@property(nonatomic,copy)NSString * app_page_id;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * ordid;
@property(nonatomic,copy)NSString * app_page_para;

@end
