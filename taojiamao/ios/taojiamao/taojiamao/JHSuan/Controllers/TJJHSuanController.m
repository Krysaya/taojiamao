//
//  TJJHSuanController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJJHSuanController.h"
#import "TJJHSuanCell.h"

@interface TJJHSuanController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation TJJHSuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    UIImageView *headerImg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@""]];
    self.navigationItem.titleView = headerImg;
    [self setCollectionVc];
}

- (void)setCollectionVc{
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) collectionViewLayout:layou];
    collectV.delegate = self;
    collectV.dataSource = self;
    collectV.backgroundColor = RGB(245, 245, 245);
    [collectV registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil]
forCellWithReuseIdentifier:@"TJJHSuanCell"];
    [self.view addSubview:collectV];
}
#pragma mark ---- UICollectionViewDataSource

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}


//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((S_W-10)/2, 275*H_Scale);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJJHSuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJJHSuanCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
