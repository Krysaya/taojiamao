
//
//  TJDefaultGoodsDetailController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
// 普通详情页

#import "TJDefaultGoodsDetailController.h"
#import "TJDafultGoodsTitlesCell.h"
#import "TJGoodsDetailsElectCell.h"
#import "TJGoodsDetailsLFCCell.h"
#import "TJGoodsDetailsCompanyCell.h"
#import "TJGoodsDetailsImagesCell.h"
#import "TJBottomPopupView.h"
#import "TJPopularizeController.h"

#import "UIViewController+Extension.h"

static NSString * const GoodsDetailsTitleCell = @"GoodsDetailsTitleCell";
static NSString * const GoodsDetailsElectCell = @"GoodsDetailsElectCell";
static NSString * const GoodsDetailsLFCCell = @"GoodsDetailsLFCCell";
static NSString * const GoodsDetailsCompanyCell = @"GoodsDetailsCompanyCell";
static NSString * const GoodsDetailsImagesCell = @"GoodsDetailsImagesCell";

#define DetailsBackButton   951
#define DetailShareButton   952
#define DetailsBuyButton    953
#define DetailsGoTopButton  954
#define DetailsPopularize   955

@interface TJDefaultGoodsDetailController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,SDCycleScrollViewDelegate,TJBottomPopupViewDelegate>

{
    CGFloat _currentAlpha;
}
@property(nonatomic,strong)TJButton * backButton;

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)SDCycleScrollView * bannerView;
@property(nonatomic,strong)NSMutableArray * imageSSS;

@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)TJButton * shareB;
@property(nonatomic,strong)TJLabel * shareL;
@property(nonatomic,strong)TJButton * buy;

@property(nonatomic,strong)TJButton * goTop;

@property(nonatomic,strong)TJBottomPopupView * popupView;

//会员不隐藏推广
@property(nonatomic,strong)TJButton *popularize;

@end

@implementation TJDefaultGoodsDetailController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //视图将要消失时取消隐藏
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setBackButton];
//    [self setUIbanner];
    [self setUIfootView];
//    [self setUIgoTop];
}
-(void)setUIgoTop{
    WeakSelf
    self.goTop = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailsGoTopButton withBackImage:@"morentouxiang"];
    [self.view addSubview:self.goTop];
    [self.goTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20*W_Scale);
        make.bottom.mas_equalTo(weakSelf.footView.mas_top).offset(-36*H_Scale);
        make.width.height.mas_equalTo(25*W_Scale);
    }];
}
-(void)setUIfootView{
    WeakSelf
    self.footView = [[UIView alloc]init];
    self.footView.backgroundColor = RandomColor;
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).offset(-SafeAreaBottomHeight);
        make.height.mas_equalTo(54*H_Scale);
    }];
    
    self.shareB = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailShareButton withBackImage:@"morentouxiang"];
    [self.footView addSubview:self.shareB];
    [self.shareB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(31*W_Scale);
        make.top.mas_equalTo(10*H_Scale);
        make.width.height.mas_equalTo(19*W_Scale);
    }];
    
    self.shareL = [TJLabel setLabelWith:@"分享" font:10 color:RGB(150, 150, 150)];
    [self.footView addSubview:self.shareL];
    [self.shareL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.shareB);
        make.top.mas_equalTo(weakSelf.shareB.mas_bottom).offset(6*H_Scale);
    }];
    
    self.buy = [[TJButton alloc]initWith:@"立即购买" delegate:self font:17 titleColor:RGB(255, 255, 255) backColor:[UIColor redColor] tag:DetailsBuyButton cornerRadius:20];
    [self.footView addSubview:self.buy];
    [self.buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footView);
        make.left.mas_equalTo(weakSelf.shareL.mas_right).offset(31*W_Scale);
        make.width.mas_equalTo(263*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}

-(void)setBackButton{
    CGFloat TOP = IsX?26*H_Scale+24:26*H_Scale;
    self.backButton = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailsBackButton withBackImage:@"back_left"];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9*W_Scale);
        make.top.mas_equalTo(TOP);
        make.width.height.mas_equalTo(32*W_Scale);
    }];
}

