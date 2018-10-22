//
//  TJPersonalController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPersonalController.h"

#import "TJKdTabbarController.h"

#import "TJMembersModel.h"
#import "TJMemberMainModel.h"
#import "TJUserDataModel.h"




#import "TJMiddleView.h"
#import "TJPersonalCell.h"
#import "TJMineListCell.h"
#import "TJMineHeaderCell.h"

#import "TJCourierTakeController.h"//快递
#import "TJKdApplyAgrentController.h"//申请代理

#import "TJUserInfoController.h"//个人信息
#import "TJSettingController.h"//设置
#import "TJNoticeController.h"//通知
#import "TJLoginController.h"//登录

#import "TJVipBalanceController.h"
#import "TJVipFansController.h"
#import "TJVipPerformanceController.h"

#import "TJOrderClaimController.h"//订单认领
#import "TJAssistanceController.h"
#import "TJRankingListController.h"
#import "TJShareMoneyController.h"
#import "TJCollectController.h"//收藏
#import "TJMyAssetsController.h"
//#import "TJMineOrderController.h"//订单
#import "TJMyFootPrintController.h"//足迹
#import "TJVipBalanceController.h"//累计
#import "TJVipPerformanceController.h"//推广
#import "TJMiddleClickController.h"//热推

#import "TJInvitationView.h"


#define Setting   9999
#define Notify    6666

@interface TJPersonalController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,UICollectionViewDelegate,UICollectionViewDataSource,testTableViewCellDelegate,UITabBarControllerDelegate>

@property(nonatomic,strong)TJUserDataModel * model;

@property(nonatomic,strong)UIView * navgationView;
@property(nonatomic,strong)UILabel * navTitle;
@property(nonatomic,strong)UIImageView * headIcon;
@property(nonatomic,strong)UILabel * userName;
@property(nonatomic,strong)UILabel * halo;

@property(nonatomic,strong)UIImageView * userType;
@property(nonatomic,strong)UIView * headTView;
@property (nonatomic, strong) UIView *classView;
@property (nonatomic, strong) TJButton *btn_setting;
@property (nonatomic, strong) TJButton *btn_notice;
@property (nonatomic, strong) UIView *classV;
@property(nonatomic,strong)TJMiddleView * midView;
@property(nonatomic,strong)UIImage * iconImage;
@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) UICollectionView *topCollectView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *menuArr;

@property (nonatomic, strong) NSMutableArray *topArr;
@end

@implementation TJPersonalController


#pragma mark -lazy loading
-(UIView *)headTView{
    if (!_headTView) {
        _headTView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 182)];
        _headTView.backgroundColor = KALLRGB;
    }
    return _headTView;
}


-(UIView *)navgationView{
    if (_navgationView==nil) {
        _navgationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, SafeAreaTopHeight)];
        _navgationView.backgroundColor = RandomColor;
    }
    return _navgationView;
}
-(UIImageView *)headIcon{
//    头像
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc]init];
        _headIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(intoInfoSetting)];
        [_headIcon addGestureRecognizer:tap];
    }
    return _headIcon;
}
-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc]init];
        _userName.text = @"未登录";

        _userName.font = [UIFont systemFontOfSize:19*W_Scale];
    }
    return _userName;
}
- (UILabel *)halo{
    if (!_halo) {
        _halo = [[UILabel alloc]init];
        _halo.text = @"Hi，等你好久了~";
        _halo.textColor = [UIColor whiteColor];
//        _halo.image = [UIImage imageNamed:@"vip_p"];
    }
    return _halo;
}
- (UIImageView *)userType{
    if (!_userType) {
        _userType = [[UIImageView alloc]init];
//        _userType
    }
    return _userType;
}
- (UITableView *)tableV{
    if (_tableV==nil) {
        CGFloat fushu = SafeAreaTopHeight==88?-44:-20;
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,fushu, S_W, S_H) style:UITableViewStyleGrouped];
        _tableV.backgroundColor =RGB(245, 245, 245);
        _tableV.delegate = self;
        _tableV.dataSource =self;
        _tableV.sectionHeaderHeight = 0.00;
        _tableV.tableFooterView = [[UIView alloc]init];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableV registerClass:[TJMineListCell class] forCellReuseIdentifier:@"mineCell"];
   }
    return _tableV;
}
#pragma mark -viewDidLoad
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    DSLog(@"----top==%f",self.tableV.contentOffset.y);
    if (self.tableV.contentOffset.y==-20) {
        
    }else{
        [self.tableV setContentOffset:CGPointMake(0, -20)];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestMemebersInfo];
    if (self.topArr.count>0) {
    }else{
        [self requestMemebersData];
    }
    
}

