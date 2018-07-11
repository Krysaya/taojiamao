//
//  TJAlertController.h
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureClick)(UIAlertAction * _Nonnull action);
typedef void(^cancelClick)(UIAlertAction * _Nonnull action);

@interface TJAlertController : UIAlertController

+(TJAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message style:(UIAlertControllerStyle)style sureClick:(sureClick)sure cancelClick:(cancelClick)cancel;
@end
