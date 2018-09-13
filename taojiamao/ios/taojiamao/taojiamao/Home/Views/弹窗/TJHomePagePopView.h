//
//  TJHomePagePopView.h
//  taojiamao
//
//  Created by yueyu on 2018/9/10.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopViewClickDelgate
- (void)tapClick;

@end


@class TJHomePageModel;
@interface TJHomePagePopView : UIView

+(instancetype)invitationView;
@property (nonatomic, strong) TJHomePageModel *model;
@property (nonatomic, assign) id<PopViewClickDelgate> delegate;
@end
