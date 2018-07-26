//
//  TJPersonalController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPersonalController.h"
#import "TJUserDataModel.h"
#import "TJMiddleView.h"
#import "TJPersonalCell.h"
#import "TJMineListCell.h"
#import "TJHPMidCollectCell.h"
#import "TJMineHeaderCell.h"


#import "TJUserInfoController.h"
#import "TJSettingController.h"
#import "TJLoginController.h"

#import "TJVipBalanceController.h"
#import "TJVipFansController.h"
#import "TJVipPerformanceController.h"

#import "TJOrderClaimController.h"
#import "TJAssistanceController.h"
#import "TJRankingListController.h"
#import "TJShareMoneyController.h"
#import "TJCollectController.h"
#import "TJMyAssetsController.h"
#import "TJMineOrderController.h"
#import "TJMyFootPrintController.h"

#import "TJInvitationView.h"

#import "SGActionView.h"

#define Setting   9999
#define Notify    6666

@interface TJPersonalController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,UICollectionViewDelegate,UICollectionViewDataSource,testTableViewCellDelegate>

@property(nonatomic,strong)TJUserDataModel * model;

@property(nonatomic,strong)UIView * navgationView;
@property(nonatomic,strong)UILabel * navTitle;
@property(nonatomic,strong)UIImageView * headIcon;
@property(nonatomic,strong)UILabel * userName;
@property(nonatomic,strong)UILabel * halo;

@property(nonatomic,strong)UIImageView * userType;
@property(nonatomic,strong)UIView * headTView;

@property (nonatomic, strong) TJButton *btn_setting;
@property (nonatomic, strong) TJButton *btn_notice;
@property(nonatomic,strong)TJMiddleView * midView;
@property(nonatomic,strong)UIImage * iconImage;
@property (nonatomic, strong) UITableView *tableV;


@end

@implementation TJPersonalController


#pragma mark -lazy loading
-(UIView *)headTView{
    if (!_headTView) {
        _headTView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 182*H_Scale)];
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
        _halo.text = @"hi,等你好久了~";
        _halo.font = [UIFont systemFontOfSize:15*W_Scale];
        _halo.textColor =[UIColor whiteColor];

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
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, fushu, S_W, S_H) style:UITableViewStyleGrouped];
        _tableV.backgroundColor =RGB(245, 245, 245);
        _tableV.delegate = self;
        _tableV.dataSource =self;
        _tableV.sectionHeaderHeight = 0.00;
        //        _listTable.estimatedRowHeight = 44.0f;//预估高度
        //        _listTable.rowHeight =UITableViewAutomaticDimension;
        _tableV.tableFooterView = [[UIView alloc]init];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableV registerClass:[TJMineListCell class] forCellReuseIdentifier:@"mineCell"];
   }
    return _tableV;
}
#pragma mark -viewDidLoad
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"1.0";
    self.isblack = NO;
//    NSString * token = GetUserDefaults(TOKEN);
    NSString *userid = GetUserDefaults(UID);
    NSLog(@"=====userif=====个人=%@",userid);
//    NSString *userid = [NSString stringWithFormat:@"%@",uid];
    
    if (userid) {
        self.hadLogin = YES;
        
//        NSDictionary * dict = @{@"id":uid};
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
           
            dispatch_async(dispatch_get_main_queue(), ^{
                 self.model = [TJUserDataModel yy_modelWithDictionary:responseObject[@"data"]];
                [self setHeadTView];

                self.tableV.tableHeaderView = self.headTView;
                [self.tableV reloadData];
            });
           
        } onFailure:^(NSError * _Nullable error) {
            NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
            
            
            DSLog(@"--个人信息-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
            self.hadLogin = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setHeadTView];
                self.tableV.tableHeaderView =  self.headTView;
                [self.tableV reloadData];
            });
            
            

        }];
       
    }else{
        self.hadLogin = NO;
        self.model = nil;
        self.tableV.tableHeaderView =  self.headTView;
        [self.tableV reloadData];
        DSLog(@"未登录");
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.navgationView.alpha = 0;

    self.view.backgroundColor = RGB(245, 245, 245);
    
    [self setCustomNavgation];
    [self setHeadTView];
    [self.view addSubview:self.tableV];

}
-(void)setHeadTView{
    WeakSelf
//    头像
    [self.headTView addSubview:self.headIcon];
    [weakSelf.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(75*W_Scale);
        make.left.mas_equalTo(18*W_Scale);
        make.top.mas_equalTo(53*H_Scale);
    }];
    if (self.hadLogin) {
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.model.image]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
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
        make.left.mas_equalTo(weakSelf.headIcon.mas_right).offset(15*W_Scale);
        make.top.mas_equalTo(weakSelf.headIcon.mas_top).offset(13*H_Scale);
        
    }];
    NSLog(@"----nickname--%@",self.model.nickname);
    NSString * str= [self.model.nickname isEqual:[NSNull null]]?self.model.nickname:@"暂未设置昵称";
    self.userName.text = self.hadLogin?str:@"未登录";


    if (self.hadLogin) {
        //    会员类型
        [self.headTView addSubview:self.userType];
        
        [self.userType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.userName.mas_bottom).offset(14*H_Scale);
            make.left.mas_equalTo(weakSelf.headIcon.mas_right).offset(15*W_Scale);
            make.width.mas_equalTo(103*W_Scale);
            make.height.mas_equalTo(20*H_Scale);
        }];
    }else{
        //    halo
        [self.headTView addSubview:self.halo];
        [self.halo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.userName.mas_bottom).offset(14*H_Scale);
            make.left.mas_equalTo(weakSelf.headIcon.mas_right).offset(15*W_Scale);
        }];
    }
    self.userName.font = [UIFont systemFontOfSize:19*W_Scale];
    self.userName.textColor  = [UIColor whiteColor];
    
    
