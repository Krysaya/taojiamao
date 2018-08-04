//
//  TJMoreCommentsCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseTableCell.h"
@class TJCommentsListModel;
@interface TJMoreCommentsCell : TJBaseTableCell
@property (weak, nonatomic) IBOutlet UIButton *btn_more;

@property (nonatomic, strong) TJCommentsListModel *model;


@end