-(void)requestMemebersInfo{

    self.navBarBgAlpha = @"1.0";
    self.isblack = NO;
    WeakSelf
    NSString *userid = GetUserDefaults(UID);
        if (userid) {}else{userid = @"";}
    if (userid) {
        self.hadLogin = YES;
        
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = LoginedUserData;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodGET;
        } onSuccess:^(id  _Nullable responseObject) {
            NSLog(@"----user-success-===%@",responseObject);
            NSDictionary * data = responseObject[@"data"];
            SetUserDefaults(data[@"balance"], Balance);

            weakSelf.model = [TJUserDataModel yy_modelWithDictionary:responseObject[@"data"]];
            [TJAppManager sharedTJAppManager].userData = weakSelf.model;
            
            
                weakSelf.userName.text = weakSelf.model.nickname;
                if ([weakSelf.model.level intValue]==0) {
                    weakSelf.userType.image =[UIImage imageNamed:@"vip_p"];
                }else if ([weakSelf.model.level intValue]==1){
                    weakSelf.userType.image =[UIImage imageNamed:@"vip_t"];
                    
                }else if ([weakSelf.model.level intValue]==2){
                    weakSelf.userType.image =[UIImage imageNamed:@"vip_y"];
                    
                }else{ weakSelf.userType.image =[UIImage imageNamed:@"vip_j"];
                }
                [weakSelf setHeadTView];// 加还是不加
                weakSelf.tableV.tableHeaderView = weakSelf.headTView;
                [weakSelf.topCollectView reloadData];
                [weakSelf.tableV reloadData];
           
            
            
        } onFailure:^(NSError * _Nullable error) {
            weakSelf.hadLogin = NO;
        
                [weakSelf setHeadTView];
                weakSelf.tableV.tableHeaderView =  weakSelf.headTView;
                [weakSelf.tableV reloadData];
           
            
        }];
        
    }else{
        self.hadLogin = NO;
        self.model = nil;
        self.tableV.tableHeaderView =  self.headTView;
        [self.tableV reloadData];
        DSLog(@"未登录");
    }
}
- (void)requestMemebersData
{
    self.topArr = [NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    self.menuArr = [NSMutableArray array];

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
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = MembersCenter;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
//        DSLog(@"--个人中心--%@",responseObject);
        
            self.topArr = [TJMembersModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"top"]];
            for (NSDictionary *dict in responseObject[@"data"][@"main"]) {
                [self.titleArr addObject:dict[@"name"]];
                
            }
            
            self.menuArr = [TJMemberMainModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"main"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.topCollectView reloadData];
                [self.tableV reloadData];
            });
        
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];

}
/**
 <#Description#>
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.navgationView.alpha = 0;
    self.view.backgroundColor = RGB(245, 245, 245);
    
    [self setCustomNavgation];
//    [self setHeadTView];
    [self.view addSubview:self.tableV];
    

}
-(void)setHeadTView{
    WeakSelf
//    头像
    [self.headTView addSubview:self.headIcon];
    [weakSelf.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(75);
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(53);
    }];
    if (self.hadLogin) {
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:self.model.image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                [image lb_cornerImageWithSize:CGSizeMake(70*W_Scale, 70*W_Scale) cornerRadius:70*W_Scale completed:^(UIImage *image) {
                    weakSelf.headIcon.image = image;
                    weakSelf.iconImage = image;
                }];
                
            }else{
                UIImage * imageError  = [UIImage imageNamed:@"morentouxiang"];
                [imageError lb_cornerImageWithSize:CGSizeMake(70*W_Scale, 70*W_Scale) cornerRadius:70*W_Scale completed:^(UIImage *image) {
                    weakSelf.headIcon.image = image;
                    weakSelf.iconImage = image;
                }];
            }
        }];
    }else{
        UIImage * image  = [UIImage imageNamed:@"morentouxiang"];
        [image lb_cornerImageWithSize:CGSizeMake(70*W_Scale, 70*W_Scale) cornerRadius:70*W_Scale completed:^(UIImage *image) {
            weakSelf.headIcon.image = image;
            weakSelf.iconImage = image;
        }];
    }
//    昵称
    [self.headTView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headIcon.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.headIcon.mas_top).offset(13);
        
    }];
//    NSLog(@"----nickname--%@",self.model.nickname);
    NSString *str;
    if (self.model.nickname) {
         str = self.model.nickname;
    }else{
         str = @"暂未设置昵称";
    }
    
    self.userName.text = self.hadLogin?str:@"未登录";


    if (self.hadLogin) {
        //    会员类型
       
        self.halo.hidden = YES;self.userType.hidden=NO;
        [self.headTView addSubview:self.userType];

        [self.userType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.userName.mas_bottom).offset(14);
            make.left.mas_equalTo(weakSelf.headIcon.mas_right).offset(15);
        }];
    }else{
        //    halo
        self.userType.hidden = YES;self.halo.hidden=NO;
        [self.headTView addSubview:self.halo];
        [self.halo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.userName.mas_bottom).offset(14);
            make.left.mas_equalTo(weakSelf.headIcon.mas_right).offset(15);
        }];
    }
    self.userName.font = [UIFont systemFontOfSize:19];
    self.userName.textColor  = [UIColor whiteColor];
    
    
// 芬兰
    if (!self.classV) {
        self.classV = [[UIView alloc]init];
        self.classV.frame = CGRectMake(15, 145, S_W-30, 72);
        self.classV.layer.cornerRadius = 8;
        self.classV.layer.masksToBounds = YES;
        self.classV.backgroundColor = [UIColor whiteColor];
        [self.headTView addSubview:self.classV];
        
        UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
        layou.sectionInset = UIEdgeInsetsMake(10, 30, 10, 28);
        //    layou.itemSize = CGSizeMake((S_W-200-30)/4, 50);
        UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.classV.bounds.size.width, 72) collectionViewLayout:layou];
        collectV.backgroundColor = [UIColor whiteColor];
        //    collectV.tag = Columns_CollectionV;
        
        collectV.delegate = self;
        collectV.dataSource = self;
        [collectV registerClass:[TJMineHeaderCell class] forCellWithReuseIdentifier:@"MineheadCell"];
        [self.classV addSubview:collectV];
        self.topCollectView = collectV;
    }
    
//    设置。通知
    if (!self.btn_notice) {
        self.btn_setting = [[TJButton alloc]initDelegate:self backColor:[UIColor clearColor] tag:Setting withBackImage:@"setting" withSelectImage:nil];
        self.btn_notice = [[TJButton alloc]initDelegate:self backColor:[UIColor clearColor] tag:Notify withBackImage:@"notice" withSelectImage:nil];
        [self.headTView addSubview:self.btn_notice];
        [self.headTView addSubview:self.btn_setting];
        
        [self.btn_notice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.right.mas_equalTo(-16*W_Scale);
            make.width.height.mas_equalTo(21);
        }];
        
        [self.btn_setting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.height.mas_equalTo(weakSelf.btn_notice);
            make.right.mas_equalTo(weakSelf.btn_notice.mas_left).offset(-16*W_Scale);
        }];
    }
    
    [self.view addSubview:self.headTView];
}
//#pragma mark - collectionView
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
   
    return 29.0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
            return self.topArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
        return CGSizeMake((S_W-200)/4, 50);
  
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
        TJMineHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineheadCell" forIndexPath:indexPath];
        cell.model = self.topArr[indexPath.row];
        return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TJMembersModel *m = self.topArr[indexPath.row];
    DSLog(@"---w-%@==%@",m.flag,m.param);
    [TJPublicURL goAnyViewController:self withidentif:m.flag withParam:m.param];
    
}
#pragma mark - TJButtonDelegate
-(void)buttonClick:(UIButton *)but{
    if (but.tag==Setting) {
        TJSettingController * setvc = [[TJSettingController alloc]init];
        setvc.phone = self.model.telephone;setvc.nickname = self.model.nickname;
        setvc.imgurl = self.model.image;
        [self.navigationController pushViewController:setvc animated:YES];
    }else{
        TJNoticeController *vc = [[TJNoticeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)intoInfoSetting{
    NSLog(@"---%@--logn",self.hadLogin?@"YES":@"NO");
    if (self.hadLogin==YES) {
        TJUserInfoController * uivc = [[TJUserInfoController alloc]init];
        uivc.iconImage = self.iconImage;
        uivc.nickName = self.model.nickname.length>0?self.model.nickname:@"赶紧设置昵称吧~";
        [self.navigationController pushViewController:uivc animated:YES];
    }else{
//        登录
        TJLoginController * lvc = [[TJLoginController alloc]init];
        [TJAppManager sharedTJAppManager].loginVC = lvc;
        [self presentViewController:lvc animated:NO completion:nil];
    }
   
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<0) {
        self.navgationView.alpha = 0;
    }else {
        CGFloat alpha=1-((SafeAreaTopHeight-offset)/SafeAreaTopHeight);
        self.navgationView.alpha=alpha;
    }
}
#pragma mark - setCustomNavgation
-(void)setCustomNavgation{
    [self.view addSubview:self.navgationView];
    self.navTitle= [self setLabelWith:@"个人中心" font:17*W_Scale color:[UIColor whiteColor]];
    [self.navgationView addSubview:self.navTitle];
    WeakSelf
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.navgationView);
        make.bottom.mas_equalTo(weakSelf.navgationView.mas_bottom).offset(-10);
    }];
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    if (text&&text.length>0) {
        label.text = text;
    }else{
        label.text = @"0.00";
    }
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 35;
    }else if (indexPath.section==3){
        TJMemberMainModel *model = self.menuArr[indexPath.section-1];
        NSArray *arr = model.menu;
        NSInteger i = ceilf(arr.count/4.0);
        return i*70+55;
    }
        return 115;

}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TJMineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    cell.mineCellDelegate = self;
    cell.indexSection = indexPath.section;
    if (indexPath.section==0) {
        cell.backgroundColor = RGB(245, 245, 245);
        cell.contentView.hidden = YES;
    }else{
        NSInteger i = indexPath.section-1;
        TJMemberMainModel *model = self.menuArr[i];
        [cell cellHeaderTitle:self.titleArr[i] withArr:model];
        
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count+1;
}


- (void)collectionCell:(TJMineListCell *)cell didSelectItemIndexPath:(NSIndexPath *)indexPath{
    
    if (cell.indexSection==0) {
        
    }else{
        NSInteger i = cell.indexSection-1;
        TJMemberMainModel *model = self.menuArr[i];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:model.menu];
        NSArray *arrmodel = [TJMembersModel mj_objectArrayWithKeyValuesArray:arr];
        TJMembersModel *model_m = arrmodel[indexPath.row];
        DSLog(@"====%ld---%@",indexPath.row,model_m.flag);
        [TJPublicURL goAnyViewController:self withidentif:model_m.flag withParam:model_m.param];
    }
//
}

#pragma mark - tabbarController delagte
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    UIViewController *vc = [tabBarController.viewControllers objectAtIndex:1];
//    if (viewController == vc) {
//        DSLog(@"刷新-------vc===");
//        return NO;
//    }
//    return YES;
//    
//}
@end
