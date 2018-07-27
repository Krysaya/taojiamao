//
//  TJGoodsCollectController.h
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"

@interface TJGoodsCollectController : UIViewController <ZJScrollPageViewChildVcDelegate>

@property (nonatomic, strong) UITableView *goodsTabView;

@property (nonatomic,assign) BOOL  goodsEditStatus;
@property (nonatomic, strong) NSMutableArray *dataArr;


@end
