
//
//  TJClassicSecondController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassicSecondController.h"
#import "TJFiltrateView.h"
#import "TJMultipleChoiceView.h"
#import "TJJHSuanCell.h"
#import "TJDefaultGoodsDetailController.h"
#import "TJHomeFootShowCell.h"
@interface TJClassicSecondController ()<TJFiltrateViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,strong)TJFiltrateView *filtrate;
@end

@implementation TJClassicSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.title = @"卫衣";
    
    
    [self setNavgation];

    [self setUITableView];
    [self setUICollectionView];
    self.tableView.hidden = YES;
    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(horizontalVerticalTransform:) name:TJHorizontalVerticalTransform object:nil];
    
    self.filtrate = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 45) withMargin:25];
    self.filtrate.deletage =self;
    [self.view addSubview:self.filtrate];
    
  
}
- (void)setNavgation{

    //    1边按钮
    TJButton *button_left = [[TJButton alloc]initDelegate:self backColor:nil tag:885 withBackImage:@"search"];
    
    //    you2边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:896 withBackImage:@"notice"];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:button_left];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:button_right];

    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItems = @[item1,item2];

}
-(void)setUITableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+45+15, S_W, S_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TJHomeFootShowCell class] forCellReuseIdentifier:@"tabListCell"];
    
    [self.view addSubview:self.tableView];
}

- (void)setUICollectionView{
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+45+15, S_W, S_H) collectionViewLayout:layou];
    collectV.delegate = self;
    collectV.dataSource = self;
    collectV.backgroundColor = RGB(245, 245, 245);
    [collectV registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil]
forCellWithReuseIdentifier:@"TJJHSuanCell"];
    [self.view addSubview:collectV];
    self.collectionView = collectV;
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
    
    return CGSizeMake((S_W-5)/2, 275*H_Scale);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJJHSuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJJHSuanCell" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJHomeFootShowCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tabListCell" forIndexPath:indexPath];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

#pragma mark - TJFiltrateViewDelegate

-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
    TJMultipleChoiceView * mcv = [[TJMultipleChoiceView alloc]initWithFrame:self.view.bounds];
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    [window addSubview:mcv];
}
#pragma mark - 通知
-(void)horizontalVerticalTransform:(NSNotification*)info{
    DSLog(@"%@",info.userInfo[@"hsBool"]);
    NSNumber * num = info.userInfo[@"hsBool"];
    BOOL hs = [num boolValue];
    self.tableView.hidden = !hs;
    self.collectionView.hidden = hs;
}
#pragma mark - btndelegte
- (void)buttonClick:(UIButton *)but{
    if (but.tag ==885) {
       
//        搜索
    }else{
//        TJNoticeController *noticeV = [[TJNoticeController alloc]init];
//        [self.navigationController pushViewController:noticeV animated:YES];
    }
}


@end
