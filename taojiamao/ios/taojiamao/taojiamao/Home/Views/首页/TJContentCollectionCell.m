//
//  TJContentCollectionCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/21.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentCollectionCell.h"

@interface TJContentCollectionCell()

@property(nonatomic,strong)UIImageView * imageV;
@property(nonatomic,strong)TJLabel * labelV;
@end

@implementation TJContentCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = RandomColor;
        
        WeakSelf
        self.imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
        [self.contentView addSubview:self.imageV];
        
        self.labelV = [TJLabel setLabelWith:@"羽绒服" font:11 color:RGB(51, 51, 51)];
        [self.contentView addSubview:self.labelV];
        
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.contentView);
            make.top.mas_equalTo(9);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.labelV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom).offset(9);
            make.centerX.mas_equalTo(weakSelf.imageV);
        }];
    }
    return self;
}















@end
