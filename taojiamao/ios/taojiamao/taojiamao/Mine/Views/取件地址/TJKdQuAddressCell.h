//
//  TJKdQuAddressCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"

@protocol TJKdQuAddressDelegate<NSObject>
-(void)editClick:(NSIndexPath*)index;

@end
@class TJKdQuAddressModel;
@interface TJKdQuAddressCell : TJBaseTableCell

@property(nonatomic,assign)id<TJKdQuAddressDelegate> deletage;
@property(nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic, strong) TJKdQuAddressModel *model;
@end