-(void)setUI{
    CGFloat Y = IsX?-44:-20;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, S_W, S_H+20-54*H_Scale) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell123"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJDafultGoodsTitlesCell" bundle:nil] forCellReuseIdentifier:GoodsDetailsTitleCell];
    [self.tableView registerClass:[TJGoodsDetailsElectCell class] forCellReuseIdentifier:GoodsDetailsElectCell];
    [self.tableView registerClass:[TJGoodsDetailsLFCCell class] forCellReuseIdentifier:GoodsDetailsLFCCell];
    [self.tableView registerClass:[TJGoodsDetailsCompanyCell class] forCellReuseIdentifier:GoodsDetailsCompanyCell];
    [self.tableView registerClass:[TJGoodsDetailsImagesCell class] forCellReuseIdentifier:GoodsDetailsImagesCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==7) {
//        return self.imageSSS.count;
//    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TJDafultGoodsTitlesCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsTitleCell forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section==1){
        TJGoodsDetailsElectCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsElectCell forIndexPath:indexPath];
        cell.detailsIntro = @"推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐";
        return cell;
    }else if(indexPath.section==2){
//        TJGoodsDetailsLFCCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsLFCCell forIndexPath:indexPath];
//        cell.LFC = @"领券";
//        cell.content = @"为气温气温气温气温气温气温气温气温的方式大哥大法官的发个非官方个";
//        cell.isTKL = NO;
//        return cell;
        TJGoodsDetailsLFCCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsLFCCell forIndexPath:indexPath];
        cell.content = @"复制淘口令，打开【手机淘宝】即可";
        cell.isTKL = YES;
        return cell;
    }else if(indexPath.section==3){
        TJGoodsDetailsCompanyCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsCompanyCell forIndexPath:indexPath];
        
        return cell;

    }else{
        TJGoodsDetailsImagesCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsImagesCell forIndexPath:indexPath];
        cell.urlStr = self.imageSSS[indexPath.row];
        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 471;
    }else if(indexPath.section==1){
        return [tableView fd_heightForCellWithIdentifier:GoodsDetailsElectCell cacheByIndexPath:indexPath configuration:^(TJGoodsDetailsElectCell *cell) {
            cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
            cell.detailsIntro = @"推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐";
        }];
    }else if (indexPath.section==2){
        return 42*H_Scale;
    }else if(indexPath.section==3){
        return 76*H_Scale;
    }else{
        NSString *url = self.imageSSS[indexPath.row];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:S_W estimateHeight:200];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
//        self.popupView = [[TJBottomPopupView alloc]initWithFrame:CGRectMake(0, -20, S_W, S_H+20-SafeAreaBottomHeight) select:indexPath.section height:325*H_Scale info:nil];
//        self.popupView.deletage = self;
//        [self.view addSubview:self.popupView];
    }else if (indexPath.section==2){
        self.popupView = [[TJBottomPopupView alloc]initWithFrame:CGRectMake(0, -20, S_W, S_H+20-SafeAreaBottomHeight) select:indexPath.section height:325*H_Scale info:nil];
        self.popupView.deletage = self;
        [self.view addSubview:self.popupView];
    }else if (indexPath.section==3){
//
//        self.popupView = [[TJBottomPopupView alloc]initWithFrame:CGRectMake(0, -20, S_W, S_H+20-SafeAreaBottomHeight) select:indexPath.section height:325*H_Scale info:nil];
//        self.popupView.deletage = self;
//        [self.view addSubview:self.popupView];
    }else {
//

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
        return 5;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
//    if (offset<S_H) {
//        self.goTop.alpha = 0.0;
//    }else {
//        CGFloat alpha=1-((SafeAreaTopHeight-offset)/SafeAreaTopHeight);
//        self.goTop.alpha=alpha;
//        //        self.goTop.alpha = 1.0;
//    }
    
  
}
#pragma mark - TJButtonDeletage
-(void)buttonClick:(UIButton *)but{
    if (but.tag==DetailsBuyButton) {
        DSLog(@"购买");
    }else if (but.tag==DetailShareButton){
        DSLog(@"分享");
    }else if (but.tag==DetailsGoTopButton){
        DSLog(@"返回顶部");
        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else if (but.tag==DetailsPopularize){
        DSLog(@"我要推广");
//        TJPopularizeController * pvc = [[TJPopularizeController alloc]init];
//        pvc.title = @"我要推广";
//        pvc.imagesData = self.imageSSS;
//        [self.navigationController pushViewController:pvc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
#pragma mark - TJBottomViewDeletage
-(void)clickViewRemoveFromSuper{
    [self.popupView removeFromSuperview];
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
