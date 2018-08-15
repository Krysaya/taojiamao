//
//  TJKdMyTeamListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 {
 "id": 222,
 "name": "小小",
 "sex": 1,
 "telephone": "13111221010",
 "grade": 3,
 "school_id": "1",
 "card_image": "http://pcmseq67f.bkt.clouddn.com/20180808/1010f0cf874abe82140bd7b1e0cf62ba.jpg?imageMogr2/auto-orient/thumbnail/300x300",
 "invite_code": 1,
 "addtime": 1533699305,
 "score": 0,
 "dan_total": 0,
 "update_time": null,
 "today_dan": null,
 "month_dan": null,
 "today_money": null,
 "month_money": null,
 "level": 0
 },
 */
#import <Foundation/Foundation.h>

@interface TJKdMyTeamListModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *grade;//年级
@property (nonatomic, strong) NSString *school_id;//学校id
@property (nonatomic, strong) NSString *card_image;//学生证照片
@property (nonatomic, strong) NSString *invite_code;//邀请码
@property (nonatomic, strong) NSString *addtime;//申请代理时间
@property (nonatomic, strong) NSString *score;//评分
@property (nonatomic, strong) NSString *dan_total;//总单
@property (nonatomic, strong) NSString *update_time;//
@property (nonatomic, strong) NSString *today_dan;//当天单数
@property (nonatomic, strong) NSString *month_dan;//
@property (nonatomic, strong) NSString *today_money;//
@property (nonatomic, strong) NSString *month_money;//
@property (nonatomic, strong) NSString *level;//


@end
