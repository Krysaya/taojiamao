//
//  TJMiddleModelsCell.m
//  taojiamao
//
//  Created by yueyu on 2018/5/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMiddleModelsCell.h"
#import "TJMiddleModelsCollectionCell.h"
//#import "TJHomeMiddleModels.h"
#define COUNT 5


@interface TJMiddleModelsCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectView;

@end

@implementation TJMiddleModelsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RandomColor;
    }
    return self;
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.contentView addSubview:self.collectView];
    [self.collectView reloadData];
}
#pragma mark -UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJMiddleModelsCollectionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MiddleModelsCoCell" forIndexPath:indexPath];
    TJHomeMiddleModels * model = self.dataArray[indexPath.item];
    
//    cell.models = model;

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TJHomeMiddleModels * model = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(middleModelsCollectionCellClick:)] && self.delegate) {
        [self.delegate middleModelsCollectionCellClick:model];
    }
}
#pragma mark - setter getter
-(UICollectionView *)collectView{
    if (_collectView==nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(S_W/5, self.yj_height/2);
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
//        _collectView.backgroundColor = RandomColor;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        [_collectView registerClass:[TJMiddleModelsCollectionCell class] forCellWithReuseIdentifier:@"MiddleModelsCoCell"];
    }
    return _collectView;
}
//-(void)setSubViewsWith:(NSMutableArray *)dataArray{
//
//    [self addSubview:self.views];
//    self.views.frame = self.bounds;
//
//    for (NSUInteger i =0; i<dataArray.count; i++) {
//        UIView * v = [[UIView alloc]init];
//        v.backgroundColor = RandomColor;
//        [self.views addSubview:v];
//        NSInteger W = S_W/COUNT;
//        NSInteger H = self.yj_height/2;
//        NSInteger row = i/COUNT;
//        NSInteger col = i%COUNT;
//
//        CGFloat X = W*col;
//        CGFloat Y = H*row;
//        v.frame = CGRectMake(X, Y, W, H);
//
//    }
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
