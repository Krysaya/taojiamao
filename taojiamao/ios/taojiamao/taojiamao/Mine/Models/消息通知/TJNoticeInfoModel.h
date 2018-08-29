//
//  TJNoticeInfoModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJNoticeInfoModel : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *isread;

@end
