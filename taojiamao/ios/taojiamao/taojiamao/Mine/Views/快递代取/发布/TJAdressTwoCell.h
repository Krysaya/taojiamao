//
//  TJAdressTwoCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJKdOrderInfoModel;
@class TJKdQuAddressModel;

@interface TJAdressTwoCell : UITableViewCell
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) TJKdOrderInfoModel *model;
@property (nonatomic, strong) TJKdQuAddressModel *m_qu;

@end
