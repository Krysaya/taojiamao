//
//  TJAssistanceCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAssistanceCell.h"

@interface TJAssistanceCell()
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIImageView * jjImage;
@end

@implementation TJAssistanceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.bounds = [UIScreen mainScreen].bounds;
        WeakSelf
        self.label = [[UILabel alloc]init];
        self.label.textColor = RGB(51, 51, 51);
        self.label.numberOfLines = 0;
        self.label.font = [UIFont systemFontOfSize:14*W_Scale];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16*H_Scale);
            make.right.mas_equalTo(-72*W_Scale);
            make.left.mas_equalTo(30*W_Scale);
            make.bottom.mas_equalTo(-16*H_Scale);
        }];
        
        self.jjImage = [[UIImageView alloc]init];
        self.jjImage.backgroundColor =RandomColor;
        [self.contentView addSubview:self.jjImage];
        [self.jjImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.contentView);
            make.right.mas_equalTo(-30*W_Scale);
            make.width.mas_equalTo(6*W_Scale);
            make.height.mas_equalTo(11*H_Scale);
        }];
    }
    return self;
}
-(void)setModel:(TJAssistanceModel *)model{
    _model = model;
    self.label.text = model.title;
}
-(void)setOnlyString:(NSString *)onlyString{
    _onlyString = onlyString;
    self.label.text = onlyString;
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
