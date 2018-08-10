//
//  TJCourierTakeCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJKdUserOrderList;
@interface TJCourierTakeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_pl;

@property (nonatomic, strong) TJKdUserOrderList *model;
@end
