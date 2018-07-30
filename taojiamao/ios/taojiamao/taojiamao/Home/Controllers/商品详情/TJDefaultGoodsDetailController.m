
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
#import "TJJHSGoodsListModel.h"
#import "UIViewController+Extension.h"

static NSString * const GoodsDetailsTitleCell = @"GoodsDetailsTitleCell";
static NSString * const GoodsDetailsElectCell = @"GoodsDetailsElectCell";
static NSString * const GoodsDetailsLFCCell = @"GoodsDetailsLFCCell";
static NSString * const GoodsDetailsCompanyCell = @"GoodsDetailsCompanyCell";
static NSString * const GoodsDetailsImagesCell = @"GoodsDetailsImagesCell";

#define DetailsBackButton   951
#define DetailShareButton   952
#define DetailCollectButton   956

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

@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)TJButton * shareB;
@property(nonatomic,strong)TJLabel * shareL;
@property(nonatomic,strong)TJButton * buy;

@property(nonatomic,strong)TJButton * goTop;

@property(nonatomic,strong)TJBottomPopupView * popupView;

//会员不隐藏推广
@property(nonatomic,strong)TJButton *popularize;
@property(nonatomic,strong)NSMutableArray * imageSSS;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJDefaultGoodsDetailController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self requestGoodsInfo];
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
//    [self setUIbanner];
    [self setUIfootView];
//    [self setUIgoTop];
}

- (void)requestGoodsInfo{
    self.dataArr = [NSMutableArray array];
    self.imageSSS = [NSMutableArray array];

    NSString *userid = GetUserDefaults(UID);
    
    DSLog(@"-=====uiddddddd-%@",userid);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary * param = @{
                                    @"id":self.gid,
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    }.mutableCopy;
    
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:param withSecert:SECRET];
    DSLog(@"sign==%@,times==%@,uid==%@,gid==%@,url==%@",md5Str,timeStr,userid,self.gid,[NSString stringWithFormat:@"%@/%@",GoodsInfoList,self.gid]);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = [NSString stringWithFormat:@"%@/%@",GoodsInfoList,self.gid];
        request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str,@"uid":userid};
        request.httpMethod = kXMHTTPMethodGET;
    }onSuccess:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        
        NSLog(@"onSuccess:%@ ===详情====",responseObject);

        
        TJJHSGoodsListModel *model = [TJJHSGoodsListModel mj_objectWithKeyValues:dict];
        [self.dataArr addObject:model];
//        [self.imageSSS addObjectsFromArray:model.detail];
//        TJGoodsInfoListModel *model = self.dataArr[0];
        DSLog(@"==%ld===%ld==%@",self.imageSSS.count,self.dataArr.count,model.itempic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUI];
            
        });
        
        
    } onFailure:^(NSError *error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"---onFailure--%@",dic_err);
        
    }];
    
}
-(void)setUIgoTop{
    WeakSelf
    self.goTop = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailsGoTopButton withBackImage:@"morentouxiang" withSelectImage:nil];
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
    self.footView.backgroundColor = RGB(255, 255, 255);
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).offset(-SafeAreaBottomHeight);
        make.height.mas_equalTo(54*H_Scale);
    }];
    
    self.shareB = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailCollectButton withBackImage:@"collect_default" withSelectImage:@"collect_light"];
    self.shareB.backgroundColor = RandomColor;
    [self.footView addSubview:self.shareB];
    [self.shareB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(31*W_Scale);
        make.top.mas_equalTo(10*H_Scale);
        make.width.height.mas_equalTo(19*W_Scale);
    }];
    
    self.shareL = [TJLabel setLabelWith:@"收藏" font:10 color:RGB(150, 150, 150)];
    [self.footView addSubview:self.shareL];
    [self.shareL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.shareB);
        make.top.mas_equalTo(weakSelf.shareB.mas_bottom).offset(6*H_Scale);
    }];
    
    self.buy = [[TJButton alloc]initWith:@"立即购买" delegate:self font:17 titleColor:RGB(255, 255, 255) backColor:[UIColor redColor] tag:DetailsBuyButton cornerRadius:0];
    [self.footView addSubview:self.buy];
    [self.buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footView);
        make.left.mas_equalTo(weakSelf.shareL.mas_right).offset(31*W_Scale);
        make.right.mas_equalTo(weakSelf.footView);
        make.height.mas_equalTo(54);
    }];
}

