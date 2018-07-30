//
//  TJClassicFirstCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"
@class TJGoodCatesMainListModel;

@interface TJClassicFirstCell : TJBaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *lab_select;

@property (nonatomic, strong) NSString *selectType;
@property (nonatomic, strong) TJGoodCatesMainListModel *model;
@end
