//
//  TJMyFootPrintCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJGoodsInfoListModel;
@interface TJMyFootPrintCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, strong) TJGoodsInfoListModel *model;
@end
