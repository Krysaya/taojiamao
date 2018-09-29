//
//  TJMiddleModelsCollectionCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMiddleModelsCollectionCell.h"

@interface TJMiddleModelsCollectionCell()
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UILabel * name;
@end

@implementation TJMiddleModelsCollectionCell
/*
 [cell.contentView addSubview:self.icon];
 
 
 UILabel * label = [[UILabel alloc]init];
 label.text = model.name;
 [cell.contentView addSubview:label];
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RandomColor;
        [self.contentView addSubview:self.icon];
        WeakSelf
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.contentView);
            make.top.mas_equalTo(19*H_Scale);
            make.width.height.mas_equalTo(42*W_Scale);
        }];
        [self.contentView addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.icon.mas_bottom).offset(5*H_Scale);
            make.centerX.mas_equalTo(weakSelf.contentView);
        }];
    }
    return self;
}
//-(void)setModels:(TJHomeMiddleModels *)models{
//    _models = models;
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:models.img] placeholderImage:[UIImage imageNamed:@""] options:0];
//    self.name.text = models.name;
//}
- (UIImageView *)icon{
    if (_icon==nil) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
-(UILabel *)name{
    if (_name==nil) {
        _name = [[UILabel alloc]init];
        _name.textColor =[UIColor grayColor];
        _name.font = [UIFont systemFontOfSize:12];
    }
    return _name;
}








@end
