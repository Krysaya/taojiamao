//
//  TJAssistanceInfoModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJAssistanceInfoModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *keywords;
//@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *content;

@end
