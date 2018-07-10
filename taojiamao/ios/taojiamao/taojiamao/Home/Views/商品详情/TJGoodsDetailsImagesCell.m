//
//  TJGoodsDetailsImagesCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsDetailsImagesCell.h"

@interface TJGoodsDetailsImagesCell()

@property(nonatomic,strong)UIImageView * imageS;

@end

@implementation TJGoodsDetailsImagesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageS = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageS];
        WeakSelf
        [self.imageS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(weakSelf.contentView);
        }];
    }
    return self;
}

-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    [self.imageS sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"morentouxiang"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            /** reload  目前我为刷新 暂无问题*/
//            if(result)  [tableView  xh_reloadDataForURL:imageURL];
        }];
    }];
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
