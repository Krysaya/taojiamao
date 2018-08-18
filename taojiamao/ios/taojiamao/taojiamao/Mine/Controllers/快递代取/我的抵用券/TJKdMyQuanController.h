//
//  TJKdMyQuanController.h
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"
@class TJKdMyQuanModel;
@protocol MyQuanControllerDelegate <NSObject>
-(void)getQuanInfoValue:(TJKdMyQuanModel *)quanModel;

@end@interface TJKdMyQuanController : TJBaseViewController
@property (nonatomic,assign)id<MyQuanControllerDelegate> delegate;

@end
