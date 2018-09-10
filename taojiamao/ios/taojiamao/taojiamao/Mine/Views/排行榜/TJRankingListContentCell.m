//
//  TJRankingListContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJRankingListContentCell.h"

#import "TJRankListModel.h"


@interface TJRankingListContentCell()
@property(nonatomic,strong)UILabel * num;
@property(nonatomic,strong)UILabel * zaileiji;


@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)UILabel * name;
@property(nonatomic,strong)UILabel * leiji;
@property(nonatomic,strong)UILabel * jiangli;




@end
@implementation TJRankingListContentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUIsubViews];
    }
    return self;
}

- (void)setUIsubViews{
    self.num = [[UILabel alloc]init];
//    self.num.text = @"1";
    self.num.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.num];
    WeakSelf
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(10);

    }];
    
    self.iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"morentouxiang"]];
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.num.mas_right).offset(18);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    
    self.name = [[UILabel alloc]init];
    self.name.textColor = RGB(51, 51, 51);
    self.name.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22);
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(14);
        
        make.height.mas_equalTo(12);
    }];
    
    self.zaileiji = [[UILabel alloc]init];
    self.zaileiji.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.zaileiji];
    [self.zaileiji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.name.mas_centerY);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(12);

    }];
    
    self.leiji = [[UILabel alloc]init];
    self.leiji.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.leiji];
    [self.leiji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-21);
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(15);
        make.height.mas_equalTo(12);

    }];
    
    self.jiangli = [[UILabel alloc]init];
    self.jiangli.text  = @" ";
    self.jiangli.font = [UIFont systemFontOfSize:14];
    self.jiangli.textColor = RGB(245, 73, 118);
    [self.contentView addSubview:self.jiangli];
    [self.jiangli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-21);
        make.height.mas_equalTo(12);

    }];
}

- (void)setModel:(TJRankListModel *)model{
    _model = model;
    self.name.text = model.nickname;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    self.leiji.text = [NSString stringWithFormat:@"已累计邀请%@人",model.invite_num];
    self.jiangli.text = [NSString stringWithFormat:@"奖励%@",model.total_points];
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
