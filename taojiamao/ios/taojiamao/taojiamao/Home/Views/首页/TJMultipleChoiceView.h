//
//  TJMultipleChoiceView.h
//  taojiamao
//
//  Created by yueyu on 2018/5/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJMultipleChoiceViewDelegate<NSObject>
- (void)buttonSureSelectString:(NSMutableDictionary *)sureDict;
@end


@interface TJMultipleChoiceView : UIView
@property(nonatomic,assign)id<TJMultipleChoiceViewDelegate>deletage;

@end
