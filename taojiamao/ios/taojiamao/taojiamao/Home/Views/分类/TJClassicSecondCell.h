//
//  TJClassicSecondCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"
@class TJGoodCatesMainListModel;
@class TJClassicSecondCell;
@protocol TabCollectCellDelegate <NSObject>
-(void)collectionCell:(TJClassicSecondCell *)cell didSelectItemIndexPath:(NSIndexPath *)indexPath;
@end
@interface TJClassicSecondCell : TJBaseTableCell


@property (nonatomic, weak) id<TabCollectCellDelegate>  mineCellDelegate;
@property (nonatomic, assign) NSInteger  indexSection;

@property (nonatomic, strong) TJGoodCatesMainListModel *model;
@end
