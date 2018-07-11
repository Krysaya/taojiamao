//
//  TJHomeFootShowCell.h
//  taojiamao
//
//  Created by yueyu on 2018/5/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TJHomeFootShowModel.h"
@class TJHomeFootShowCell;
@protocol TJHomeFootShowCellDeletage<NSObject>

-(void)deletageWithModel:(TJHomeFootShowModel*)model withCell:(TJHomeFootShowCell*)cell;

@end


@interface TJHomeFootShowCell : TJBaseTableCell

@property(nonatomic,strong)TJHomeFootShowModel * model;

@property(nonatomic,assign)BOOL showShare;

@property(nonatomic,assign)id<TJHomeFootShowCellDeletage>deletage;

@property(nonatomic,assign)BOOL isShare;

@end
