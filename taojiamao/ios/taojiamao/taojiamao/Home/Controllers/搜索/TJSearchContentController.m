//
//  TJSearchContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/24.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSearchContentController.h"
#import "TJHomeFootShowCell.h"
#import "TJGoodsListCell.h"
#import "TJJHSuanCell.h"
#import "TJJHSGoodsListModel.h"
#import "TJDefaultGoodsDetailController.h"

static NSString *TJSearchContentFootShowCell = @"TJSearchContentFootShowCell";
static NSString *TJSearchContentCollectionCell = @"TJSearchContentCollectionCell";

@interface TJSearchContentController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ZJScrollPageViewChildVcDelegate>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation TJSearchContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUITableView];
    [self setUICollectionView];
    self.tableView.hidden = YES;
    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(horizontalVerticalTransform:) name:TJHorizontalVerticalTransform object:nil];
}

-(void)setUITableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, S_W, S_H-SafeAreaTopHeight-85) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:TJSearchContentFootShowCell];
    
    [self.view addSubview:self.tableView];
}
-(void)setUICollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((S_W-5)*0.5, 275);
    layout.minimumLineSpacing= 5;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight-85) collectionViewLayout:layout];
    self.collectionView.backgroundColor = RandomColor;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TJJHSuanCell" bundle:nil] forCellWithReuseIdentifier:TJSearchContentCollectionCell];
    
    [self.view addSubview:self.collectionView];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell * cell = [tableView dequeueReusableCellWithIdentifier:TJSearchContentFootShowCell forIndexPath:indexPath];
//    cell.model = self.dataArr[indexPath.row];
    [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:NO withType:@"0"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TJJHSuanCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TJSearchContentCollectionCell forIndexPath:indexPath];
    cell.cell_type = @"search";
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((S_W-10)/2, 275);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJJHSGoodsListModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    DSLog(@"ew89ur424colll====%@",model.guide_article);
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - 通知
-(void)horizontalVerticalTransform:(NSNotification*)info{
    DSLog(@"%@",info.userInfo[@"hsBool"]);
    NSNumber * num = info.userInfo[@"hsBool"];
    BOOL hs = [num boolValue];
    self.tableView.hidden = !hs;
    self.collectionView.hidden = hs;
}

-(void)dealloc{
//    DSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
