//
//  TJTQGContentController.h
//  taojiamao
//
//  Created by yueyu on 2018/7/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJTqgTimesListModel.h"

@interface TJTQGContentController : TJBaseViewController

@property (nonatomic, strong) TJTqgTimesListModel *model;
@property (nonatomic, strong) NSString *indexx;

- (void)requestGoodsListWithModel:(TJTqgTimesListModel *)model;

@end
