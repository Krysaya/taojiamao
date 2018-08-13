//
//  TJAreaListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJAreaListModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sort;

@property (nonatomic, strong) NSArray *son;
@end