-(void)setBackButton{
    CGFloat TOP = 20;
    self.backButton = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailsBackButton withBackImage:@"back_left" withSelectImage:nil];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9*W_Scale);
        make.top.mas_equalTo(TOP);
        make.width.height.mas_equalTo(32*W_Scale);
    }];
//    DetailShareButton
     TJButton *shareButton = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailShareButton withBackImage:@"share" withSelectImage:nil];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-9);
        make.top.mas_equalTo(TOP);
        make.width.height.mas_equalTo(32*W_Scale);
    }];
}

-(void)setUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, S_W, S_H-54) style:UITableViewStyleGrouped];
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
    
    [self setBackButton];

}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==4) {
        return self.imageSSS.count;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TJDafultGoodsTitlesCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsTitleCell forIndexPath:indexPath];
        [cell.btn_coupon addTarget:self action:@selector(getCouponClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.model_detail = self.dataArr[0];
        return cell;
    }else if(indexPath.section==1){
        TJGoodsDetailsElectCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsElectCell forIndexPath:indexPath];
        cell.model_detail = self.dataArr[0];
        return cell;
    }else if(indexPath.section==2){

        TJGoodsDetailsLFCCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsLFCCell forIndexPath:indexPath];
        cell.content = @"复制淘口令，打开【手机淘宝】即可";
        cell.isTKL = YES;
        return cell;
    }else if(indexPath.section==3){
        TJGoodsDetailsCompanyCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsCompanyCell forIndexPath:indexPath];
        cell.model_detail = self.dataArr[0];

        return cell;

    }else{
        TJGoodsDetailsImagesCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsImagesCell forIndexPath:indexPath];
        cell.urlStr = self.imageSSS[indexPath.row];
        cell.model_detail = self.dataArr[0];

        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 590;
    }else if(indexPath.section==1){
        return [tableView fd_heightForCellWithIdentifier:GoodsDetailsElectCell cacheByIndexPath:indexPath configuration:^(TJGoodsDetailsElectCell *cell) {
            cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
            TJJHSGoodsListModel *model = self.dataArr[0];
            cell.detailsIntro = model.guide_article;
        }];
    }else if (indexPath.section==2){
        return 42;
    }else if(indexPath.section==3){
        return 76;
    }else{
        NSString *url = self.imageSSS[indexPath.row];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:S_W estimateHeight:200];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {

    }else if (indexPath.section==2){
        self.popupView = [[TJBottomPopupView alloc]initWithFrame:CGRectMake(0, -20, S_W, S_H+20-SafeAreaBottomHeight) select:indexPath.section height:325*H_Scale info:nil];
        self.popupView.deletage = self;
        [self.view addSubview:self.popupView];
    }else if (indexPath.section==3){

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

#pragma mark - TJButtonDeletage
-(void)buttonClick:(UIButton *)but{
    if (but.tag==DetailsBuyButton) {
        DSLog(@"购买");
    }else if (but.tag==DetailShareButton){
        DSLog(@"分享");
    }else if (but.tag==DetailsGoTopButton){
        DSLog(@"返回顶部");
        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else if (but.tag==DetailCollectButton){
        DSLog(@"收藏");
        [self requestCollectGoods];        
        
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

- (void)getCouponClick{
    DSLog(@"优惠券-领取");
    
}

-(void)requestCollectGoods{
//    收藏
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":@"1",
                                @"rid":self.gid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
     [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
         request.url = AddCollect;
         request.headers = @{@"timestamp": timeStr,
                             @"app": @"ios",
                             @"sign":md5Str,
                             @"uid":userid,
                             };
         request.httpMethod = kXMHTTPMethodPOST;
         request.parameters = @{@"type":@"1",@"rid":self.gid};
     }onSuccess:^(id  _Nullable responseObject) {
         DSLog(@"-collect-success--%@==",responseObject);
     }onFailure:^(NSError * _Nullable error) {
         NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
         NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
         DSLog(@"--收藏-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
     }];
}
#pragma mark - TJBottomViewDeletage
-(void)clickViewRemoveFromSuper{
    [self.popupView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
