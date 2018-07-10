//
//  TJGoodsDetailsCompanyCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsDetailsCompanyCell.h"

@interface TJGoodsDetailsCompanyCell()

@property(nonatomic,strong)UIImageView * iconV;
@property(nonatomic,strong)UIImageView * type;
@property(nonatomic,strong)TJLabel * company;
@property(nonatomic,strong)TJLabel * describe;
@property(nonatomic,strong)TJLabel * desScore;
@property(nonatomic,strong)TJLabel * serve;
@property(nonatomic,strong)TJLabel * serScore;
@property(nonatomic,strong)TJLabel * logistics;
@property(nonatomic,strong)TJLabel * logScore;
@end

@implementation TJGoodsDetailsCompanyCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    WeakSelf
    self.iconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.contentView addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*W_Scale);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.width.height.mas_equalTo(42*W_Scale);
    }];
    
    self.type = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    [self.contentView addSubview:self.type];
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21*H_Scale);
        make.left.mas_equalTo(weakSelf.iconV.mas_right).offset(10*W_Scale);
        make.width.mas_equalTo(27*W_Scale);
        make.height.mas_equalTo(13*H_Scale);
    }];
    
    self.company = [TJLabel setLabelWith:@"fasonice裴娜思旗舰店" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.company];
    [self.company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.type.mas_right).offset(8*W_Scale);
        make.centerY.mas_equalTo(weakSelf.type);
    }];
    
    self.describe = [TJLabel setLabelWith:@"描述:" font:14 color:RGB(128, 128, 128)];
    [self.contentView addSubview:self.describe];
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.type);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-15*H_Scale);
    }];
    
    self.desScore = [TJLabel setLabelWith:@"4.7" font:14 color:RGB(254, 71, 119)];
    [self.contentView addSubview:self.desScore];
    [self.desScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.describe.mas_right);
        make.centerY.mas_equalTo(weakSelf.describe);
    }];
    
    self.serve = [TJLabel setLabelWith:@"服务:" font:14 color:RGB(128, 128, 128)];
    [self.contentView addSubview:self.serve];
    [self.serve mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.desScore.mas_right).offset(12*W_Scale);
        make.centerY.mas_equalTo(weakSelf.describe);
    }];
    
    self.serScore = [TJLabel setLabelWith:@"4.7" font:14 color:RGB(254, 71, 119)];
    [self.contentView addSubview:self.serScore];
    [self.serScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.serve.mas_right);
        make.centerY.mas_equalTo(weakSelf.describe);
    }];
    
    self.logistics =[TJLabel setLabelWith:@"物流:" font:14 color:RGB(128, 128, 128)];
    [self.contentView addSubview:self.logistics];
    [self.logistics mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.serScore.mas_right).offset(12*W_Scale);
        make.centerY.mas_equalTo(weakSelf.describe);
    }];
    
    self.logScore =[TJLabel setLabelWith:@"4.7" font:14 color:RGB(254, 71, 119)];
    [self.contentView addSubview:self.logScore];
    [self.logScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.logistics.mas_right);
        make.centerY.mas_equalTo(weakSelf.describe);
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
