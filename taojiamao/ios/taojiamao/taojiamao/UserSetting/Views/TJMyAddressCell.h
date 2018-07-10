//
//  TJMyAddressCell.h
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJMyAddressModel.h"

@protocol TJMyAddressDelegate<NSObject>

-(void)deleteClick:(NSIndexPath*)index;
-(void)editClick:(NSIndexPath*)index;

@end

@interface TJMyAddressCell : TJBaseTableCell

@property(nonatomic,strong)TJMyAddressModel * model;
@property(nonatomic,assign)id<TJMyAddressDelegate>deletage;
@property(nonatomic,strong)NSIndexPath * indexPath;

@end
