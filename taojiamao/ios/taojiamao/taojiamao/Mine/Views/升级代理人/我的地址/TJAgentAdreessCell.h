//
//  TJAgentAdreessCell.h
//  taojiamao
//
//  Created by yueyu on 2018/9/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TJMyAddressModel;
@interface TJAgentAdreessCell : UITableViewCell
@property (nonatomic, strong) TJMyAddressModel *model;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

NS_ASSUME_NONNULL_END
