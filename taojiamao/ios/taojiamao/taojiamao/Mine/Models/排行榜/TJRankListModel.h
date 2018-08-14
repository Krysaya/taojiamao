//
//  TJRankListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJRankListModel : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *tao_nick;
@property (nonatomic, strong) NSString *tao_image;
@property (nonatomic, strong) NSString *nickname_wx;
@property (nonatomic, strong) NSString *image_wx;
@property (nonatomic, strong) NSString *total_bonus;//累计奖金
@property (nonatomic, strong) NSString *total_points;//累计积分
@property (nonatomic, strong) NSString *invite_num;//粉丝数

@end
