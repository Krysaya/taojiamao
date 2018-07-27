//
//  TJGoodsDetailsElectCell.h
//  taojiamao
//
//  Created by yueyu on 2018/5/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJJHSGoodsListModel;

@interface TJGoodsDetailsElectCell : TJBaseTableCell
@property (nonatomic, strong) TJJHSGoodsListModel *model_detail;

@property(nonatomic,copy)NSString * detailsIntro;

@end
