//
//  TJTQGCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJTqgGoodsModel;
@interface TJTQGCell : TJBaseTableCell
@property (nonatomic, strong) TJTqgGoodsModel *model;
@property (nonatomic, strong) NSString *type;
@property (weak, nonatomic) IBOutlet UIButton *btn_qiang;
@property (weak, nonatomic) IBOutlet UIButton *btn_fen;


@end
