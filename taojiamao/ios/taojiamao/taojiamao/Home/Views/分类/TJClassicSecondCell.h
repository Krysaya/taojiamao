//
//  TJClassicSecondCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"
@class TJGoodCatesMainListModel;
@interface TJClassicSecondCell : TJBaseTableCell

- (void)cellHeaderTitle:(NSString *)title withImageArr:(NSArray *)imgArr withtitleArr:(NSArray *)titleArr;
- (void)cellArr:(NSMutableArray *)dataArr;

@property (nonatomic, strong) TJGoodCatesMainListModel *model;
@end
