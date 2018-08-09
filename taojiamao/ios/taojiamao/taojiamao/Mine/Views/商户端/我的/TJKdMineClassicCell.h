//
//  TJKdMineClassicCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJKdMineClassicCell;
@protocol SelectCellDelegate <NSObject>
-(void)collectionCell:(TJKdMineClassicCell *)cell didSelectItemIndexPath:(NSIndexPath *)indexPath;
@end

@interface TJKdMineClassicCell : UITableViewCell
@property (nonatomic, weak) id<SelectCellDelegate>  mineCellDelegate;

@end
