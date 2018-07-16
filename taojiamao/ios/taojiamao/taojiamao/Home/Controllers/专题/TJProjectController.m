
//
//  TJProjectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJProjectController.h"
#import "TJGoodsListCell.h"
#import "SJAttributeWorker.h"

@interface TJProjectController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TJProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
     _dataArr = @[].mutableCopy;
    self.title = @"优质鲜果";
    [self setupTimer];

    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 150;
    tableView.tableFooterView = [UIView new];
    
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
}

#pragma mark = delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    NSAttributedString *str = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insertImage([UIImage imageNamed:@"tb_bs"], 0, CGPointMake(0, 0), CGSizeMake(27, 13));
        make.insertText(@" 淘米瑞春秋装新款套头圆领女士豹纹卫衣粉红宽松韩版的可能花费...", 1);
    });
    cell.titleLab.attributedText = str;
    [cell cellWithArr:nil forIndexPath:indexPath isEditing:NO];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]init];
//    ad
    //    广告滑动
     self.imgArr = [[NSArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, S_W, 160)];
    [bgView addSubview:scrollV];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
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
    [bgView addSubview:pageC];
    self.pageControl = pageC;
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;

}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//滚动代理
//}
#pragma mark - scroll
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
        double page = scrollView.contentOffset.x / scrollView.bounds.size.width;
        
        self.pageControl.currentPage = page;
   
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
        [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   
        [self setupTimer];
    
}

- (void)setupTimer{
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerChanged{
    NSInteger page = (self.pageControl.currentPage + 1) % self.imgArr.count;
    self.pageControl.currentPage = page;
    
    [self pageChanged:self.pageControl];
}
- (void)pageChanged:(UIPageControl *)pageControl{
    CGFloat x = (pageControl.currentPage) * self.scrollV.bounds.size.width;
    [self.scrollV setContentOffset:CGPointMake(x, 0) animated:YES];
}
@end
