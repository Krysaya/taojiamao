//
//  TJMiddleModelsCell.h
//  taojiamao
//
//  Created by yueyu on 2018/5/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//



#import <UIKit/UIKit.h>

@class TJHomeMiddleModels;
@protocol TJMiddleModelsCellDelegate<NSObject>
-(void)middleModelsCollectionCellClick:(TJHomeMiddleModels*)model;
@end


@interface TJMiddleModelsCell : TJBaseTableCell

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,weak)id<TJMiddleModelsCellDelegate>delegate;

@end
