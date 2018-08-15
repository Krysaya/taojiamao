//
//  TJKdChooseSchoolController.h
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"
@class TJMySchoolListModel;
@protocol ChooseSchoolControllerDelegate <NSObject>
-(void)getSchoolInfoValue:(TJMySchoolListModel *)schoolModel;

@end
@interface TJKdChooseSchoolController : TJBaseViewController
@property (nonatomic,assign)id<ChooseSchoolControllerDelegate> delegate;
@end
