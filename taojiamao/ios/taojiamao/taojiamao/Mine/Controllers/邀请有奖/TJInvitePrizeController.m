//
//  TJInvitePrizeController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJInvitePrizeController.h"
#import "TJInvitePrizeCell.h"
#import "TJInvitationView.h"
@interface TJInvitePrizeController ()<UICollectionViewDelegate,UICollectionViewDataSource,ShareBtnDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_prize;
@property (weak, nonatomic) IBOutlet UILabel *lab_hour;
@property (weak, nonatomic) IBOutlet UILabel *lab_min;
@property (weak, nonatomic) IBOutlet UILabel *lab_ss;
@property (weak, nonatomic) IBOutlet UILabel *lab_mss;

@property (weak, nonatomic) IBOutlet UIView *view_tabBg;
@property (nonatomic, strong) UICollectionView *collectionV;
@end

@implementation TJInvitePrizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天天拆红包";
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
//    layou.sectionInset = UIEdgeInsetsMake(10, 30, 10, 28);
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view_tabBg.zj_width, self.view_tabBg.zj_height) collectionViewLayout:layou];
    collectV.backgroundColor = [UIColor whiteColor];
    collectV.delegate = self;
    collectV.dataSource = self;
    [collectV registerNib:[UINib nibWithNibName:@"TJInvitePrizeCell" bundle:nil] forCellWithReuseIdentifier:@"InvitePrizeCell"];
    [self.view_tabBg addSubview:collectV];
    self.collectionV = collectV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag==4780) {
//        规则
    }else if (sender.tag==4781){
//        提现
    }else if (sender.tag==4782){
//        分享
        TJInvitationView *iview = [TJInvitationView invitationView];
        iview.frame = CGRectMake(0, 0, S_W, S_H);iview.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:iview];
    }
}
#pragma mark - share
- (void)shareButtonClick:(NSInteger)sender{
    if (sender==140) {
//
    }else  if (sender==141) {
        //
    }else  if (sender==144) {
        //
    }else  if (sender==145) {
        //
    }else{
        [SVProgressHUD showInfoWithStatus:@"暂不支持"];
    }
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
    
    return CGSizeMake((S_W-35)/2, 275);
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJInvitePrizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InvitePrizeCell" forIndexPath:indexPath];
//    cell.model = self.dataArr[indexPath.row];
    //    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
//    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
//    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
//    goodVC.gid = model.itemid;
//    //    goodVC.price = model.itemprice;goodVC.priceQuan = model.itemendprice;
//    [self.navigationController pushViewController:goodVC animated:YES];
}

@end
