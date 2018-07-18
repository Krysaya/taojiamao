//
//  TJSignCalendarCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/11.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSignCalendarCell.h"
#import "FSCalendarAppearance.h"

@implementation TJSignCalendarCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_bg"]];
        [self.contentView insertSubview:circleImageView atIndex:0];
        self.circleImageView = circleImageView;
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        
        self.appearance.selectionColor = [UIColor clearColor];
        self.appearance.todayColor = [UIColor clearColor];
        
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundView.frame = CGRectInset(self.bounds, 1, 1);
    self.circleImageView.frame = CGRectMake(0, 0, 25, 25);
    self.circleImageView.center = CGPointMake(self.backgroundView.center.x, self.backgroundView.center.y-3);
//    self.selectionLayer.frame = self.bounds;
    
//    if (self.selectionType == SelectionTypeMiddle) {
//
//        self.selectionLayer.path = [UIBezierPath bezierPathWithRect:self.selectionLayer.bounds].CGPath;
//
//    } else if (self.selectionType == SelectionTypeLeftBorder) {
//
//        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.selectionLayer.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.selectionLayer.fs_width/2, self.selectionLayer.fs_width/2)].CGPath;
//
//    } else if (self.selectionType == SelectionTypeRightBorder) {
//
//        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.selectionLayer.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(self.selectionLayer.fs_width/2, self.selectionLayer.fs_width/2)].CGPath;
//
//    } else if (self.selectionType == SelectionTypeSingle) {
//
//        CGFloat diameter = MIN(self.selectionLayer.fs_height, self.selectionLayer.fs_width);
//        self.selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter/2, self.contentView.fs_height/2-diameter/2, diameter, diameter)].CGPath;
//
//    }
}

@end