// 芬兰
    
    UIView *classView = [[UIView alloc]init];
    classView.frame = CGRectMake(15, 160, S_W-30, 72);
    classView.layer.cornerRadius = 8;
    classView.layer.masksToBounds = YES;
    classView.backgroundColor = [UIColor whiteColor];
    [self.headTView addSubview:classView];
    
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    layou.sectionInset = UIEdgeInsetsMake(10, 30, 10, 28);
//    layou.itemSize = CGSizeMake((S_W-200-30)/4, 50);
    UICollectionView *collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, classView.bounds.size.width, 72) collectionViewLayout:layou];
    collectV.backgroundColor = [UIColor whiteColor];
//    collectV.tag = Columns_CollectionV;
    
    collectV.delegate = self;
    collectV.dataSource = self;
    [collectV registerClass:[TJMineHeaderCell class] forCellWithReuseIdentifier:@"MineheadCell"];
    [classView addSubview:collectV];
    
//    设置。通知
    self.btn_setting = [[TJButton alloc]initDelegate:self backColor:[UIColor clearColor] tag:Setting withBackImage:@"morentouxiang"];
    self.btn_notice = [[TJButton alloc]initDelegate:self backColor:[UIColor clearColor] tag:Notify withBackImage:@"notice"];
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
            return 4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
        return CGSizeMake((S_W-200)/4, 50);
  
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
        TJHPMidCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineheadCell" forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:@"balance_detail"];
        cell.titleLab.text = @[@"我的资产",@"我的订单",@"我的收藏",@"我的足迹"][indexPath.row];
        return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
//        我的资产
        TJMyAssetsController *assetVC = [[TJMyAssetsController alloc]init];
        [self.navigationController pushViewController:assetVC animated:YES];
    }else if (indexPath.row==1){
//    我的订单
        TJMineOrderController *orderVC = [[TJMineOrderController alloc]init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }else if (indexPath.row==2){
//   我的收藏
        TJCollectController *collectVc = [[TJCollectController alloc]init];
        [self.navigationController pushViewController:collectVc animated:YES];
    }else{
//   我的足迹
        TJMyFootPrintController *footVC = [[TJMyFootPrintController alloc]init];
        [self.navigationController pushViewController:footVC animated:YES];
    }
    
}
#pragma mark - TJButtonDelegate
-(void)buttonClick:(UIButton *)but{
    if (but.tag==Setting) {
        TJSettingController * setvc = [[TJSettingController alloc]init];
        [self.navigationController pushViewController:setvc animated:YES];
    }else{
        DSLog(@"您尚未登录");

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
        [self presentViewController:lvc animated:YES completion:nil];
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
        return 30;
    }else if (indexPath.section==3){
        return 240;
    }
        return 112*W_Scale;

}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10.0*H_Scale;//设置section间距
//}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TJMineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
//    NSArray *img = @[@"",@"",@"",@"",nil];
    cell.indexSection = indexPath.section;
    cell.mineCellDelegate = self;
    [cell cellHeaderTitle:@[@"",@"会员权益",@"快递代取",@"常用工具"][indexPath.section] withImageArr:@[
                                                            @[],
                                                            @[@"",@"",@"",@""],
                                                            @[@"",@"",@"",@""],
                                                            @[@"",@"",@"",@"",@"",@"",@"",@"",@""],
                                                                                            ] withtitleArr:@[
                                                                         @[],                                                      @[@"累计奖金",@"我的粉丝",@"推广业绩",@"热推top"],
                                                                                                             @[@"快递代取",@"快递代取",@"快递代取",@"快递代取"],
                                                                                                             @[@"签到红包",@"订单认领",@"推淘宝订单",@"淘宝购物车",@"申请代理",@"排行榜",@"客服帮助",@"分享赚钱",@"邀请有奖"],
                                                                                                               ]];
    if (indexPath.section==0) {
        cell.backgroundColor = RGB(245, 245, 245);
        cell.contentView.hidden = YES;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (void)collectionCell:(TJMineListCell *)cell didSelectItemIndexPath:(NSIndexPath *)indexPath{
    if (cell.indexSection==1) {
        DSLog(@"==会员权益");
        switch (indexPath.row) {
            case 0:
                {
//                    累计奖金
                }
                break;
            case 1:
            {
//                    我的粉丝
            }
                break;
            case 2:
            {
//                    推广业绩
            }
                break;
            case 3:
            {
//                    热推top
            }
                break;
            default:
                break;
        }
    }else if(cell.indexSection==2){
        
    }else if (cell.indexSection==3){
        DSLog(@"常用工具");
        switch (indexPath.row) {
            case 0:
            {
//                    签到红包
                
            }
                break;
            case 1:
            {
 //                    订单认领
                DSLog(@"==订单认领");

                TJOrderClaimController *vc= [[TJOrderClaimController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                DSLog(@"==排行榜");

 //                    排行榜
                TJRankingListController *vc= [[TJRankingListController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 6:
            {
//                    客服帮助
                TJAssistanceController *vc= [[TJAssistanceController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 7:
            {
  //                    分享赚钱
                TJShareMoneyController *vc= [[TJShareMoneyController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 8:
            {
//                    邀请有奖
                TJInvitationView *iview = [TJInvitationView invitationView];
                iview.frame = CGRectMake(0, 0, S_W, S_H);
                [[UIApplication sharedApplication].keyWindow addSubview:iview];

            }
                break;
            default:
                break;
        }
    }
}


@end
