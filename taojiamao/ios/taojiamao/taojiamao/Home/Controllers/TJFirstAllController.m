//
//  TJFirstAllController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJFirstAllController.h"
#import "TJBannerView.h"
#import "TJHomeBanner.h"
#import "TJHomeMiddleModels.h"
#import "TJMiddleModelsCell.h"
#import "TJHomeFootShowModel.h"
#import "TJHomeFootShowCell.h"
#import "TJGoodsDetailsController.h"
#import "TJMiddleClickController.h"


#define TopHeight 31*H_Scale

static NSString * const HomeMiddleModelsCell = @"HomeMiddleModelsCell";
static NSString * const HomeHomeFootShowCell = @"HomeHomeFootShowCell";

@interface TJFirstAllController ()<UITableViewDelegate,UITableViewDataSource,TJMiddleModelsCellDelegate>

@property(nonatomic,strong)UITableView * baseView;

@property(nonatomic,strong)TJBannerView * banner;
@property(nonatomic,strong)NSMutableArray * bannerData;

@property(nonatomic,strong)NSMutableArray * middleModels;

@property(nonatomic,strong)NSMutableArray * footData;
@property(nonatomic,strong)NSNumber * current;
@property(nonatomic,strong)NSNumber * total;
@property(nonatomic,assign)NSInteger page;
@end

@implementation TJFirstAllController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RandomColor;
    //banner请求
    [self requestBannerWithNetData];
    //中部模块请求
    [self requestMiddleModels];
    //底部推介请求
    self.page = 1;
    [self requestFootShowModelsWithPage:self.page];
    //baseView
    [self setBaseTableViews];
    //banner设置
    [self setBannerInit];
    
    //refresh
    [self addMjRefresh];
}
#pragma mark -setBaseTableViews
-(void)setBaseTableViews{
    self.baseView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    self.baseView.backgroundColor = RandomColor;//背景
    self.baseView.delegate = self;
    self.baseView.dataSource = self;
    self.baseView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseView registerClass:[TJMiddleModelsCell class] forCellReuseIdentifier:HomeMiddleModelsCell];
    [self.baseView registerClass:[TJHomeFootShowCell class] forCellReuseIdentifier:HomeHomeFootShowCell];
    [self.baseView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123321"];
    [self.view addSubview:self.baseView];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 5:
            return self.footData.count;
            break;
            
        default:
            return 1;
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        TJMiddleModelsCell * cell = [tableView dequeueReusableCellWithIdentifier:HomeMiddleModelsCell forIndexPath:indexPath];
        cell.dataArray = self.middleModels;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==5){
        TJHomeFootShowCell * cell = [tableView dequeueReusableCellWithIdentifier:HomeHomeFootShowCell forIndexPath:indexPath];
        DSLog(@"%lu",(unsigned long)self.footData.count);
        if (self.footData.count<=0) return cell;
        cell.model = self.footData[indexPath.row];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"123321" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"ooopppp%ld",(long)indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 162*H_Scale;
            break;
        case 5:
            return 150*H_Scale;
            break;
        default:
            return 44;
            break;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==5) {
        return [self setViewForHeaderInSectionWith:@"精选好物" withFrame:CGRectMake(0, 5, S_W, 68*H_Scale)];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==5) {
        return 68*H_Scale;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 5:
            return 0;
            break;
            
        default:
            return 5;
            break;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==5) {
        TJGoodsDetailsController * gdvc = [[TJGoodsDetailsController alloc]init];
        TJHomeFootShowModel * model =self.footData[indexPath.row];
        gdvc.model = model;
        [self.navigationController pushViewController:gdvc animated:YES];
    }
}
#pragma mark - setViewForHeaderInSection
-(UIView*)setViewForHeaderInSectionWith:(NSString*)title withFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    TJLabel * titleL = [TJLabel setLabelWith:title font:15 color:RGB(255, 71, 119)];
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
    return view;
}
#pragma mark - setbanner
-(void)setBannerInit{
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.banner = [[TJBannerView alloc] initWithFrame:CGRectMake(0, 0, S_W, 225*W_Scale)];
    
    self.banner.backgroundColor =RandomColor;
    self.banner.autoScrollTimeInterval = 2.0;
//    [self.view addSubview:self.banner];
    self.baseView.tableHeaderView = self.banner;
    
    self.banner.clickItemOperationBlock = ^(NSInteger currentIndex) {
        DSLog(@"%ld",(long)currentIndex);
    };
}
#pragma mark -requestBannerWithNetData
-(void)requestBannerWithNetData{
    NSDictionary * parm = @{};
    [XDNetworking postWithUrl:HOMEBANNER refreshRequest:YES cache:NO params:parm progressBlock:nil successBlock:^(id response) {
        NSArray * array = response[@"data"];
        [self.bannerData removeAllObjects];
        for (NSDictionary*dict in array) {
            TJHomeBanner * model = [TJHomeBanner yy_modelWithDictionary:dict];
            [self.bannerData addObject:model];
        }
        self.banner.bannerData = self.bannerData;
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
    }];
}

