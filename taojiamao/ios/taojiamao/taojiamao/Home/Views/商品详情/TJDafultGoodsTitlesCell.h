//
//  TJDafultGoodsTitlesCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"
@class TJJHSGoodsListModel;

@interface TJDafultGoodsTitlesCell : TJBaseTableCell
@property (nonatomic, strong) TJJHSGoodsListModel *model_detail;
@property (weak, nonatomic) IBOutlet UIButton *btn_coupon;

@end
