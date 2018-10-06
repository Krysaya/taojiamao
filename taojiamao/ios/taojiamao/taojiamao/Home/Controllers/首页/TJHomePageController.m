
//
//  TJHomePageController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomePageController.h"
#import "TJPublicURL.h"
#import "SGAdvertScrollView.h"

#import "TJHPMidCollectCell.h"
#import "TJClassOneCell.h"
#import "TJClassTwoCell.h"
#import "TJHeadLineCustomCell.h"
#import "TJGoodsListCell.h"

#import "TJHomeSignController.h"
#import "TJNoticeController.h"
#import "TJHomeController.h"
#import "TJSearchController.h"
#import "TJProjectController.h"
//#import "TJClassicController.h"
#import "TJDefaultGoodsDetailController.h"
#import "TJClassicController.h"
#import "TJHeadLineController.h"
#import "TJBargainController.h"//9.9
#import "TJHomePagePopView.h"

#import "UIViewController+Extension.h"

#import "TJHomePageModel.h"
#import "TJHeadLineScrollModel.h"
#import "TJGoodsCollectModel.h"
#import "TJAdWebController.h"
#import "TJHeadDetailController.h"


#define AD_H  200
#define Cloumns_H  165
#define News_H  45
#define Class_H  260
#define TabAd_H  110


#define LEFTBTN  451561
#define RIGHTBTN  556148
#define Big_Scroll  7368
#define AD_Scroll  6554
#define NEWS_Scroll  9556
#define CLASSS_CollectionV  569845
#define Columns_CollectionV 475525
@interface TJHomePageController ()<TJButtonDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource,SDCycleScrollViewDelegate,PopViewClickDelgate>

{
    CGFloat _currentAlpha;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer_news;
@property (nonatomic,assign) NSInteger currentIndex;/* 当前滑动到了哪个位置**/

@property (nonatomic, strong) NSDictionary *homePageData;
@property (nonatomic, strong) NSMutableArray *imgADArr;
@property (nonatomic, strong) NSMutableArray *imgDataArr;
@property (nonatomic, strong) NSArray *menuArr;
@property (nonatomic, strong) NSArray *class_TopArr;
@property (nonatomic, strong) NSArray *class_bottomArr;
@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, strong) NSMutableArray *adSmallImgArr;

@property (nonatomic, strong) NSMutableArray *goodsArr;
@property (nonatomic, strong) UIScrollView *big_ScrollView;
@property (nonatomic, strong) GYRollingNoticeView *news_scrollView;
@property (nonatomic, strong) TJHomePagePopView *popview;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *hotSearchArr;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) TJHomePageModel *ad_m;


@property (nonatomic, assign) NSInteger page;
@end

@implementation TJHomePageController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNaviBarAlpha:0];

    if (self.menuArr.count>0) {
        [self.news_scrollView reloadDataAndStartRoll];
    }
    
    if (@available(iOS 11.0, *)) {
        self.big_ScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.big_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self setNavBarBgAlpha:@"1"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]}];
//        [self resetSystemNavibar];
}

- (void)dealloc{
    [self.news_scrollView stopRoll];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgation];

    self.page = 1;
    self.view.backgroundColor = RGB(245, 245, 245);
    UIScrollView * big_ScrollVie = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-49)];
    big_ScrollVie.delegate = self;
    big_ScrollVie.showsVerticalScrollIndicator = NO;
    big_ScrollVie.showsHorizontalScrollIndicator = NO;
    big_ScrollVie.tag = Big_Scroll;
    [self.view addSubview:big_ScrollVie];
    self.big_ScrollView = big_ScrollVie;

    WeakSelf
    
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf requestSearchGoodsList];

        [weakSelf requestHomePage];
        [weakSelf requestHomePageGoodsJingXuan];
    }];
    NSMutableArray * temp = [NSMutableArray array];
    for (int i =1; i<20; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [temp addObject:image];
    }
    [header setImages:@[[UIImage imageNamed:@"1"]] forState:MJRefreshStateIdle];
    [header setImages:temp forState:MJRefreshStatePulling];
    [header setImages:temp duration:temp.count*0.025 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.big_ScrollView.mj_header = header;
    [self.big_ScrollView.mj_header beginRefreshing];
    MJRefreshAutoStateFooter * footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
                [weakSelf requestHomePageGoodsMoreJingXuan];
    }];
    [footer setTitle:@"我们是有底线的" forState:MJRefreshStateNoMoreData];
    self.big_ScrollView.mj_footer = footer;
    
}
- (void)layoutAllView{
    if (!self.news_scrollView) {
        [self setADScrollView];[self setNewsScroll];
        [self setColumnsCollectView];[self setClassCollectionView];
        [self setBottomAdImg];[self setBottomTableView];
    }
    
}

