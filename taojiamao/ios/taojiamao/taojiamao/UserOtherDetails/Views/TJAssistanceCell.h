//
//  TJAssistanceCell.h
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJAssistanceModel.h"

@interface TJAssistanceCell : TJBaseTableCell

@property(nonatomic,strong)TJAssistanceModel * model;

@property(nonatomic,copy)NSString * onlyString;

@end
