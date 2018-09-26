//
//  TJUpgradeAgentCell.h
//  taojiamao
//
//  Created by yueyu on 2018/9/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TJUpgradeAgentModel;
@interface TJUpgradeAgentCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) TJUpgradeAgentModel *model;
@end

NS_ASSUME_NONNULL_END
