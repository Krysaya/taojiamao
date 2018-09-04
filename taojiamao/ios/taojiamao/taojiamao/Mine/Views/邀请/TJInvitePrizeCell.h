//
//  TJInvitePrizeCell.h
//  taojiamao
//
//  Created by yueyu on 2018/9/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJGoodsCollectModel;
@interface TJInvitePrizeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_buy;

@property (nonatomic, strong) TJGoodsCollectModel *model;
@end
