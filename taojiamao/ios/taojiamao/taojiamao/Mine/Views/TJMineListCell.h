//
//  TJMineListCell.h
//  taojiamao
//
//  Created by yueyu on 2018/4/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJMineListCell;
@class TJMemberMainModel;
@protocol testTableViewCellDelegate <NSObject>

//-(void)uodataTableViewCellHight:(TJMineListCell*)cell andHight:(CGFloat)hight andIndexPath:(NSIndexPath *)indexPath;
-(void)collectionCell:(TJMineListCell *)cell didSelectItemIndexPath:(NSIndexPath *)indexPath;
@end


@interface TJMineListCell : TJBaseTableCell

@property (nonatomic, weak) id<testTableViewCellDelegate>  mineCellDelegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger  indexSection;
- (void)cellHeaderTitle:(NSString *)title withArr:(TJMemberMainModel *)model;


@end
