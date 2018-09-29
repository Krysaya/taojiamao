
//
//  TJHPFindModel.m
//  taojiamao
//
//  Created by yueyu on 2018/9/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHPFindModel.h"
#import "TJHPFindGoodsModel.h"

@implementation TJHPFindModel
+(NSDictionary *)objectClassInArray{
    // 数组内部是字典,要转成模型
    return @{@"good":[TJHPFindGoodsModel class]};
}
@end