- (void)setPopView{
    
    
    //showalert之前进行 一天一次判断
//    NSDate *now = [NSDate date];
//    NSDate *agoDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"nowDate"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *ageDateString = [dateFormatter stringFromDate:agoDate];
//    NSString *nowDateString = [dateFormatter stringFromDate:now];
//    NSLog(@"日期比较：之前：%@ 现在：%@",ageDateString,nowDateString);
//    if ([ageDateString isEqualToString:nowDateString]) {
//        NSLog(@"一天就显示一次");
//    }else{
//        //记录弹窗时间
//        NSDate *nowDate = [NSDate date];
//        NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
//        [dataUser setObject:nowDate forKey:@"nowDate"];
//        [dataUser synchronize];
//
//        if ([self.status intValue]==1) {
            DSLog(@"弹窗00");
        if (!self.popview) {
            TJHomePagePopView *popview = [TJHomePagePopView invitationView];
            popview.frame = S_F;popview.delegate = self;
            popview.backgroundColor = RGBA(1, 1, 1, 0.2);
            popview.model = self.ad_m;
            [self.view addSubview:popview];
            self.popview = popview;
        }
    
    

//        }
//    }
}
- (void)tapClick{
    DSLog(@"ddddddddddddddddd");
    
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
        [TJPublicURL goAnyViewController:self withidentif:self.ad_m.flag withParam:nil];
        
    }else{
        TJLoginController * lvc = [[TJLoginController alloc]init];
        [TJAppManager sharedTJAppManager].loginVC = lvc;
        [self presentViewController:lvc animated:NO completion:nil];
    }
}

- (void)requestSearchGoodsList{
    if (!self.hotSearchArr) {
        self.hotSearchArr = [NSArray array];
        WeakSelf
        [KConnectWorking requestNormalDataParam:nil withRequestURL:SearchGoods withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
            weakSelf.hotSearchArr = responseObject[@"data"][@"hot"];
            DSLog(@"====%@",responseObject);
        } withFailure:^(NSError * _Nullable error) {
            DSLog(@"====err%@",error);
            
        }];
    }
   
}

- (void)requestHomePage{
    //首页
    self.imgADArr = [NSMutableArray array];self.imgDataArr = [NSMutableArray array];
    self.menuArr = [NSArray array];
    self.adSmallImgArr = [NSMutableArray array];
    self.newsArr = [NSMutableArray array];
    WeakSelf
    
    [KConnectWorking requestNormalDataParam:nil withRequestURL:HomePages withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        NSDictionary *dataDict = responseObject[@"data"];self.homePageData = dataDict;
//        DSLog(@"-shoye ----%@",responseObject);
        if (dataDict.count>0) {
            NSArray *imgArr = [TJHomePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"slides"]];
            weakSelf.menuArr = [TJHomePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"menu"]];
            weakSelf.newsArr = [TJHeadLineScrollModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"toutiao"]];
            
            for (int i = 0; i < imgArr.count; i++) {
                TJHomePageModel *model = imgArr[i];
                [weakSelf.imgADArr addObject:model.imgurl];
                [weakSelf.imgDataArr addObject:model];
            }
            
            weakSelf.status = responseObject[@"data"][@"pop"][@"status"];
            weakSelf.ad_m  = [TJHomePageModel mj_objectWithKeyValues:responseObject[@"data"][@"pop"][@"info"]];
            
            NSArray *arr = responseObject[@"data"][@"block"];
            NSDictionary *dict = arr[0];NSDictionary *dict2 = arr[1];
            NSArray *menu1Arr = dict[@"menu"];NSArray *menu2Arr = dict2[@"menu"];
            if (menu1Arr.count>0) {
                weakSelf.class_TopArr = [TJHomePageModel mj_objectArrayWithKeyValuesArray:dict[@"menu"]];
            }if (menu2Arr.count>0) {
                weakSelf.class_bottomArr = [TJHomePageModel mj_objectArrayWithKeyValuesArray:dict2[@"menu"]];
            }
            weakSelf.adSmallImgArr  = [TJHomePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"ad_block_foot"]];
            [weakSelf setPopView];
            
