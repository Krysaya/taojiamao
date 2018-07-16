//
//  TJContentCollectController.h
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"
@interface TJContentCollectController : UIViewController <ZJScrollPageViewChildVcDelegate>
@property (nonatomic, strong) UITableView *contentTabView;
//编辑选中
@property (nonatomic,assign) BOOL  contentEditStatus;

@end
