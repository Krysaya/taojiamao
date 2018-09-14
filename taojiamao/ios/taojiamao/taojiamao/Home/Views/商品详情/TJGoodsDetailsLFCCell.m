//
//  TJGoodsDetailsLFCCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsDetailsLFCCell.h"

@interface TJGoodsDetailsLFCCell()

@property(nonatomic,strong)TJLabel * TKLLabel;

@property(nonatomic,strong)TJLabel * leftLabel;
@property(nonatomic,strong)TJLabel * middleLabel;
@property(nonatomic,strong)UIImageView * jj;

@end

@implementation TJGoodsDetailsLFCCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    WeakSelf
    
    self.TKLLabel = [TJLabel setLabelWith:@"淘口令" font:11 color:[UIColor redColor]];
    self.TKLLabel.textAlignment = NSTextAlignmentCenter;
    self.TKLLabel.layer.borderWidth =1.0;
    self.TKLLabel.layer.cornerRadius = 5.0;
    self.TKLLabel.layer.masksToBounds = YES;
    self.TKLLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.TKLLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.TKLLabel];
    [self.TKLLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(45);
    }];
    self.TKLLabel.hidden = YES;
    
    self.leftLabel = [TJLabel setLabelWith:@"" font:14 color:RGB(128, 128, 128)];
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(30);
    }];
   
    self.middleLabel = [TJLabel setLabelWith:@"" font:14 color:RGB(51, 51, 51)];
    self.middleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.middleLabel];
    [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftLabel.mas_right).offset(18);
        make.width.mas_equalTo(S_W-95);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];

    self.jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    [self.contentView addSubview:self.jj];
    [self.jj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(11);
    }];
}
-(void)setLFC:(NSString *)LFC{
    _LFC = LFC;
    self.leftLabel.text = LFC;
}
-(void)setContent:(NSString *)content{
    _content = content;
    self.middleLabel.text = content;
}

-(void)setIsTKL:(BOOL)isTKL{
    _isTKL = isTKL;
    self.TKLLabel.hidden = !isTKL;
    self.leftLabel.hidden = isTKL;
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