//            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf layoutAllView];
                [weakSelf.news_scrollView reloadDataAndStartRoll];
                
//            });
            
        }
    } withFailure:^(NSError * _Nullable error) {
        [SVProgressHUD showInfoWithStatus:@"没有网络啦~"];
        [weakSelf.big_ScrollView.mj_header endRefreshing];
    }];
    
}
- (void)requestHomePageGoodsJingXuan{
//    精选
    self.page = 1;
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    WeakSelf
    self.goodsArr = [NSMutableArray array];
    NSDictionary *param  = @{@"page":pag,@"page_num":@"10",};
    [KConnectWorking requestNormalDataParam:param withRequestURL:HomePageGoods withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [weakSelf.big_ScrollView.mj_header endRefreshing];
        weakSelf.goodsArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
//        DSLog(@"--success---%@",responseObject);
            weakSelf.tableView.py_height = self.goodsArr.count*160;
            [weakSelf.tableView reloadData];
            weakSelf.big_ScrollView.contentSize = CGSizeMake(0, AD_H+Cloumns_H+News_H+Class_H+TabAd_H+75+weakSelf.goodsArr.count*160);

        weakSelf.page++;
    } withFailure:^(NSError * _Nullable error) {
        [weakSelf.big_ScrollView.mj_header endRefreshing];
    }];
    
}
- (void)requestHomePageGoodsMoreJingXuan{
    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];

    NSDictionary *param  = @{@"page":pag,@"page_num":@"10",};
    [KConnectWorking requestNormalDataParam:param withRequestURL:HomePageGoods withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [weakSelf.big_ScrollView.mj_footer endRefreshing];

        NSArray *array = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        if (array.count==0) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.goodsArr addObjectsFromArray:array];
            weakSelf.tableView.py_height = self.goodsArr.count*160;
            [weakSelf.tableView reloadData];
            weakSelf.big_ScrollView.contentSize = CGSizeMake(0, AD_H+Cloumns_H+News_H+Class_H+TabAd_H+75+weakSelf.goodsArr.count*160);
            weakSelf.page++;
        }
       
    } withFailure:^(NSError * _Nullable error) {
        [weakSelf.big_ScrollView.mj_header endRefreshing];
    }];
}


- (void)setNavgation{

//    左边按钮
    TJButton *button_left = [[TJButton alloc]initDelegate:self backColor:nil tag:LEFTBTN withBackImage:@"sign" withSelectImage:nil];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_left];
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:RIGHTBTN withBackImage:@"notice" withSelectImage:nil];
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
//    搜索
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,S_W-100, 30)];
    midView.backgroundColor = [UIColor whiteColor];
    midView.layer.cornerRadius = 15;
    midView.layer.masksToBounds = YES;
    UISearchBar *searchB = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, S_W-100, 30)];
    searchB.delegate = self;
    searchB.placeholder = @"新品女装";
    searchB.searchBarStyle = UISearchBarStyleDefault;
    [midView addSubview:searchB];
    self.navigationItem.titleView = midView;
    
}

- (void)setADScrollView{
  
//    广告滑动
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, S_W, AD_H) delegate:self placeholderImage:[UIImage imageNamed:@"ad_img"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = KALLRGB; // 自定义分页控件小圆标颜色
    cycleScrollView2.pageDotColor = RGB(110, 110, 110);
    [self.big_ScrollView addSubview:cycleScrollView2];
        cycleScrollView2.imageURLStringsGroup = self.imgADArr;
}

- (void)setColumnsCollectView{
//    分栏
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    layou.sectionInset = UIEdgeInsetsMake(18, 10, 10, 10);
    layou.itemSize = CGSizeMake((S_W-100)/5, 50);
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, AD_H, S_W, Cloumns_H) collectionViewLayout:layou];
    collectV.scrollEnabled = NO;
    collectV.backgroundColor = [UIColor whiteColor];
    collectV.tag = Columns_CollectionV;
    collectV.delegate = self;
    collectV.dataSource = self;
    [collectV registerClass:[TJHPMidCollectCell class] forCellWithReuseIdentifier:@"MidCell"];
    [self.big_ScrollView addSubview:collectV];
}

- (void)setNewsScroll{
//TODO:    新闻滚动条
    UIView *news = [[UIView alloc]initWithFrame:CGRectMake(0,AD_H+Cloumns_H, S_W, News_H)];
    news.backgroundColor = [UIColor whiteColor];
    [self.big_ScrollView addSubview:news];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 60, 20)];
    img.image = [UIImage imageNamed:@"headLine_img"];
    [news addSubview:img];
