//
//  TJShareTwoCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"
@class TJGoodsCollectModel;
@interface TJShareTwoCell : TJBaseTableCell
@property (weak, nonatomic) IBOutlet UIButton *btn_qiang;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;
@property (nonatomic, strong) TJGoodsCollectModel *model;
@end