#pragma mark - requestMiddleModels
-(void)requestMiddleModels{
    NSDictionary * parm = @{};
    [XDNetworking postWithUrl:HOMEMiddleModule refreshRequest:YES cache:NO params:parm progressBlock:nil successBlock:^(id response) {
        [self.middleModels removeAllObjects];
        NSArray * array =response[@"data"];
        for (NSDictionary*dict in array) {
            TJHomeMiddleModels * model = [TJHomeMiddleModels yy_modelWithDictionary:dict];
            [self.middleModels addObject:model];
        }
        //section刷新
        NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:0];
        [self.baseView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
    }];
}
#pragma mark - TJMiddleModelsCellDelegate
-(void)middleModelsCollectionCellClick:(TJHomeMiddleModels *)model{
    DSLog(@"%@",model.name);
    TJMiddleClickController * mcvc = [[TJMiddleClickController alloc]init];
    mcvc.title = model.name;
    [self.navigationController pushViewController:mcvc animated:YES];
}
#pragma mark -requestFootShowModels
-(void)requestFootShowModelsWithPage:(NSInteger)page{
    //推荐表
    
}
#pragma mark - refreshSetting
-(void)addMjRefresh{
    WeakSelf
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf.footData removeAllObjects];
        weakSelf.page = 1;
        [self requestFootShowModelsWithPage:weakSelf.page];
    }];
    
    NSMutableArray * temp = [NSMutableArray array];
    for (int i =0; i<13; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i+1]];
        [temp addObject:image];
    }
    [header setImages:@[[UIImage imageNamed:@"loading1"]] forState:MJRefreshStateIdle];
    [header setImages:temp forState:MJRefreshStatePulling];
    [header setImages:temp duration:temp.count*0.04 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.baseView.mj_header =header;
    //    self.baseView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //
    //    }];
    
    MJRefreshAutoStateFooter * footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        DSLog(@"%@",self.total);
        if ([weakSelf.total integerValue]==weakSelf.page) {
            weakSelf.baseView.mj_footer.state = MJRefreshStateNoMoreData;
            return ;
        }
        weakSelf.page++;
        [self requestFootShowModelsWithPage:weakSelf.page];
    }];
    [footer setTitle:@"我们是有底线的" forState:MJRefreshStateNoMoreData];
    self.baseView.mj_footer = footer;
    
}
-(void)endRefresh{
    [self.baseView.mj_header endRefreshing];
    [self.baseView.mj_footer endRefreshing];
}
#pragma mark - getter setter
-(NSMutableArray *)bannerData{
    if (_bannerData==nil) {
        _bannerData = [NSMutableArray array];
    }
    return _bannerData;
}
-(NSMutableArray *)middleModels{
    if (_middleModels==nil) {
        _middleModels = [NSMutableArray array];
    }
    return _middleModels;
}
-(NSMutableArray *)footData{
    if (!_footData) {
        _footData = [NSMutableArray array];
    }
    return _footData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