//    SGAdvertScrollView *newsScroll = [[SGAdvertScrollView alloc]initWithFrame:CGRectMake(50, 0, S_W-50, 35)];
    
    GYRollingNoticeView *newsScroll = [[GYRollingNoticeView alloc]initWithFrame:CGRectMake(80, 8, S_W-80, 35)];
    [newsScroll registerNib:[UINib nibWithNibName:@"TJHeadLineCustomCell" bundle:nil] forCellReuseIdentifier:@"HeadLineCustomCell"];
    newsScroll.delegate = self;
    newsScroll.dataSource = self;
    newsScroll.backgroundColor = [UIColor whiteColor];
    [news addSubview:newsScroll];
    self.news_scrollView = newsScroll;

}

#pragma mark - 模块分类
-(void)setClassCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, AD_H+Cloumns_H+News_H+10, S_W, Class_H) collectionViewLayout:layout];
    collectionV.backgroundColor = RGB(245, 245, 245);
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.scrollEnabled = NO;
    collectionV.tag = CLASSS_CollectionV;
    [collectionV registerNib:[UINib nibWithNibName:@"TJClassOneCell" bundle:nil] forCellWithReuseIdentifier:@"ClassOneCell"];
    [collectionV registerNib:[UINib nibWithNibName:@"TJClassTwoCell" bundle:nil] forCellWithReuseIdentifier:@"ClassTwoCell"];
    [self.big_ScrollView addSubview:collectionV];
}
- (void)setBottomAdImg{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, AD_H+Cloumns_H+News_H+Class_H+10, S_W, TabAd_H)];
    img.backgroundColor =RandomColor;
    TJHomePageModel *model = self.adSmallImgArr[0];
    [img sd_setImageWithURL: [NSURL URLWithString:model.imgurl]];
    [self.big_ScrollView addSubview:img];
    
    
}
- (void)setBottomTableView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, AD_H+Cloumns_H+News_H+Class_H+TabAd_H+10,S_W,60)];
    view.backgroundColor = [UIColor whiteColor];
    TJLabel * titleL = [TJLabel setLabelWith:@"精选好物" font:15 color:RGB(255, 71, 119)];
    [view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
    }];
    
    UIView * left = [[UIView alloc]init];
    left.backgroundColor =RGB(255, 71, 119);
    [view addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleL);
        make.right.mas_equalTo(titleL.mas_left).offset(-10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    
    UIView * right = [[UIView alloc]init];
    right.backgroundColor =RGB(255, 71, 119);
    [view addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.centerY.mas_equalTo(left);
        make.left.mas_equalTo(titleL.mas_right).offset(10);
    }];
    [self.big_ScrollView addSubview:view];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AD_H+Cloumns_H+News_H+Class_H+TabAd_H+75, S_W, self.goodsArr.count*160) style:UITableViewStylePlain];
    tableView.rowHeight = 160;tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = RGBA(240, 240, 240, 1);
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.big_ScrollView addSubview:tableView];
    self.tableView = tableView;
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TJHomePageModel *m = self.imgDataArr[index];
    TJAdWebController *vc = [[TJAdWebController alloc]init];vc.url = m.flag;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - tableViewDelagte
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];

    [cell cellWithArr:self.goodsArr forIndexPath:indexPath isEditing:NO withType:@"1"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJGoodsCollectModel *model = self.goodsArr[indexPath.row];
    goodVC.gid = model.itemid;
//    goodVC.price = model.itemprice;goodVC.priceQuan = model.itemendprice;
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - search

-(void)searchClick{
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.hotSearchArr searchBarPlaceholder:@"怪味少女装" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        TJSearchController * result = [[TJSearchController alloc] init];
        result.searchText = searchText;
        [searchViewController.navigationController pushViewController:result animated:YES];
        
        // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
        for (UIView *searchbuttons in [searchBar subviews]){
            if ([searchbuttons isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton*)searchbuttons;
                // 修改文字颜色
                [cancelButton setTitleColor:RGB(151, 151, 151) forState:UIControlStateNormal];
                [cancelButton setTitleColor:RGB(151, 151, 151) forState:UIControlStateHighlighted];
                
            }
        }
    }];
  
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
   
    
//    换位置
    searchViewController.swapHotSeachWithSearchHistory = YES;
    // 4. Set delegate
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
}


