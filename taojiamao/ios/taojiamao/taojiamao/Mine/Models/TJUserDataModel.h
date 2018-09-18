//
//  TJUserDataModel.h
//  taojiamao
//
//  Created by yueyu on 2018/5/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJUserDataModel : NSObject

/*
 {
 regip = 106.114.191.157;
 fans_level = 3;
 addtime = 2018-07-23 12:09:52;
 id = 87ecPhvjEkUpXttPh9shYOwZOu3vFYkYUuJZ9bGK;
 level = 3;
 telephone = 15226570268;
 tb_order_suf = <null>;
 address = <null>;
 tao_nick = 阳光媚倾城;
 nickname = 怕失去就不会忘记;
 points = 70;
 addressid = <null>;
 agent_id = <null>;
 type = 1;
 bind_wx = 0;
 image_wx = <null>;
 partner_id = 1;
 image = http://pcmseq67f.bkt.clouddn.com/20180828/9f8a0d78b9062f7818e3d4b59d2e606c.jpg?imageMogr2/auto-orient/thumbnail/300x300;
 nickname_wx = <null>;
 ali_true_name = 梁纹;
 reg_type = 0;
 sign_notice = 1;
 invite_num = 0;
 ali_account = 15226570268;
 total_points = 17;
 pids = ,1,2,;
 agent_group_id = 6;
 is_ti = 1000;
 balance = 5796;
 bind_tao = 1;
 total_bonus = 300;
 pid = 2;
 tao_image = https://wwc.alicdn.com/avatar/getAvatar.do?userIdS;
 }

 */

@property (nonatomic, strong) NSString *fans_level;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *tb_order_suf;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *tao_nick;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *addressid;
@property (nonatomic, strong) NSString *agent_id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *bind_wx;
@property (nonatomic, strong) NSString *image_wx;
@property (nonatomic, strong) NSString *partner_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *nickname_wx;
@property (nonatomic, strong) NSString *ali_true_name;
@property (nonatomic, strong) NSString *reg_type;
@property (nonatomic, strong) NSString *sign_notice;
@property (nonatomic, strong) NSString *invite_num;
@property (nonatomic, strong) NSString *ali_account;
@property (nonatomic, strong) NSString *total_points;
@property (nonatomic, strong) NSString *pids;
@property (nonatomic, strong) NSString *agent_group_id;
@property (nonatomic, strong) NSString *is_ti;
@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSString *bind_tao;
@property (nonatomic, strong) NSString *total_bonus;
@property (nonatomic, strong) NSString *tao_image;
@property (nonatomic, strong) NSString *pid;
@end
