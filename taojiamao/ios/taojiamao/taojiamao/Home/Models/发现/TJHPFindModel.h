//
//  TJHPFindModel.h
//  taojiamao
//
//  Created by yueyu on 2018/9/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TJHPFindModel : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *created_time;
@property (nonatomic, strong) NSString *find_type;
@property (nonatomic, strong) NSMutableArray *good;
//@property (nonatomic, strong) NSArray *goodArr;

@end



NS_ASSUME_NONNULL_END
