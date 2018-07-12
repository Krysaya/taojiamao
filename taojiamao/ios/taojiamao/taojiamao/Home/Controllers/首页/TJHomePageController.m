
//
//  TJHomePageController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomePageController.h"
#import "TJHPMidCollectCell.h"
#import "TJClassOneCell.h"
#import "TJClassTwoCell.h"
#import "TJHomeSignController.h"
#import "TJNoticeController.h"
#import "TJHomeController.h"
#import "TJSearchController.h"
#define LEFTBTN  546146
#define RIGHTBTN  556148
#define Big_Scroll  7368
#define AD_Scroll  6554
#define NEWS_Scroll  9556
#define CLASSS_CollectionV  569845
#define Columns_CollectionV 475525
@interface TJHomePageController ()<TJButtonDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer_news;
@property (nonatomic,assign) NSInteger currentIndex;/* 当前滑动到了哪个位置**/

@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSDictionary *midArr;
@property (nonatomic, strong) UIScrollView *big_ScrollView;

@property (nonatomic, strong) UIScrollView *ad_scrollView;
@property (nonatomic, strong) UIScrollView *news_scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

//@property (nonatomic, strong) UIView *newsView;
@end

@implementation TJHomePageController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //关闭定时器
    [self.timer invalidate];
    [self.timer_news invalidate];
    //    self.timer==nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = RGB(245, 245, 245);
    UIScrollView * big_ScrollVie = [[UIScrollView alloc]init];
    big_ScrollVie.frame = S_F;
    
    big_ScrollVie.delegate = self;
    big_ScrollVie.showsVerticalScrollIndicator = NO;
    big_ScrollVie.showsHorizontalScrollIndicator = NO;
    big_ScrollVie.tag = Big_Scroll;
    [self.view addSubview:big_ScrollVie];
    self.big_ScrollView = big_ScrollVie;
    
    
    [self setupTimer];
    [self setNewsTimer];

    
    [self setNavgation];
    [self setADScrollView];
    [self setNewsScroll];
    [self setClassCollectionView];
}

- (void)setNavgation{
//    左边按钮
    TJButton *button_left = [[TJButton alloc]initDelegate:self backColor:nil tag:LEFTBTN withBackImage:@"sign"];
   
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_left];

    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:RIGHTBTN withBackImage:@"notice"];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
//    搜索
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 285, 30)];
    midView.backgroundColor = [UIColor whiteColor];
    midView.layer.cornerRadius = 15;
    midView.layer.masksToBounds = YES;
    UISearchBar *searchB = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 285, 30)];
    searchB.delegate = self;
    searchB.searchBarStyle = UISearchBarStyleDefault;
    [midView addSubview:searchB];
    self.navigationItem.titleView = midView;
    
}

- (void)setADScrollView{
    
  
//    广告滑动
    self.imgArr = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, S_W, 200)];
    [self.big_ScrollView addSubview:scrollV];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
    scrollV.tag = AD_Scroll;
    scrollV.contentSize = CGSizeMake(self.imgArr.count * S_W, 0);
    scrollV.delegate = self;
    
    for (int i = 0; i < self.imgArr.count; i++) {
        NSString * imageName = [NSString stringWithFormat:@"%d",i];
        UIImage * image = [UIImage imageNamed:imageName];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:scrollV.bounds];
        imageView.backgroundColor = RandomColor;
        imageView.image = image;
        [scrollV addSubview:imageView];
    }
    
    [scrollV.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        imageView.frame = frame;
    }];
//    self.pageControl.currentPage = 0;
    
    UIPageControl *pageC = [[UIPageControl alloc]init];
    pageC.numberOfPages = self.imgArr.count;
    pageC.frame = CGRectMake(S_W-92, scrollV.frame.origin.y+170, 80, 12);
    pageC.pageIndicatorTintColor = RGB(110, 110, 110);
    pageC.currentPageIndicatorTintColor = KALLRGB;
    pageC.currentPage = 0;
    [self.big_ScrollView addSubview:pageC];

    
    self.ad_scrollView = scrollV;
    self.pageControl = pageC;
    [self setColumnsCollectView];
}

- (void)setColumnsCollectView{
//    分栏
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    layou.sectionInset = UIEdgeInsetsMake(18, 10, 10, 10);
    layou.itemSize = CGSizeMake((S_W-100)/5, 50);
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.ad_scrollView.frame.size.height, S_W, 165) collectionViewLayout:layou];
    collectV.backgroundColor = [UIColor whiteColor];
    collectV.tag = Columns_CollectionV;

    collectV.delegate = self;
    collectV.dataSource = self;
    [collectV registerClass:[TJHPMidCollectCell class] forCellWithReuseIdentifier:@"MidCell"];
    [self.big_ScrollView addSubview:collectV];
}

