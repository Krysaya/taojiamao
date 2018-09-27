
//
//  TJUpgradeAgentController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJUpgradeAgentController.h"
#import "TJAgentAddressController.h"
#import "TJAgentLevelModel.h"
#import "TJUpgradeAgentModel.h"

#import "TJUpgradeAgentCell.h"

@interface TJUpgradeAgentController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btn_dl;
@property (weak, nonatomic) IBOutlet UIButton *btn_xy;
@property (weak, nonatomic) IBOutlet UIButton *btn_apply;


@property (nonatomic, strong) UIImageView *img_top;
@property (nonatomic, strong) UICollectionView *collectV;
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSArray *levelArr;
@property (nonatomic, strong) NSMutableArray *goodsArr;

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *gid;

@end

@implementation TJUpgradeAgentController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn_dl.selected = YES;
    
    self.title = @"升级代理人";//右上角按扭----规则
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-90-SafeAreaTopHeight)];
    scrollView.contentSize = CGSizeMake(0, S_H*1.5);
    [self.view addSubview:scrollView];
    WeakSelf
    self.levelArr  = [NSArray array];
    [KConnectWorking requestNormalDataParam:nil withRequestURL:AgenterLevel withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        DSLog(@"--会员呢等级--%@",responseObject);
        weakSelf.levelArr = [TJAgentLevelModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf setTopView];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
    
   
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 300)];
    img.backgroundColor = RandomColor;
    [scrollView addSubview:img];
    self.img_top = img;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(135, 200);

    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 300+20, S_W, 200) collectionViewLayout:layout];
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.showsHorizontalScrollIndicator = NO;
    [collectionV registerNib:[UINib nibWithNibName:@"TJUpgradeAgentCell" bundle:nil] forCellWithReuseIdentifier:@"UpgradeAgentCell"];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [scrollView addSubview:collectionV];
    self.collectV = collectionV;
   
  
}
- (void)setTopView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 49)];
    bgView.backgroundColor = RGBA(1, 1, 1, 0.2);
    [self.view addSubview:bgView];
    [bgView bringSubviewToFront:self.view];
    NSMutableArray *arr = [NSMutableArray array];
    for (TJAgentLevelModel *m in self.levelArr) {
        [arr addObject:m.name];
    }
    for (int i=0; i<self.levelArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(85*i, 0, 85, 49)];
        btn.tag = i+100;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnChooseClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [bgView addSubview:btn];
        if (i==0) {
            self.selectBtn = btn;
            [btn setBackgroundColor: [UIColor redColor]];
        }else{
            [btn setBackgroundColor: [UIColor clearColor]];
            
        }
    }
    WeakSelf
    self.goodsArr = [NSMutableArray array];
    TJAgentLevelModel *m = self.levelArr[0];
    [KConnectWorking requestNormalDataParam:@{@"level_id":m.id,} withRequestURL:UpgradeAgent withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        DSLog(@"----goods-1111--%@",responseObject);
        weakSelf.goodsArr = [TJUpgradeAgentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.collectV reloadData];
        TJUpgradeAgentModel *model = self.goodsArr[0];
        weakSelf.gid = model.id;
        [weakSelf.img_top sd_setImageWithURL: [NSURL URLWithString:model.image]];
        NSString *one = [NSString stringWithFormat:@"%.2f",[model.upgrade_price floatValue]/100];
        weakSelf.money = one;
        [weakSelf.btn_apply setTitle:[NSString stringWithFormat:@"立即申请(%@)",one] forState:UIControlStateNormal];

//        [weakSelf.collectV selectItemAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)btnChooseClick:(UIButton *)btn
{
    WeakSelf
    self.goodsArr = [NSMutableArray array];
    NSInteger i = btn.tag-100;
    if (self.selectBtn == btn) {
        
    }else{
        [btn setBackgroundColor:[UIColor redColor]];
        [self.selectBtn setBackgroundColor:[UIColor clearColor]];
    }
    self.selectBtn = btn;
    TJAgentLevelModel *m = self.levelArr[i];
    [KConnectWorking requestNormalDataParam:@{@"level_id":m.id,} withRequestURL:UpgradeAgent withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        DSLog(@"----goods--%ld-%@",(long)btn.tag,responseObject);
        weakSelf.goodsArr = [TJUpgradeAgentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.collectV reloadData];

        TJUpgradeAgentModel *model = self.goodsArr[0];
        self.gid = model.id;
        [self.img_top sd_setImageWithURL: [NSURL URLWithString:model.image]];
        NSString *one = [NSString stringWithFormat:@"%.2f",[model.upgrade_price floatValue]/100];
        self.money = one;
        [self.btn_apply setTitle:[NSString stringWithFormat:@"立即申请(%@)",one] forState:UIControlStateNormal];
//         [weakSelf.collectV selectItemAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    } withFailure:^(NSError * _Nullable error) {
        
    }];
    
}
- (IBAction)agreeBtnClick:(UIButton *)sender {
//    同意按扭
    sender.selected = !sender.selected;
    self.btn_apply.userInteractionEnabled = !self.btn_apply.userInteractionEnabled;
    if (sender.selected==YES) {
//        DSLog(@"选中");
        [self.btn_apply setBackgroundColor: [UIColor redColor]];
    }else{
        [self.btn_apply setBackgroundColor: [UIColor lightGrayColor]];

    }
}
- (IBAction)agentAgreement:(UIButton *)sender {
    //    代理协议
    DSLog(@"-- 代理协议-");

}
- (IBAction)applyAgent:(UIButton *)sender {
//    申请代理
    DSLog(@"---");
    TJAgentAddressController *vc = [[TJAgentAddressController alloc]init];
    vc.money = self.money;vc.gid = self.gid;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.goodsArr.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJUpgradeAgentCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpgradeAgentCell" forIndexPath:indexPath];

    if (indexPath.row==0) {//指定第一行为选中状态
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    cell.model = self.goodsArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    TJUpgradeAgentModel *model = self.goodsArr[indexPath.row];
    self.gid = model.id;
    [self.img_top sd_setImageWithURL: [NSURL URLWithString:model.image]];
    NSString *one = [NSString stringWithFormat:@"%.2f",[model.upgrade_price floatValue]/100];
    self.money = one;
    [self.btn_apply setTitle:[NSString stringWithFormat:@"立即申请(%@)",one] forState:UIControlStateNormal];

//    TJGoodCatesMainListModel *model = self.dataArr_top[indexPath.row];
//    TJClassicSecondController *vc = [[TJClassicSecondController alloc]init];
//    vc.title_class = model.catname;
//    [self.navigationController pushViewController:vc animated:YES];
}
//- (void)chooseCellIndex:(UIButton *)sender{
//    if (self.tag) {
//        UIButton *btn = (UIButton *)[self.view viewWithTag:sender.tag];
//        btn.selected = NO;
//    }
//
//    sender.selected = YES;
//    self.tag = sender.tag;
//}
@end
