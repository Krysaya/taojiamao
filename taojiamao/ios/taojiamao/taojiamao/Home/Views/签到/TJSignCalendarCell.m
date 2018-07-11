//
//  TJSignCalendarCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/11.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSignCalendarCell.h"

@implementation TJSignCalendarCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        
    }
    return self;
}

- (void)configureAppearance
{
    [super configureAppearance];
    // Override the build-in appearance configuration
    if (self.isPlaceholder) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.eventIndicator.hidden = YES;
    }
}

- (void)setSelectionType:(SelectionType)selectionType
{
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}
@end
