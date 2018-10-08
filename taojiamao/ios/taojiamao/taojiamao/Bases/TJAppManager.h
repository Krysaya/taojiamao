//
//  TJAppManager.h
//  taojiamao
//
//  Created by yueyu on 2018/9/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "TJLoginController.h"
//#import "TJMineOrderController.h"
@class TJMineOrderController;
@class TJUserDataModel;
@class TJBaseUrebate;
@interface TJAppManager : NSObject
singleton_interface(TJAppManager);


@property (nonatomic, weak) TJLoginController *loginVC;
@property (nonatomic, weak) TJMineOrderController *myOrderVC;
@property (nonatomic, strong) TJUserDataModel *userData;
@property (nonatomic, strong) TJBaseUrebate *urbate;;//会员配置

@end
