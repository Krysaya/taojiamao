
//
//  TJKdMineClassicCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMineClassicCell.h"
#import "TJPersonalCell.h"

@interface TJKdMineClassicCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collect;

@end

@implementation TJKdMineClassicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubvi];
//        self.backgroundColor = RGB(245, 245, 245);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubvi{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 20, S_W-30, 60) collectionViewLayout:flowLayout];
    self.collect.backgroundColor = [UIColor whiteColor];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    [self.collect registerClass:[TJPersonalCell class] forCellWithReuseIdentifier:@"555"];
    [self.contentView addSubview:self.collect];
    
}

#pragma mark - collectiondelegte
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJPersonalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"555" forIndexPath: indexPath];
    cell.height = 20;
    cell.imgView.image = @[[UIImage imageNamed:@"kd_my_money"],[UIImage imageNamed:@"kd_my_order"],[UIImage imageNamed:@"kd_my_team"],[UIImage imageNamed:@"kd_my_xin"],][indexPath.row];
    
    cell.titleLab.text = @[@"我的钱包",@"我的订单",@"我的团队",@"新手教程"][indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(S_W/5, 50);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      [self.mineCellDelegate collectionCell:self didSelectItemIndexPath:indexPath];
}

@end
