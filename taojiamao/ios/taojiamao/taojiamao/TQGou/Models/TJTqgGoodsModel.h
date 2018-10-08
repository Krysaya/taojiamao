//
//  TJTqgGoodsModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 {
 end_time = 1533891599;
 sold_num = 0;
 num_iid = 571853311054;
 title = 狗牙儿比萨卷25g*20包天津特产;
 pic_url = http://img4.tbcdn.cn/tfscom///gju4.alicdn.com/tps/i4/TB2XpPJI49YBuNjy0FfXXXIsVXa_!!0-juitemmedia.jpg;
 start_time = 1533805200;
 reserve_price = 29.80;
 zk_final_price = 10.8;
 click_url = https://s.click.taobao.com/t?e=m%3D2%26s%3Dri%2FQidDsATwcQipKwQzePOeEDrYVVa64yK8Cckff7TVRAdhuF14FMZnnqlbS8PeHJ1gyddu7kN%2BdTf54knz0IBbESYg6M%2BLP2ee918M6J%2B72iP95%2Fs7k9HEumm%2B6nHzy9cOd%2Bdj18cXvqXn6N0bcoM9Be3DMBDYvfAshQpEVvXaYZWWbmxUUagGFX0kufqm4owsqWDENR5a9Gf2zmUiveQ%3D%3D;
 total_amount = 300;
 }

 */
#import <Foundation/Foundation.h>

@interface TJTqgGoodsModel : NSObject
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic,strong)  NSString *end_time;
@property (nonatomic, strong) NSString *sold_num;//已抢数量
@property (nonatomic, strong) NSString *num_iid;//淘宝商品id
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *reserve_price;//原价
@property (nonatomic, strong) NSString *zk_final_price;//折扣价
@property (nonatomic, strong) NSString *click_url;
@property (nonatomic, strong) NSString *total_amount;//总数量
@property (nonatomic, strong) NSString *rebate;

@end
