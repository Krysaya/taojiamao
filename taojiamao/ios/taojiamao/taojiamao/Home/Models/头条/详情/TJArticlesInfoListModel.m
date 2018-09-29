
//
//  TJArticlesInfoListModel.m
//  taojiamao
//
//  Created by yueyu on 2018/8/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJArticlesInfoListModel.h"
#import "TJGoodsCollectModel.h"
@implementation TJArticlesInfoListModel
+(NSDictionary *)objectClassInArray{
    // 数组内部是字典,要转成模型
    return @{@"good":[TJGoodsCollectModel class]};
}
@end
