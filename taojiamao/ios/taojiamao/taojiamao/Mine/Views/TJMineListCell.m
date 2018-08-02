//
//  TJMineListCell.m
//  taojiamao
//
//  Created by yueyu on 2018/4/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMineListCell.h"
#import "TJPersonalCell.h"
#import "TJMembersModel.h"
#import "TJMemberMainModel.h"
@interface TJMineListCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UICollectionView *collect;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) TJMemberMainModel *model;
@end

@implementation TJMineListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self subViewLayout];
        self.backgroundColor = RGB(245, 245, 245);
    }
    return self;
}
#pragma makr - 布局

- (void)subViewLayout{
    WeakSelf
    
    self.bgView = [[UIView alloc]init];
    [self.contentView addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(345*W_Scale);
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
    }];
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*H_Scale);
        make.left.mas_equalTo(15*W_Scale);
        
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collect.backgroundColor = [UIColor whiteColor];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    [self.collect registerClass:[TJPersonalCell class] forCellWithReuseIdentifier:@"123"];
    [self.bgView addSubview:self.collect];
    [self.collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLab.mas_bottom).offset(15*H_Scale);
        make.left.mas_equalTo(weakSelf.bgView).offset(15);
        make.right.mas_equalTo(weakSelf.bgView).offset(-15);
        make.bottom.mas_equalTo(weakSelf.bgView.mas_bottom).offset(-5);
    }];
}

#pragma mark - collectiondelegte
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJPersonalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath: indexPath];
    cell.imgView.backgroundColor = RandomColor;

    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:self.model.menu];
    NSArray *arrmodel = [TJMembersModel mj_objectArrayWithKeyValuesArray:arr];
    TJMembersModel *model_m = arrmodel[indexPath.row];
    [cell.imgView sd_setImageWithURL: [NSURL URLWithString:model_m.icon]];
    cell.titleLab.text = model_m.text;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(60, 50);
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 21.0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:self.model.menu];
    DSLog(@"=hang==%ld--",arr.count);
    return arr.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//     会员权益
        if (self.mineCellDelegate && [self.mineCellDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)])
        {
            // 调用代理方法
            [self.mineCellDelegate collectionCell:self didSelectItemIndexPath:indexPath];
        }
    
}
- (void)cellHeaderTitle:(NSString *)title withArr:(TJMemberMainModel *)model{
    self.titleLab.text = title;
    self.model  = model;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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
