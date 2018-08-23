
//
//  TJGoodCatesMainListModel.m
//  taojiamao
//
//  Created by yueyu on 2018/7/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodCatesMainListModel.h"

@implementation TJGoodCatesMainListModel



- (NSArray *)managedSons
{
    if (nil == _managedSons) {
        if (self._childs.length>0) {
            NSArray * childsArray = [self._childs componentsSeparatedByString:@","];//以“,”切割
            
            NSMutableArray *temp = @[].mutableCopy;
            for (NSString *str in childsArray) {
                TJGoodCatesMainListModel *childsModel = [TJGoodCatesMainListModel mj_objectWithKeyValues:self.son[str]];
                [temp addObject:childsModel];
            }
            _managedSons = temp.copy;

        }
       
        
        
    }
    return _managedSons;
}


@end