#pragma mark - searchbardelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    DSLog(@"点了--");[self searchClick];
    return NO;
}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    [searchBar setShowsCancelButton:YES animated:YES];
//}
#pragma mark - btndelegte
- (void)buttonClick:(UIButton *)but{
    if (but.tag ==LEFTBTN) {
        TJHomeSignController *signV = [[TJHomeSignController alloc]init];
        [self.navigationController pushViewController:signV animated:YES];
    }else if(but.tag==RIGHTBTN){
        TJNoticeController *noticeV = [[TJNoticeController alloc]init];
        [self.navigationController pushViewController:noticeV animated:YES];
    }else{
       
    }
}

#pragma mark - gydelegate
- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView{
//    int a = ceil(self.newsArr.count/2.0);
//    return a;
    return self.newsArr.count;
}
- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    TJHeadLineCustomCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"HeadLineCustomCell"];
//    cell.backgroundColor = RandomColor;
    [cell noticeCellWithArr:self.newsArr forIndex:index];
    return cell;
}
- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    TJHeadLineScrollModel *model  = self.newsArr[index];

    TJHeadDetailController *vc  = [[TJHeadDetailController alloc]init];
    vc.aid = model.id;vc.title_art = model.title;
    [self.navigationController pushViewController:vc animated:YES];
//    TJHeadLineController *vc =[[TJHeadLineController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _big_ScrollView) {
        CGPoint point = scrollView.contentOffset;
        float alpha = point.y/SafeAreaTopHeight;
        alpha = (alpha <= 0)?0:alpha;
        alpha = (alpha >= 1)?1:alpha;
        
        _currentAlpha = alpha;
        [self setNaviBarAlpha:_currentAlpha];
    }
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    if (scrollView==_big_ScrollView) {
//        [self.news_scrollView stopRoll];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (scrollView==_big_ScrollView) {
//        [self.news_scrollView reloadDataAndStartRoll];
//    }
//}

//- (void)sc

#pragma mark - collectiondelegate
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag==CLASSS_CollectionV) {
        return 1.0;}
    return 10.0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag==CLASSS_CollectionV) {

        return 2;}
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==CLASSS_CollectionV) {
        if (section==0) {
            return 2;}
        return 4;}
    else{
        return self.menuArr.count;}
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==CLASSS_CollectionV) {
        if (indexPath.section==0) {
            return CGSizeMake((S_W-1)/2,130);
        }else{
            return CGSizeMake((S_W-3)/4,130);
        }
    }else{
        return CGSizeMake((S_W-100)/5, 60);
    }
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
      if (collectionView.tag==CLASSS_CollectionV) {
          if (indexPath.section==0) {
              TJClassOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassOneCell" forIndexPath:indexPath];
              cell.model = self.class_TopArr[indexPath.row];
                return cell;
          }else{
              TJClassTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassTwoCell" forIndexPath:indexPath];
              cell.model = self.class_bottomArr[indexPath.row];
              return cell;
          }
      }else{
//          快递代取 ，女装，男装。。。。
          TJHPMidCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MidCell" forIndexPath:indexPath];
          cell.model = self.menuArr[indexPath.row];
          return cell;
          
      }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==CLASSS_CollectionV) {
//        今日
        if (indexPath.section==0) {
            TJHomePageModel *m = self.class_TopArr[indexPath.row];
            [TJPublicURL goAnyViewController:self withidentif:m.flag withParam:m.param];

        }else{
            TJHomePageModel *m = self.class_bottomArr[indexPath.row];
            [TJPublicURL goAnyViewController:self withidentif:m.flag withParam:m.param] ;
            
        }
    }else{
//        导航模块
        
            TJHomePageModel *m = self.menuArr[indexPath.row];
            [TJPublicURL goAnyViewController:self withidentif:m.flag withParam:m.param];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIScrollView *)bigScrollView{
    if (!_big_ScrollView) {
        _big_ScrollView = [[UIScrollView alloc]init];
        _big_ScrollView.frame = CGRectMake(0, 0, S_W, S_H);
        _big_ScrollView.delegate = self;
        _big_ScrollView.showsVerticalScrollIndicator = NO;
        _big_ScrollView.showsHorizontalScrollIndicator = NO;
        _big_ScrollView.tag = Big_Scroll;
    }
    return _big_ScrollView;
}





@end
