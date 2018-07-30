//
//  TJDetailListCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"

@class TJAssetsDetailListModel;

@interface TJDetailListCell : TJBaseTableCell

@property (nonatomic, strong) TJAssetsDetailListModel *model;
@end
