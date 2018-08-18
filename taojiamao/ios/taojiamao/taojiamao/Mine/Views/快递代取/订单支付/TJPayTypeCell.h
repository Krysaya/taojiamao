//
//  TJPayTypeCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJPayTypeCellDelegate<NSObject>

-(void)selectClickWithBtnStatus:(NSString *)status;

@end

@interface TJPayTypeCell : UITableViewCell

@property(nonatomic,assign)id<TJPayTypeCellDelegate> deletage;

@end
