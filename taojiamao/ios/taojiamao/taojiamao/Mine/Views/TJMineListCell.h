//
//  TJMineListCell.h
//  taojiamao
//
//  Created by yueyu on 2018/4/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJMineListCell;
@protocol testTableViewCellDelegate <NSObject>

-(void)uodataTableViewCellHight:(TJMineListCell*)cell andHight:(CGFloat)hight andIndexPath:(NSIndexPath *)indexPath;
@end


@interface TJMineListCell : TJBaseTableCell
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSArray *dataArr;


@end
