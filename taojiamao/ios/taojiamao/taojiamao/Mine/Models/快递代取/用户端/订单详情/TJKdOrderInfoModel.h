//
//  TJKdOrderInfoModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/10.
//  Copyright © 2018年 yueyu. All rights reserved.
//

/*
 "data": {
 
 "id": 1,
 
 "status": 6,
 
 "qu_code": "12-1-1036",
 
 "song_start_time": 8,
 
 "song_end_time": null,
 
 "daili_id": 1,
 
 "name": "圆通",
 
 "pic": null,
 
 "danhao": "2222222",
 
 "shou_username": "aaa",
 
 "shou_telephone": "13111221010",
 
 "song_address": "省市详细",
 
 "qu_address": "取省市详细",
 
 "addtime": 1533629305,
 
 "is_ji": 3,
 
 "pay_type": null,
 
 "daili_name": "小小",
 
 "score": 240,
 
 "daili_telephone": "13111221010",
 
 "dan_total": 1,
 
 "card_image": "http://pcmseq67f.bkt.clouddn.com/20180808/b2acbe972b0b838d57ba4ceddbff6897.jpg?imageMogr2/auto-orient/thumbnail/300x300",
 
 "qu_fee": null,
 
 "confirm_code": null
 
 }
 

*/
#import <Foundation/Foundation.h>

@interface TJKdOrderInfoModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *qu_code;//取件码
@property (nonatomic, strong) NSString *song_start_time;
@property (nonatomic, strong) NSString *song_end_time;
@property (nonatomic, strong) NSString *daili_id;//代理id
@property (nonatomic, strong) NSString *name;//快递公司名字
@property (nonatomic, strong) NSString *pic;//快递公司logo
@property (nonatomic, strong) NSString *danhao;//运单号
@property (nonatomic, strong) NSString *shou_username;
@property (nonatomic, strong) NSString *shou_telephone;
@property (nonatomic, strong) NSString *song_address;
@property (nonatomic, strong) NSString *qu_address;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *is_ji;//加急费
@property (nonatomic, strong) NSString *pay_type;//付款方式
@property (nonatomic, strong) NSString *daili_name;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *daili_telephone;//代理人电话
@property (nonatomic, strong) NSString *dan_total;//总单数
@property (nonatomic, strong) NSString *card_image;//学生证照片
@property (nonatomic, strong) NSString *qu_fee;//取件费
@property (nonatomic, strong) NSString *confirm_code;

@end
