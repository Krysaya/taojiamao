
//
//  TJUpgradeAgentController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJUpgradeAgentController.h"
#import "TJUpgradeAgentCell.h"

@interface TJUpgradeAgentController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btn_dl;
@property (weak, nonatomic) IBOutlet UIButton *btn_yy;
@property (weak, nonatomic) IBOutlet UIButton *btn_apply;


@property (nonatomic, strong) UIView *top_view;
@property (nonatomic, strong) UIView *bottom_view;
@property (nonatomic, strong) UIScrollView *scrollV;
@end

@implementation TJUpgradeAgentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"升级代理人";//右上角按扭----规则
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H)];
//    scrollView.
    [self.view addSubview:scrollView];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 300)];
    img.backgroundColor = RandomColor;
    [scrollView addSubview:img];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(135, 200);

    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 300, S_W, 200) collectionViewLayout:layout];
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.showsHorizontalScrollIndicator = NO;
    [collectionV registerNib:[UINib nibWithNibName:@"TJUpgradeAgentCell" bundle:nil] forCellWithReuseIdentifier:@"UpgradeAgentCell"];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [scrollView addSubview:collectionV];
}

- (IBAction)agreeBtnClick:(UIButton *)sender {
//    同意按扭
}
- (IBAction)agentAgreement:(UIButton *)sender {
//    代理协议
}
- (IBAction)applyAgent:(UIButton *)sender {
//    申请代理
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJUpgradeAgentCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpgradeAgentCell" forIndexPath:indexPath];
    
//    cell.model = self.dataArr_top[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    TJGoodCatesMainListModel *model = self.dataArr_top[indexPath.row];
//    TJClassicSecondController *vc = [[TJClassicSecondController alloc]init];
//    vc.title_class = model.catname;
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
