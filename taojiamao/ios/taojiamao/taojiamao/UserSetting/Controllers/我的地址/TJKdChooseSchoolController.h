//
//  TJKdChooseSchoolController.h
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"

@protocol ChooseSchoolControllerDelegate <NSObject>
-(void)getSchoolInfoValue:(NSString *)schoolID;

@end
@interface TJKdChooseSchoolController : TJBaseViewController
@property (nonatomic,unsafe_unretained)id<ChooseSchoolControllerDelegate> delegate;
@end
