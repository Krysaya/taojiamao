//
//  TJMyAddressController.h
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"

@class TJMyAddressModel;
@protocol AddressControllerDelegate <NSObject>
-(void)getSongAddressInfoValue:(TJMyAddressModel *)addressModel;

@end
@interface TJMyAddressController : TJBaseViewController

@property (nonatomic,assign)id<AddressControllerDelegate> delegate;

@property (nonatomic, strong) NSString *type;
@end
