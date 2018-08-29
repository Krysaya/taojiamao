//
//  TJMyAddressCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMyAddressCell.h"

#define DeleteButton 6571032
#define EditButton   7410256

@interface TJMyAddressCell()
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * phoneLabel;
@property(nonatomic,strong)UILabel * addressLabel;
@property(nonatomic,strong)UIView * line;
@property(nonatomic,strong)UILabel * morenLabel;
@property(nonatomic,strong)UIButton * edit;

@end

@implementation TJMyAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel = [self setLabelWith:@"" font:15*W_Scale color:[UIColor blackColor]];
        _phoneLabel = [self setLabelWith:@"" font:15*W_Scale color:[UIColor blackColor]];
        _addressLabel = [self setLabelWith:@"" font:13*W_Scale color:RGB(51, 51, 51)];
        _addressLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_phoneLabel];
        [self.contentView addSubview:_addressLabel];
        
        WeakSelf
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15*H_Scale);
            make.left.mas_equalTo(17*W_Scale);
        }];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(23*H_Scale);
            make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(28*W_Scale);
            make.centerY.mas_equalTo(weakSelf.nameLabel);
        }];
        
        _morenLabel = [[UILabel alloc]init];
        _morenLabel.text = @"默认";
        _morenLabel.textAlignment = NSTextAlignmentCenter;
        _morenLabel.font = [UIFont systemFontOfSize:12];
        _morenLabel.textColor = [UIColor whiteColor];
        _morenLabel.backgroundColor= KKDRGB;
        _morenLabel.layer.masksToBounds = YES;
        _morenLabel.layer.cornerRadius = 7;
        
        [self.contentView addSubview:_morenLabel];
        [_morenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(weakSelf.phoneLabel);
            make.centerY.mas_equalTo(weakSelf.phoneLabel);

            make.left.mas_equalTo(weakSelf.phoneLabel.mas_right).offset(15*W_Scale);
            make.width.mas_equalTo(37);
            make.height.mas_equalTo(17);
        }];
        
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(8*H_Scale);
            make.left.mas_equalTo(weakSelf.nameLabel);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(266*W_Scale);
        }];
        
        _edit = [self setButtonWith:@"edit" tag:EditButton];
        [self.contentView addSubview:_edit];
        [_edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(17);
            make.bottom.mas_equalTo(weakSelf.contentView).offset(-20);
            make.right.mas_equalTo(weakSelf.contentView).offset(-15);
            
        }];
        
        
        
        
//        _line = [[UIView alloc]init];
//        _line.backgroundColor = RGB(230, 230, 230);
//        [self.contentView addSubview:_line];
//        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(weakSelf.contentView);
//            make.bottom.mas_equalTo(weakSelf.contentView).offset(-1);
//            make.width.mas_equalTo(345*W_Scale);
//            make.height.mas_equalTo(1);
//        }];
//
        
        
        
        
    }
    return self;
}
-(UIButton*)setButtonWith:(NSString*)img tag:(NSInteger)tag {
    UIButton * button = [[UIButton alloc]init];
    button.tag= tag;
    [button addTarget:self action:@selector(deButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14*W_Scale];
//    [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    return button;
}
-(void)deButtonClick:(UIButton*)button{
    if (self.deletage && [self.deletage respondsToSelector:@selector(editClick:)]) {
        [self.deletage editClick:self.indexPath];
    }
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}

-(void)setModel:(TJMyAddressModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    self.phoneLabel.text = model.telephone;
    self.addressLabel.text = model.address;
//    self.addressLabel.text = [model.full_address stringByAppendingString:model.address];
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.section==0) {
        _morenLabel.hidden = NO;
    }else{
        _morenLabel.hidden = YES;
    }
//    DSLog(@"%ld",(long)indexPath.section);
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
