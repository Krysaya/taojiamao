//
//  TJPopularizeCollectCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/22.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPopularizeCollectCell.h"

@interface TJPopularizeCollectCell()

@property(nonatomic,strong)UIImageView * iv;

@end

@implementation TJPopularizeCollectCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        WeakSelf
        self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
        [self.contentView addSubview:self.iv];
        
        self.xz = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
        [self.contentView addSubview:self.xz];
        [self.xz mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weakSelf.iv);
            make.width.height.mas_equalTo(27);
        }];
        self.xz.hidden = YES;
    }
    return self;
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.iv sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
}












@end
