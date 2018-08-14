//
//  TJVipFensListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 data": [
 {
 "image": null,
 "nickname": "江小白1111",
 "tao_nick": null,
 "tao_image": null,
 "image_wx": null,
 "nickname_wx": null,
 "id": 2,
 "addtime": 1532059080,
 "invite_num": 0,
 "level": 1,
 "pid": 1,
 "total_bonus": 0
 }
 ]
 */
#import <Foundation/Foundation.h>

@interface TJVipFensListModel : NSObject

@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * tao_nick;
@property (nonatomic, strong) NSString * tao_image;
@property (nonatomic, strong) NSString * image_wx;
@property (nonatomic, strong) NSString * nickname_wx;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * addtime;
@property (nonatomic, strong) NSString * invite_num;
@property (nonatomic, strong) NSString * pid;
@property (nonatomic, strong) NSString * level;
@property (nonatomic, strong) NSString * total_bonus;

@end
