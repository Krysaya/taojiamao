//
//  TJTQGContentController.h
//  taojiamao
//
//  Created by yueyu on 2018/7/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJTqgTimesListModel.h"

@interface TJTQGContentController : UIViewController

@property (nonatomic, strong) NSArray *dataArr;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSString *indexx;

- (void)requestGoodsListWithModel:(TJTqgTimesListModel *)model;

@end
