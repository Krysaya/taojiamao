//
//  TJVipFansContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJVipFansContentCell.h"
#import "TJVipFensListModel.h"
@interface TJVipFansContentCell()

@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)TJLabel * name;
@property(nonatomic,strong)TJLabel * fansID;
@property(nonatomic,strong)TJLabel * time;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)TJLabel * fanses;
@property(nonatomic,strong)TJLabel * grade;
@property(nonatomic,strong)TJLabel * recommend;
@property(nonatomic,strong)TJLabel * money;

@end

@implementation TJVipFansContentCell


-(void)setUIsubViews{
    WeakSelf
    self.iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading1"]];
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(12);
        make.width.height.mas_equalTo(70);
    }];
    
    self.name = [TJLabel setLabelWith:@"红旗雷哥" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(16);
        make.top.mas_equalTo(25);
    }];
    
    self.fansID = [TJLabel setLabelWith:@"ID:66666" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.fansID];
    [self.fansID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.name);
        make.top.mas_equalTo(weakSelf.name.mas_bottom).offset(15);
    }];
    
    self.time = [TJLabel setLabelWith:@"2018-05-02 11:20:41" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(55);
        make.right.mas_equalTo(-12);
    }];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = RGB(220, 220,220);
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.iconView.mas_bottom).offset(10);
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(1);
    }];
    
    self.fanses = [TJLabel setLabelWith:@"粉丝数：0" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.fanses];
    [self.fanses mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconView);
        make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(10);
    }];
    
    self.grade = [TJLabel setLabelWith:@"会员等级：普通会员" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.grade];
    [self.grade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconView);
        make.top.mas_equalTo(weakSelf.fanses.mas_bottom).offset(15);
    }];
    
    self.recommend = [TJLabel setLabelWith:@"推荐人ID：546987" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.recommend];
    [self.recommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.fanses);
        make.right.mas_equalTo(weakSelf.time);
    }];
    
    self.money = [TJLabel setLabelWith:@"累计佣金：132.0" font:14 color:RGB(51, 51, 51)];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.grade);
        make.right.mas_equalTo(weakSelf.time);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUIsubViews];
//        self.backgroundColor = RGB(245, 245, 245);
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TJVipFensListModel *)model{
    _model = model;
    self.name.text = model.nickname;
    self.fanses.text = [NSString stringWithFormat:@"粉丝数：%@",model.invite_num];
    self.grade.text = [NSString stringWithFormat:@"会员等级：%@",model.level];
    self.fansID.text = [NSString stringWithFormat:@"ID:%@",model.id];
    self.recommend.text = [NSString stringWithFormat:@"推荐人ID:%@",model.pid];
    self.money.text = [NSString stringWithFormat:@"累计佣金:%@",model.total_bonus];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:[model.addtime doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    self.time.text = currentDateStr;
}
@end
