//
//  TJAdressCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJKdOrderInfoModel;
@class TJMyAddressModel;

@interface TJAdressCell : UITableViewCell
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) TJMyAddressModel *m_fb;
@property (nonatomic, strong) TJKdOrderInfoModel *model;
@end
