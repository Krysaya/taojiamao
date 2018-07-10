//
//  TJHomeFootShowModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJHomeFootShowModel : NSObject

/*
 "id": "7209",
 "num_iid": "559622264020",
 "cate_id": "8",
 "coupon_price": "13.80",
 "shop_type": "C",
 "title": "巴百生丁香花茶正品养野生胃茶长白山丁子香红茶特级丁香红叶茶",
 "volume": "292",
 "price": "48.80",
 "pic_url": "http://img.alicdn.com/imgextra/i2/678275524/TB2wEt8g5CYBuNkHFCcXXcHtVXa_!!678275524.png",
 "quan_url": "http://uland.taobao.com/coupon/edetail?activityId=3bfaed4e71d6417cb9718a57c8f6963a&pid=mm_51786779_16868079_97974683&itemId=559622264020&src=fhkj_fhtkzs",
 "quan_surplus": "30000",
 "quan_receive": "0",
 "sellerId": "2677303431"
 */
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * num_iid;
@property(nonatomic,copy)NSString * cate_id;
@property(nonatomic,copy)NSString * coupon_price;
@property(nonatomic,copy)NSString * shop_type;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * volume;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * pic_url;
@property(nonatomic,copy)NSString * quan_url;
@property(nonatomic,copy)NSString * quan_surplus;
@property(nonatomic,copy)NSString * quan_receive;
@property(nonatomic,copy)NSString * sellerId;
@property(nonatomic,copy)NSString * y_quan;

@property(nonatomic,copy)NSString * url;





@end
