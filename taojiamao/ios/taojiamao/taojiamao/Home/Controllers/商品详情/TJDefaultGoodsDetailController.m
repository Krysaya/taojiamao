
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
#import "TJInvitationView.h"
#import "UIViewController+Extension.h"


static NSString * const GoodsDetailsTitleCell = @"GoodsDetailsTitleCell";
static NSString * const GoodsDetailsElectCell = @"GoodsDetailsElectCell";
static NSString * const GoodsDetailsLFCCell = @"GoodsDetailsLFCCell";
static NSString * const GoodsDetailsCompanyCell = @"GoodsDetailsCompanyCell";
static NSString * const GoodsDetailsImagesCell = @"GoodsDetailsImagesCell";

#define DetailsBackButton   951
#define DetailShareButton   952
#define DetailCollectButton   956

#define DetailsQuanBuyButton    999

#define DetailsBuyButton    953
#define DetailsGoTopButton  954
#define DetailsPopularize   955

@interface TJDefaultGoodsDetailController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,SDCycleScrollViewDelegate,TJBottomPopupViewDelegate,ShareBtnDelegate>

{
    CGFloat _currentAlpha;
}
@property(nonatomic,strong)TJButton * backButton;

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)SDCycleScrollView * bannerView;

@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)UIButton * shareB;
@property(nonatomic,strong)TJLabel * shareL;
@property(nonatomic,strong)UIButton * buy;
@property(nonatomic,strong)UIButton * quanbuy;
@property(nonatomic,strong)TJButton * goTop;
@property(nonatomic,strong)TJBottomPopupView * popupView;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *priceQuan;
@property (nonatomic, strong) NSString *collectStatus;
//会员不隐藏推广
@property(nonatomic,strong)TJButton *popularize;
@property(nonatomic,strong)NSArray * imageSSS;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSString *shareurl;
@end

@implementation TJDefaultGoodsDetailController
- (void)viewWillAppear:(BOOL)animated
{
    [self setNaviBarAlpha:0];

    [super viewWillAppear:animated];
    if (self.dataArr>0) {
    }else{
        [self requestGoodsInfo];
    }
}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //视图将要消失时取消隐藏
    [self setNaviBarAlpha:1];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [KConnectWorking requestNormalDataParam:@{@"id":self.gid,} withRequestURL:GoodsInfoFoot withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
         DSLog(@"---%@--足迹斤斤计较=",responseObject);
    } withFailure:^(NSError * _Nullable error) {
        
    }];
    
    [KConnectWorking requestShareUrlData:@"1" withIDStr:self.gid withSuccessBlock:^(id  _Nullable responseObject) {
        //        DSLog(@"---%@--url=",responseObject[@"data"]);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        self.shareurl = responseObject[@"data"][@"share_url"];
        //        });
    }];
}

- (void)requestGoodsInfo{
    self.dataArr = [NSMutableArray array];
    self.imageSSS = [NSArray array];

    NSDictionary *param  = @{  @"id":self.gid,};
    [KConnectWorking requestNormalDataParam:param withRequestURL:[NSString stringWithFormat:@"%@/%@",GoodsInfoList,self.gid] withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        
        DSLog(@"onSuccess详情:%@ =======",responseObject);
        if (dict.count>0) {
            TJJHSGoodsListModel *model = [TJJHSGoodsListModel mj_objectWithKeyValues:dict];
            [self.dataArr addObject:model];
            self.imageSSS = [model.taobao_image componentsSeparatedByString:@","];
            self.priceQuan = model.itemendprice;self.price = model.itemprice;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUI];
                
            });
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } withFailure:^(NSError * _Nullable error) {
        DSLog(@"ERROR详情:%@ =======",error);
        [SVProgressHUD showInfoWithStatus:@"网络错误！"];
        [self.navigationController popViewControllerAnimated:YES];

    }];
    
}
-(void)setUIgoTop{
    WeakSelf
    self.goTop = [[TJButton alloc]initDelegate:self backColor:nil tag:DetailsGoTopButton withBackImage:@"morentouxiang" withSelectImage:nil];
    [self.view addSubview:self.goTop];
    [self.goTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(weakSelf.footView.mas_top).offset(-36);
        make.width.height.mas_equalTo(25);
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
        make.height.mas_equalTo(54);
    }];
    
    self.shareB = [[UIButton alloc]init];self.shareB.tag = DetailCollectButton;
    [self.shareB setImage:[UIImage imageNamed:@"collection_default"] forState:UIControlStateNormal];
    [self.shareB setImage:[UIImage imageNamed:@"collection_light"] forState:UIControlStateSelected];
    [self.shareB addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    TJJHSGoodsListModel *m = [self.dataArr objectAtIndex:0];
    if ([m.is_collect intValue]==0) {
        self.shareB.selected = NO;
    }else{
        self.shareB.selected = YES;
    }
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
        make.top.mas_equalTo(weakSelf.shareB.mas_bottom).offset(6);
    }];
    
    NSString *buy = [NSString stringWithFormat:@"¥%@\n不领券",self.price];
    self.buy =  [[UIButton alloc]init];[self.buy addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buy.titleLabel.lineBreakMode = 0;
    [self.buy setTitle:buy forState:UIControlStateNormal];
    [self.buy setBackgroundImage:[UIImage imageNamed:@"left_btn_bg"] forState:UIControlStateNormal];
    self.buy.tag = DetailsBuyButton;
    [self.footView addSubview:self.buy];
    [self.buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.shareL.mas_right).offset(31);
        make.width.mas_equalTo((S_W-81)/2);
        make.bottom.mas_equalTo(weakSelf.footView);
        make.top.mas_equalTo(weakSelf.footView);
    }];
    
    NSString *quan = [NSString stringWithFormat:@"¥%@\n领券购买",self.priceQuan];
    self.quanbuy =  [[UIButton alloc]init];[self.quanbuy addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.quanbuy.titleLabel.lineBreakMode = 0;
    [self.quanbuy setTitle:quan forState:UIControlStateNormal];
    [self.quanbuy setBackgroundImage:[UIImage imageNamed:@"right_btn_bg"] forState:UIControlStateNormal];
    self.quanbuy.tag = DetailsQuanBuyButton;
    [self.footView addSubview:self.quanbuy];
    [self.quanbuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.buy.mas_right);
        make.right.mas_equalTo(weakSelf.footView);
        make.bottom.mas_equalTo(weakSelf.footView);
        make.top.mas_equalTo(weakSelf.footView);
    }];
    
}

