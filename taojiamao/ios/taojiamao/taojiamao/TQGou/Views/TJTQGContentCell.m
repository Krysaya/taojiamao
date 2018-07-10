//
//  TJTQGContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTQGContentCell.h"
@interface TJTQGContentCell()

@property(nonatomic,strong)UIView *bgview;

@property(nonatomic,strong)UIImageView *img;
@property (nonatomic, strong)UIImageView *tb_img;
@property (nonatomic, strong) UILabel *title_lab;
@property (nonatomic, strong) UIButton *btn_quan;//领券减
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UILabel *lab_yuanjia;
@property (nonatomic, strong) UIButton *btn_share;
@property (nonatomic, strong) UIButton *btn_qiang;

@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *lab_yiqiang;//已抢
@property (nonatomic, strong) UIImageView *line;
@end

@implementation TJTQGContentCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutSubviews];
    }
    return self;
}
- (void)layoutSubviews{
    self.bgview = [[UIView alloc]init];
    [self.contentView addSubview:self.bgview];
    WeakSelf
    
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(weakSelf.contentView);
    }];
    
    self.img = [[UIImageView alloc]init];
    self.img.backgroundColor = RandomColor;
    [self.bgview addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bgview.mas_top).offset(15*H_Scale);
        make.width.height.mas_equalTo(120);
        make.left.mas_equalTo(weakSelf.bgview.mas_left);
//        make.bottom.mas_equalTo(weakSelf.bgview.mas_bottom).offset(-12*H_Scale);
    }];
    
    self.tb_img = [[UIImageView alloc]init];
    self.tb_img.backgroundColor = RandomColor;
    [self.bgview addSubview:self.tb_img];
    [self.tb_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bgview.mas_top).offset(25*H_Scale);
        make.left.mas_equalTo(weakSelf.img.mas_right).offset(15*W_Scale);
        make.width.mas_equalTo(27*W_Scale);
        make.height.mas_equalTo(13*H_Scale);
    }];
    
    self.title_lab = [[UILabel alloc]init];
    self.title_lab.text = @"唐米瑞春秋装新款套头圆领";
//    self.title_lab.backgroundColor = RandomColor;
    self.title_lab.textColor =RGB(51, 51, 51);
    self.title_lab.font = [UIFont systemFontOfSize:14];
    [self.bgview addSubview:self.title_lab];
    [self.title_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bgview.mas_top).offset(25*H_Scale);
        make.left.mas_equalTo(weakSelf.tb_img.mas_right).offset(5*W_Scale);
        make.right.mas_equalTo(weakSelf.bgview.mas_right).offset(-12*W_Scale);
    }];
    
    self.lab_yiqiang = [[UILabel alloc]init];
    [self.bgview addSubview:self.lab_yiqiang];

    //    self.lab_yiqiang.
    NSString *str = @"已抢201件";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:nil];
    NSArray *numArr = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str  attributes:@{NSForegroundColorAttributeName:KALLRGB}];
    for (NSTextCheckingResult *attirbute in numArr) {

        [attributedString setAttributes:@{NSForegroundColorAttributeName:RGB(51, 51, 51)} range:attirbute.range];

    }
    self.lab_yiqiang.font = [UIFont systemFontOfSize:10];
    self.lab_yiqiang.attributedText = attributedString;
    [self.lab_yiqiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.title_lab.mas_bottom).offset(11*H_Scale);
        make.left.mas_equalTo(weakSelf.img.mas_right).offset(50*W_Scale);
//        make.centerX.mas_equalTo(weakSelf.progress.mas_centerX);
    }];

    self.progress = [[UIProgressView alloc]init];
    self.progress.progressTintColor = KALLRGB;//254 218 228
    self.progress.trackTintColor = RGB(254, 228, 218);
    [self.bgview addSubview:self.progress];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.img.mas_right).offset(15*W_Scale);
        make.top.mas_equalTo(weakSelf.lab_yiqiang.mas_bottom).offset(4*H_Scale);
        make.width.mas_equalTo(130*W_Scale);
        make.height.mas_equalTo(8*H_Scale);
    }];
    
    
    
    self.btn_quan = [[UIButton alloc]init];
    self.btn_quan.backgroundColor = RandomColor;
    [self.btn_quan setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.bgview addSubview:self.btn_quan];
    [self.btn_quan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.title_lab.mas_bottom).offset(15*H_Scale);
        make.width.mas_equalTo(62*W_Scale);
        make.height.mas_equalTo(18*H_Scale);
        make.right.mas_equalTo(weakSelf.bgview.mas_right).offset(-12*W_Scale);
    }];
    
    self.lab_price = [[UILabel alloc]init];
    self.lab_price.text = @"¥270.0";
    self.lab_price.textColor = KALLRGB;
    self.lab_price.font = [UIFont systemFontOfSize:19];
    [self.bgview addSubview:self.lab_price];
    [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.progress.mas_bottom).offset(25*H_Scale);
        make.left.mas_equalTo(weakSelf.img.mas_right).offset(15*W_Scale);
    
    }];
    
    self.lab_yuanjia = [[UILabel alloc]init];
    self.lab_yuanjia.textColor = RGB(110, 110, 110);
    [self.bgview addSubview:self.lab_yuanjia];
    [self.lab_yuanjia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.lab_price).offset(7*H_Scale);
        make.left.mas_equalTo(weakSelf.img.mas_right).offset(15*W_Scale);
    }];
    
    self.btn_share = [[UIButton alloc]init];
    self.btn_share.layer.cornerRadius = 3;
    self.btn_share.layer.masksToBounds = YES;
    self.btn_share.layer.borderWidth = 1;
    self.btn_share.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){ 255/255.0, 71/255.0, 119/255.0, 1 });
    [self.bgview addSubview:self.btn_share];
    [self.btn_share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68*W_Scale);
        make.height.mas_equalTo(30*H_Scale);
        make.bottom.mas_equalTo(weakSelf.bgview.mas_bottom).offset(-23*H_Scale);
        make.left.mas_equalTo(weakSelf.lab_price.mas_right).offset(22*W_Scale);
    }];
    
    self.btn_qiang = [[UIButton alloc]init];
    self.btn_qiang.layer.cornerRadius = 3;
    self.btn_qiang.layer.masksToBounds = YES;
    self.btn_qiang.backgroundColor = KALLRGB;
    [self.bgview addSubview:self.btn_qiang];
    [self.btn_qiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68*W_Scale);
        make.height.mas_equalTo(30*H_Scale);
        make.bottom.mas_equalTo(weakSelf.bgview.mas_bottom).offset(-23*H_Scale);
        make.left.mas_equalTo(weakSelf.btn_share.mas_right).offset(10*W_Scale);
    }];
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = RGB(245, 245, 245);
    [self.bgview addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(weakSelf.bgview.mas_centerX);
        make.width.mas_equalTo(S_W);
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
