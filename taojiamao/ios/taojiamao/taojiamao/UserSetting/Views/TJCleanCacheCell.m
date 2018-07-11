//
//  TJCleanCacheCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCleanCacheCell.h"
@interface TJCleanCacheCell()
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UILabel * cache;

@end

@implementation TJCleanCacheCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.bounds = [UIScreen mainScreen].bounds;
        WeakSelf
        self.label = [[UILabel alloc]init];
        self.label.textColor = RGB(51, 51, 51);
        self.label.font = [UIFont systemFontOfSize:14*W_Scale];
        self.label.text = @"清除缓存";
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16*H_Scale);
            make.right.mas_equalTo(-72*W_Scale);
            make.left.mas_equalTo(30*W_Scale);
            make.bottom.mas_equalTo(-16*H_Scale);
        }];
        
        self.cache = [[UILabel alloc]init];
        self.cache.textColor = RGB(51, 51, 51);
        self.cache.font = [UIFont systemFontOfSize:14*W_Scale];
        [self.contentView addSubview:self.cache];
        [self.cache mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.contentView);
            make.right.mas_equalTo(-30*W_Scale);
        }];
    }
    return self;
}
- (NSString *)fileSizeWithInterge:(NSUInteger)size{
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}
-(void)setSize:(NSUInteger)size{
    _size = size;
    NSString * sizeStr = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:size]];
    self.cache.text = sizeStr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
