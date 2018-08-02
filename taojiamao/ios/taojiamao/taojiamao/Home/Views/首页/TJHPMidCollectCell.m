//
//  TJHPMidCollectCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHPMidCollectCell.h"
#import "TJMembersModel.h"
@interface TJHPMidCollectCell ()


@end

@implementation TJHPMidCollectCell

- (UIImageView *)imgView{
    if (nil==_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = RandomColor;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(35);
          
            make.top.mas_equalTo(self.contentView.mas_top);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)titleLab{
    if (nil==_titleLab) {
        _titleLab = [[UILabel alloc]init];
        
        _titleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(12);
            make.centerX.mas_equalTo(self.imgView.mas_centerX);
        }];
        
    }
    
    return _titleLab;
}

- (void)setModel:(TJMembersModel *)model{
    _model = model;
    self.titleLab.text = model.text;
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:model.icon]];
    
}
@end
