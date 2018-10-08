//
//  TJBaseUrebate.h
//  taojiamao
//
//  Created by yueyu on 2018/10/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TJBaseUrebate : NSObject


@property (nonatomic, strong) NSString *rebate_type;
/*1：不开启购物返利(不影响代理提成)
 2：所有会员返利(购买者不算一级)
 3：仅代理自购返利(购买者算一级，仅代理身份购买有返利)*/
@property (nonatomic, strong) NSString *rebate_style;
@property (nonatomic, strong) NSString *show_type;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *rate1;
@property (nonatomic, strong) NSString *rate2;

@end

NS_ASSUME_NONNULL_END
