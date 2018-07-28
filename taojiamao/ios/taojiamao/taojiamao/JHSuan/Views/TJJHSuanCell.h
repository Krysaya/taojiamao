//
//  TJJHSuanCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJJHSGoodsListModel;

@interface TJJHSuanCell : UICollectionViewCell

@property (nonatomic, strong) TJJHSGoodsListModel *model;
@property (nonatomic, strong) NSString *cell_type;
@end
