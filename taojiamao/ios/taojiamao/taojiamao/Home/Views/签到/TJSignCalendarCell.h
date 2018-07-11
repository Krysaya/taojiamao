//
//  TJSignCalendarCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/11.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "FSCalendarCell.h"

typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone,
    SelectionTypeSingle,
    SelectionTypeLeftBorder,
    SelectionTypeMiddle,
    SelectionTypeRightBorder
};

@interface TJSignCalendarCell : FSCalendarCell


//@property (weak, nonatomic) UIImageView *circleImageView;
@property (assign, nonatomic) SelectionType selectionType;

@end
