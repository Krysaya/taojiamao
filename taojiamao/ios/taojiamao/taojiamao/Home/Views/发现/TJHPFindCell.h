//
//  TJHPFindCell.h
//  taojiamao
//
//  Created by yueyu on 2018/9/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImgClickDelegate
- (void)imgClickWithIndex:(UIButton *)sender;


@end
@class TJHPFindModel;
@interface TJHPFindCell : UITableViewCell
@property (nonatomic, strong) TJHPFindModel *model;
@property (weak, nonatomic) IBOutlet UIButton *btn_buy;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;
@property (nonatomic, assign) id<ImgClickDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