- (void)setNewsScroll{
//    新闻滚动条
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 365, S_W, 55)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.big_ScrollView addSubview:bgview];
    
//    头条图
    UIImageView *img = [[UIImageView alloc]init];
    img.backgroundColor = RandomColor;
    [bgview addSubview:img];
//    WeakSelf
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(33);
        make.left.mas_equalTo(bgview.mas_left).offset(24);
        make.centerY.mas_equalTo(bgview.mas_centerY);
    }];
    
//    滚动条
    NSArray *imgA = @[@"",@"",@"",@"",@""];
    UIScrollView *newsScroll = [[UIScrollView alloc]init];
    [bgview addSubview:newsScroll];
    self.news_scrollView = newsScroll;

    

    newsScroll.showsVerticalScrollIndicator = NO;
    newsScroll.showsHorizontalScrollIndicator = NO;
    newsScroll.pagingEnabled = YES;
    newsScroll.delegate = self;
    newsScroll.tag = NEWS_Scroll;
    [newsScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgview.mas_top);
        make.left.mas_equalTo(img.mas_right).offset(13);
        make.right.mas_equalTo(bgview.mas_right);
        make.bottom.mas_equalTo(bgview.mas_bottom);
        
    }];
    NSInteger b = imgA.count;
    CGFloat a = ceilf(b/2.0);
    NSLog(@"--===上取整--%lf--%ld@==%ld",a,imgA.count,(long)b);
    
    UIView *scrollBaseView = [UIView new];
    [newsScroll addSubview:scrollBaseView];
    [scrollBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.equalTo(newsScroll.mas_width);
        make.height.equalTo(@100).priorityLow();
    }];
    
    TJButton *lastBtn;
    for (int i=0; i<a; i++) {
//        TJButton *news_btn = [[TJButton alloc]initWithFrame:CGRectMake(0, 55*i, 200, 55)];
//        news_btn.backgroundColor = [UIColor redColor];
//        NSLog(@"---newsframe---%@",NSStringFromCGRect(news_btn.frame));
//        [newsScroll addSubview:news_btn];
        TJButton *news_btn = [TJButton new];
        news_btn.backgroundColor = RandomColor;
        [scrollBaseView addSubview:news_btn];
        [news_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.top.equalTo(lastBtn.mas_bottom);
            }else
            {
                make.top.equalTo(@0);
            }
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
            make.height.equalTo(@55);
            
            if (i == a - 1) {
                make.bottom.equalTo(@0);
            }
        }];
        
        
        lastBtn = news_btn;
    }

}

- (void)setimgLab:(NSString *)imgName withLabelTitle:(NSString *)title{
    UIView *newsView = [[UIView alloc]init];
    
    UIImageView *img_lab1 = [[UIImageView alloc]init];
    img_lab1.image = [UIImage imageNamed:imgName];
    [newsView addSubview:img_lab1];
    
    UILabel *title_Lab1 = [[UILabel alloc]init];
    title_Lab1.text = title;
    title_Lab1.textColor = RGB(51, 51, 51);
    title_Lab1.font = [UIFont systemFontOfSize:13];
    [newsView addSubview:title_Lab1];
    
    [img_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(newsView.mas_centerY);
    }];
    [title_Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img_lab1.mas_right).offset(8);
        make.right.mas_equalTo(newsView.mas_right).offset(20);
        make.centerY.mas_equalTo(newsView.mas_centerY);
    }];
    
}

-(void)setClassCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 365+55+10, S_W, 260) collectionViewLayout:layout];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.tag = CLASSS_CollectionV;
    [collectionV registerNib:[UINib nibWithNibName:@"TJClassOneCell" bundle:nil] forCellWithReuseIdentifier:@"ClassOneCell"];
    [collectionV registerNib:[UINib nibWithNibName:@"TJClassTwoCell" bundle:nil] forCellWithReuseIdentifier:@"ClassTwoCell"];
    [self.big_ScrollView addSubview:collectionV];
}
#pragma mark - search

-(void)searchClick{
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"怪味少女装" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        TJSearchController * result = [[TJSearchController alloc] init];
        result.searchText = searchText;

        [searchViewController.navigationController pushViewController:result animated:YES];
    }];
    // 3. Set style for popular search and search history
 
