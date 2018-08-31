//
//  TJHeadLineShareCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ShareDelegate <NSObject>
- (void)shareButtonClick:(UIButton *)button;
@end

@interface TJHeadLineShareCell : TJBaseTableCell
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;
@property (nonatomic,assign)id<ShareDelegate> delegate;
@end
