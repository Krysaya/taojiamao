//
//  TJBannerView.h
//  taojiamao
//
//  Created by yueyu on 2018/4/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJHomeBanner.h"

@interface TJBannerView : UIView

/** 自动滚动间隔时间,默认5s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/**  banner数据 */
@property (strong, nonatomic) NSMutableArray<TJHomeBanner*> *bannerData;

/** 监听点击 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

@end
