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

#import "TJCollectController.h"
#import "TJMineAssetController.h"
#import "TJMineOrderController.h"

#define Setting   9999
#define Notify    6666

@interface TJPersonalController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

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
    NSString * token = GetUserDefaults(TOKEN);
    NSString * uid = GetUserDefaults(UID);
    if (token && token.length>0 && uid && uid.length>0) {
        self.hadLogin = YES;
        NSInteger uidint = [uid integerValue];
        NSDictionary * dict = @{@"uid":@(uidint)};
        [XDNetworking postWithUrl:LoginedUserData refreshRequest:NO cache:NO params:dict progressBlock:nil successBlock:^(id response) {
            DSLog(@"%@",response);
            self.model = [TJUserDataModel yy_modelWithDictionary:response[@"data"]];
            self.tableV.tableHeaderView = self.headTView;
            [self.tableV reloadData];

        } failBlock:^(NSError *error) {
            DSLog(@"%@",error);
            self.hadLogin = NO;
//            self.listTable.tableHeaderView =  [self setHeadTView];
//            [self.listTable reloadData];
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

    // Do any additional setup after loading the view.
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
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.model.headimg]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
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
    NSString * str= self.model.nickname.length>0?self.model.nickname:@"暂未设置昵称";
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
    self.btn_setting = [[TJButton alloc]initDelegate:self backColor:[UIColor whiteColor] tag:Setting withBackImage:@"morentouxiang"];
    self.btn_notice = [[TJButton alloc]initDelegate:self backColor:[UIColor whiteColor] tag:Notify withBackImage:@"morentouxiang"];
    [self.headTView addSubview:self.btn_notice];

    [self.headTView addSubview:self.btn_setting];
    
    [self.btn_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headIcon);
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
        TJMineAssetController *assetVC = [[TJMineAssetController alloc]init];
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
    }else{
        return 112*W_Scale;

    }

}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10.0*H_Scale;//设置section间距
//}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TJMineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
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
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    select
}



@end