-(void)setBackButton{
    CGFloat TOP = 20;
    self.backButton = [[TJButton alloc]initDelegate:self backColor:RGBA(1, 1, 1, 0.25) tag:DetailsBackButton withBackImage:@"back_left" withSelectImage:nil];
    self.backButton.layer.cornerRadius = 17;
    self.backButton.layer.masksToBounds = YES;
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9);
        make.top.mas_equalTo(TOP);
        make.width.height.mas_equalTo(32);
    }];
//    DetailShareButton
     TJButton *shareButton = [[TJButton alloc]initDelegate:self backColor:RGBA(1, 1, 1, 0.2) tag:DetailShareButton withBackImage:@"share" withSelectImage:nil];
    shareButton.layer.cornerRadius = 17;
    shareButton.layer.masksToBounds = YES;
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-9);
        make.top.mas_equalTo(TOP);
        make.width.height.mas_equalTo(32);
    }];
}

-(void)setUI{
    CGFloat fushu = SafeAreaTopHeight==88?-44:-20;

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,fushu, S_W, S_H-34) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJDafultGoodsTitlesCell" bundle:nil] forCellReuseIdentifier:GoodsDetailsTitleCell];
    [self.tableView registerClass:[TJGoodsDetailsElectCell class] forCellReuseIdentifier:GoodsDetailsElectCell];
    [self.tableView registerClass:[TJGoodsDetailsLFCCell class] forCellReuseIdentifier:GoodsDetailsLFCCell];
    [self.tableView registerClass:[TJGoodsDetailsCompanyCell class] forCellReuseIdentifier:GoodsDetailsCompanyCell];
    [self.tableView registerClass:[TJGoodsDetailsImagesCell class] forCellReuseIdentifier:GoodsDetailsImagesCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self setUIfootView];
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
        TJJHSGoodsListModel *model = self.dataArr[0];
        if (model.guide_article==nil) {
            cell.detailsIntro = model.itemdesc;
        }else{
            cell.detailsIntro = model.guide_article;

        }
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
            if (model.guide_article==nil) {
                cell.detailsIntro = model.itemdesc;
            }else{
                cell.detailsIntro = model.guide_article;

            }
        }]+10;
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
    if (section==0) {
        return 0.1;
    }
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
    NSString* bind_tb = GetUserDefaults(Bind_TB);

    if (but.tag==DetailsBuyButton) {
        DSLog(@"详情页购买");
        NSDictionary *param = @{ @"itemid":self.gid,};
        [KConnectWorking requestNormalDataParam:param withRequestURL:GoodsInfoTBK withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
            DSLog(@"===%@--jjjj-",responseObject);
        } withFailure:^(NSError * _Nullable error) {
            DSLog(@"===%@--error-",error);

        }];
        
        if ([bind_tb intValue]==0) {
            DSLog(@"没绑定绑定进淘宝");

            [KConnectWorking getTaoBaoAuthor:self successCallback:^(ALBBSession *session) {
                ALBBUser *user = [session getUser];
                NSString *bimg = [TJOverallJudge encodeToPercentEscapeString:user.avatarUrl];
                NSString *bnick = [user.nick stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *mdParam = @{@"tao_image":bimg,
                                          @"tao_nick":bnick,
                                          @"tao_openid":user.openId
                                          };
                NSDictionary *param = @{@"tao_openid":user.openId,
                                        @"tao_image":user.avatarUrl,
                                        @"tao_nick":user.nick,};
                [KConnectWorking requestNormalDataMD5Param:mdParam withNormlParams:param withRequestURL:BindTaoBao withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                    DSLog(@"---info0--bbb==%@",responseObject);
                    [self goTaoBaoGoodsInfo];

                } withFailure:^(NSError * _Nullable error) {
                    NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
                    [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
                    DSLog(@"--bind-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
                }];
            } failureCallback:^(ALBBSession *session, NSError *error) {
            }];
        }else{
            DSLog(@"直接进淘宝");
            [self goTaoBaoGoodsInfo];
        }
       
        
    }else if (but.tag==DetailsQuanBuyButton){
        DSLog(@"优惠券页面");
        if ([bind_tb intValue]==0) {

            [KConnectWorking getTaoBaoAuthor:self successCallback:^(ALBBSession *session) {
                ALBBUser *user = [session getUser];
                NSString *bimg = [TJOverallJudge encodeToPercentEscapeString:user.avatarUrl];
                NSString *bnick = [user.nick stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *mdParam = @{@"tao_image":bimg,
                                          @"tao_nick":bnick,
                                          @"tao_openid":user.openId
                                          };
                NSDictionary *param = @{@"tao_openid":user.openId,
                                        @"tao_image":user.avatarUrl,
                                        @"tao_nick":user.nick,};
                [KConnectWorking requestNormalDataMD5Param:mdParam withNormlParams:param withRequestURL:BindTaoBao withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
                    [self goTaoBaoGoodsInfoQuanBuy];
                    
                } withFailure:^(NSError * _Nullable error) {
                }];
            } failureCallback:^(ALBBSession *session, NSError *error) {
            }];
        }else{
            DSLog(@"绑定--进淘宝");
            [self goTaoBaoGoodsInfoQuanBuy];
        }
        
       
    }else if (but.tag==DetailShareButton){
        DSLog(@"分享");
        TJInvitationView *iview = [TJInvitationView invitationView];
        iview.backgroundColor = RGBA(1, 1, 1, 0.2);
        iview.frame = CGRectMake(0, 0, S_W, S_H);iview.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:iview];
        
    }else if (but.tag==DetailsGoTopButton){
        DSLog(@"返回顶部");
        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else if (but.tag==DetailCollectButton){
        DSLog(@"收藏");
        self.collectStatus = [NSString stringWithFormat:@"%d",but.selected];
        [self requestCollectGoods];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - share
- (void)shareButtonClick:(NSInteger)sender{
    //创建分享参数
    TJJHSGoodsListModel *model = self.dataArr[0];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:model.itemshorttitle
                                     images:[NSURL URLWithString:model.itempic] //传入要分享的图片
                                        url:[NSURL URLWithString:self.shareurl]
                                      title:model.itemshorttitle
                                       type:SSDKContentTypeWebPage];
    
    if (sender==140) {
        //        朋友圈
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else  if (sender==141) {
        //        好友
        [ShareSDK share:SSDKPlatformSubTypeWechatSession //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else  if (sender==144) {
        //sms
        //短信
         [shareParams SSDKSetupSMSParamsByText:model.itemshorttitle title:model.itemshorttitle images:nil attachments:nil recipients:nil type:SSDKContentTypeAuto];
        [ShareSDK share:SSDKPlatformTypeSMS //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                                                                        delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]   delegate:nil    cancelButtonTitle:@"OK"    otherButtonTitles:nil, nil];
                     [alert show];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }else  if (sender==145) {
        //link
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.shareurl;
        if (pasteboard == nil) {
            [SVProgressHUD showInfoWithStatus:@"复制失败"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"已复制"];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"暂不支持"];
    }
}
- (void)getCouponClick:(UIButton *)sender{
    DSLog(@"优惠券");
    //打开优惠券详情页
    TJJHSGoodsListModel *model = self.dataArr[0];
    id <AlibcTradePage >page = [AlibcTradePageFactory page:model.couponurl];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeAuto;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        }];
    });
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
         [SVProgressHUD showSuccessWithStatus:@"收藏成功！"];
         self.shareB.selected = YES;
     }onFailure:^(NSError * _Nullable error) {
         [SVProgressHUD showSuccessWithStatus:@"取消成功！"];
         self.shareB.selected = NO;
         
//         if (error.userInfo.count>0) {
//             NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//             NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
//            [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
//             DSLog(@"--收藏-≈≈error-msg%@=======code%@",dic_err[@"msg"],dic_err);
//         }else{
//             DSLog(@"--收藏-≈≈error-%@===",error);
//
//         }
        
     }];
}

- (void)goTaoBaoGoodsInfo
{
    //打开商品详情页
    id <AlibcTradePage >page = [AlibcTradePageFactory itemDetailPage:self.gid];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeAuto;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    
    [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        //            NSLog(@"success!==淘宝详情=%@",result);
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
    }];
}

- (void)goTaoBaoGoodsInfoQuanBuy{
    //打开优惠券详情页
    TJJHSGoodsListModel *model = self.dataArr[0];
    NSString *url = [NSString stringWithFormat:@"%@&pid=%@",model.couponurl,TB_Pid];
    id <AlibcTradePage >page = [AlibcTradePageFactory page:url];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeAuto;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        }];
    });
}
#pragma mark - TJBottomViewDeletage
-(void)clickViewRemoveFromSuper{
    [self.popupView removeFromSuperview];
}




@end
