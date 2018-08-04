//
//  TJGoodsDetailsElectCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsDetailsElectCell.h"
#import "TJJHSGoodsListModel.h"
@interface TJGoodsDetailsElectCell()

@property(nonatomic,strong)UILabel * elect;
@property(nonatomic,strong)UILabel * intro;

@end

@implementation TJGoodsDetailsElectCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
    }
    return self;
}
-(void)setSubViews{
//    self.contentView.bounds = [UIScreen mainScreen].bounds;
    
    self.elect = [[UILabel alloc]initWithFrame:CGRectMake(10*W_Scale, 6*H_Scale, 39*W_Scale, 18*H_Scale)];
    self.elect.text = @"推荐";

    self.elect.font = [UIFont systemFontOfSize:12];
//    self.elect.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.elect.textAlignment = NSTextAlignmentCenter;
//    self.elect.attributedText = attr;
    self.elect.layer.borderWidth =1.0;
    self.elect.layer.cornerRadius = 5.0;
    self.elect.layer.masksToBounds = YES;
    self.elect.layer.borderColor = [UIColor redColor].CGColor;
    self.elect.textColor = [UIColor redColor];
    [self.contentView addSubview:self.elect];
    
    self.intro = [[UILabel alloc]init];
    [self.contentView addSubview:self.intro];
    self.intro.numberOfLines = 0;
//    self.intro.lineBreakMode = NSLineBreakByCharWrapping;
    self.intro.font = [UIFont systemFontOfSize:12];
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*W_Scale);
        make.right.mas_equalTo(-12*W_Scale);
        make.top.mas_equalTo(5*W_Scale);
        make.bottom.mas_equalTo(-10*W_Scale);
    }];
}
-(void)setDetailsIntro:(NSString *)detailsIntro{
    _detailsIntro = detailsIntro;
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:detailsIntro];
    attr.yy_font = [UIFont systemFontOfSize:12];
    attr.yy_firstLineHeadIndent = 50;
    self.intro.attributedText =[self labelRetract:detailsIntro];
}

-(NSAttributedString*)labelRetract:(NSString*)str{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    // 对齐方式
    style.alignment = NSTextAlignmentJustified;
    // 首行缩进
    style.firstLineHeadIndent = 50.0f;
    // 头部缩进
    //    style.headIndent = 10.0f;
    // 尾部缩进
    //    style.tailIndent = -10.0f;
    [style  setLineSpacing:10];
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:str attributes:@{ NSParagraphStyleAttributeName : style}];
    return attrText;
}

//- (void)setModel_detail:(TJJHSGoodsListModel *)model_detail{
//    DSLog(@"0-我====%@",model_detail.guide_article);
//
//        self.intro.attributedText =[self labelRetract:model_detail.guide_article];
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
