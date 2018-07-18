
//
//  TJClassicSecondCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//


#import "TJClassicSecondCell.h"
#import "TJCollectionClassicCell.h"

@interface TJClassicSecondCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UICollectionView *collect;

@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSArray *titleArr;


@end
@implementation TJClassicSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


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
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5*H_Scale);
        make.left.mas_equalTo(15*W_Scale);
        
    }];

    
    WeakSelf
    self.bgView = [[UIView alloc]init];
    [self.contentView addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLab.mas_bottom).offset(10);
        make.height.mas_equalTo(200);
//        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(S_W-120);
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collect.backgroundColor = [UIColor whiteColor];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    [self.collect registerNib:[UINib nibWithNibName:@"TJCollectionClassicCell" bundle:nil] forCellWithReuseIdentifier:@"collectClassiCell"];
    [self.bgView addSubview:self.collect];
    [self.collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bgView);
        make.left.mas_equalTo(weakSelf.bgView).offset(10);
        make.right.mas_equalTo(weakSelf.bgView).offset(-10);
        make.bottom.mas_equalTo(weakSelf.bgView.mas_bottom);
    }];
    
}
#pragma mark - collectiondelegte
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJCollectionClassicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectClassiCell" forIndexPath: indexPath];
    //    cell.imgView.backgroundColor = RandomColor;
    cell.imageV.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    
    cell.lab_titel.text = self.titleArr[indexPath.row];
    //    cell.backgroundColor = [UIColor blackColor];
    
    //    [self updateCollectionViewHight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(90, 90);
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
    
}

- (void)cellHeaderTitle:(NSString *)title withImageArr:(NSArray *)imgArr withtitleArr:(NSArray *)titleArr{
    self.titleLab.text = title;
    self.imgArr = imgArr;
    self.titleArr = titleArr;
    
}
@end
