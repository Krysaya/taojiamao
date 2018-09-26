//
//  TJUpgradeAgentModel.h
//  taojiamao
//
//  Created by yueyu on 2018/9/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 {
  "id": 1,
  "title": "测试商品111",
  "image": "http://pcmseq67f.bkt.clouddn.com/20180921/42e122065bde1f4df30fb25e53f64d3b.jpg?imageMogr2/auto-orient/thumbnail/300x300",
  "upgrade_price": 1100,
  "price": 100,
 "buy_reward": "{"upgrade_price_level_1_1":100,"upgrade_price_level_2_1":100,"upgrade_price_level_1_2":1,"upgrade_price_level_2_2":1,"upgrade_price_level_1_3":1,"upgrade_price_level_2_3":1,"price_level_1_1":1,"price_level_2_1":1,"price_level_1_2":1,"price_level_2_2":1,"price_level_1_3":1,"price_level_2_3":1}",
 "sort": 1,
  "status": 1,
  "addtime": 1537519549,
  "level_id": 2
   }
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TJUpgradeAgentModel : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *upgrade_price;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *buy_reward;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *level_id;

@end

NS_ASSUME_NONNULL_END
