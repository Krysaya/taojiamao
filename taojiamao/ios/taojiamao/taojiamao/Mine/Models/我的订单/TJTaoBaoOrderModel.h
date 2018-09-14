//
//  TJTaoBaoOrderModel.h
//  taojiamao
//
//  Created by yueyu on 2018/9/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJTaoBaoOrderModel : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *trade_id;
@property (nonatomic, strong) NSString *earning_time;
@property (nonatomic, strong) NSString *item_title;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *item_pic;
@property (nonatomic, strong) NSString *tk_status;

@end
