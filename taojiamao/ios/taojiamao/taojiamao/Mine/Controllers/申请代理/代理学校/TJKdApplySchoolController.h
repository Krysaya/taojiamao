//
//  TJKdApplySchoolController.h
//  taojiamao
//
//  Created by yueyu on 2018/8/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"
@class TJMySchoolListModel;
@protocol KdApplySchoolControllerDelegate <NSObject>
-(void)getApplySchoolInfoValue:(TJMySchoolListModel *)schoolModel;

@end
@interface TJKdApplySchoolController : TJBaseViewController
@property (nonatomic,assign)id<KdApplySchoolControllerDelegate> delegate;

@end
