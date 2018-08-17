//
//  TJKdHomeOrderCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJKdUserOrderList;
@interface TJKdHomeOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_qiang;

@property (nonatomic, strong) TJKdUserOrderList *model;
@end
