//
//  TJKdQuAddressController.h
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"
@class TJKdQuAddressModel;
@protocol QuAddressControllerDelegate <NSObject>
-(void)getQuAddressInfoValue:(TJKdQuAddressModel *)addressModel;

@end
@interface TJKdQuAddressController : TJBaseViewController
@property (nonatomic, strong) NSString *schoolID;
@property (nonatomic,assign)id<QuAddressControllerDelegate> delegate;
@property (nonatomic, strong) NSString *type;

@end