//    searchViewController.searchTextField.backgroundColor = RGB(240, 240, 240);
//    UIButton *btn = [[UIButton alloc]init];
//    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btn setTitle:@"搜索" forState:UIControlStateNormal];
//    
//    [searchViewController setCancelButton:[[UIBarButtonItem alloc]initWithCustomView:btn]];
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
    NSLog(@"点了--");[self searchClick];
    return NO;
}
#pragma mark - btndelegte
- (void)buttonClick:(UIButton *)but{
    if (but.tag ==LEFTBTN) {
        TJHomeSignController *signV = [[TJHomeSignController alloc]init];
        [self.navigationController pushViewController:signV animated:YES];
    }else{
        TJNoticeController *noticeV = [[TJNoticeController alloc]init];
        [self.navigationController pushViewController:noticeV animated:YES];
    }
}

#pragma make - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag==AD_Scroll) {
        double page = scrollView.contentOffset.x / scrollView.bounds.size.width;
        
        self.pageControl.currentPage = page;
    }else if (scrollView.tag == NEWS_Scroll){
      
        
        
    }else{
        
    }
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.tag==AD_Scroll) {
        [self.timer invalidate];}else if (scrollView.tag == NEWS_Scroll){
            [self.timer_news invalidate];
        }else{
            
        }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag==AD_Scroll) {
        [self setupTimer];}else if (scrollView.tag == NEWS_Scroll){
            [self setNewsTimer];
        }else{
            
        }
}
//- (void)scrollViewDidScroll:(UIScrollView *)sender
//
//{
//
//    NSInteger index = (_scrollView.contentOffset.x/CGRectGetWidth(_scrollView.frame));
//
//    index -- ;
//
//    _bannerPageControl.currentPage = index;
//
//}
- (void)setNewsTimer{
    self.timer_news =  [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerNewsChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer_news forMode:NSRunLoopCommonModes];
}
- (void)timerNewsChanged{
    //启动定时器
    CGFloat y = (self.currentIndex+1) * self.news_scrollView.bounds.size.height;
    [self.news_scrollView setContentOffset:CGPointMake(0, y) animated:YES];
    NSLog(@"%ld---news",self.currentIndex);

}
- (void)setupTimer{
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    //开启定时器
//    [self.timer fire];

}

- (void)timerChanged{
    NSInteger page = (self.pageControl.currentPage + 1) % self.imgArr.count;
    self.pageControl.currentPage = page;
    NSLog(@"%ld---ad",page);
    [self pageChanged:self.pageControl];
}
- (void)pageChanged:(UIPageControl *)pageControl{
    CGFloat x = (pageControl.currentPage) * self.ad_scrollView.bounds.size.width;
    [self.ad_scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}
#pragma mark - collectiondelegate
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag==CLASSS_CollectionV) {
        return 1.0;}
    return 10.0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==CLASSS_CollectionV) {
        if (section==0) {
            return 2;}
        return 4;}
    else{
        return 5;}
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==CLASSS_CollectionV) {
        if (indexPath.section==0) {
            return CGSizeMake((S_W-1)/2,130);
        }else{
            return CGSizeMake((S_W-3)/4,130);
        }
    }else{
        return CGSizeMake((S_W-100)/5, 50);
    }
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
      if (collectionView.tag==CLASSS_CollectionV) {
          if (indexPath.section==0) {
              TJClassOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassOneCell" forIndexPath:indexPath];
              cell.backgroundColor = RandomColor;
              return cell;
          }else{
              TJClassTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassTwoCell" forIndexPath:indexPath];
              cell.backgroundColor = RandomColor;
              return cell;
          }
      }else{
          TJHPMidCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MidCell" forIndexPath:indexPath];
          cell.imgView.image = [UIImage imageNamed:@"kddq"];
          if (indexPath.section==0) {
              cell.titleLab.text = @[@"快递代取",@"推荐好货",@"女装",@"大牌美妆",@"母婴"][indexPath.row];
          }else{
              cell.titleLab.text = @[@"男装",@"数码",@"美食",@"鞋包",@"更多"][indexPath.row];
          }
          
          return cell;}
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==CLASSS_CollectionV) {
//        今日
    }else{
//        导航模块
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 0:
//                    快递代取
                    break;
                case 1:
//                    推荐好货
                {
                    
                }
                    break;
                case 2:
//                    女装
                {
                    TJHomeController *homev = [[TJHomeController alloc]init];
                    homev.index = 1;
                    [self.navigationController pushViewController:homev animated:YES];
                }
                    
                    break;
                case 3:
//                美妆
                {
                    TJHomeController *homev = [[TJHomeController alloc]init];
                    homev.index = 5;
                    [self.navigationController pushViewController:homev animated:YES];
                }
                    break;
                default:
                    break;
            }
        }else{
            
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
