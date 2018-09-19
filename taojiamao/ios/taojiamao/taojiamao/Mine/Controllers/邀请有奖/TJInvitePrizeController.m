//
//  TJInvitePrizeController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJInvitePrizeController.h"
#import "TJSignRuleController.h"
#import "TJInvitePrizeCell.h"
#import "TJInvitationView.h"
#import "TJGoodsCollectModel.h"
#import "TJInvitePrizeModel.h"
#import "TJHongBaoLogModel.h"
#import "TJHongBaoLogModel.h"
#import "TJDrawMoneyController.h"
#import "TJDefaultGoodsDetailController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "UIButton+WebCache.h"
@interface TJInvitePrizeController ()<UICollectionViewDelegate,UICollectionViewDataSource,ShareBtnDelegate>
{
    CGFloat _passTime;
}

@property (weak, nonatomic) IBOutlet UIScrollView *big_scroll;
@property (weak, nonatomic) IBOutlet UILabel *lab_prize;
@property (weak, nonatomic) IBOutlet UILabel *lab_hour;
@property (weak, nonatomic) IBOutlet UILabel *lab_min;
@property (weak, nonatomic) IBOutlet UILabel *lab_ss;
@property (weak, nonatomic) IBOutlet UILabel *lab_mss;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectHeight;
@property (weak, nonatomic) IBOutlet UIButton *btn_one;
@property (weak, nonatomic) IBOutlet UILabel *lab_one;
@property (weak, nonatomic) IBOutlet UIButton *btn_two;
@property (weak, nonatomic) IBOutlet UILabel *lab_two;
@property (weak, nonatomic) IBOutlet UIButton *btn_three;
@property (weak, nonatomic) IBOutlet UILabel *lab_three;
@property (weak, nonatomic) IBOutlet UIButton *btn_four;
@property (weak, nonatomic) IBOutlet UILabel *lab_four;
@property (weak, nonatomic) IBOutlet UIButton *btn_five;


@property (weak, nonatomic) IBOutlet UILabel *lab_five;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *hongBaoArr;

@property (nonatomic, strong) TJInvitePrizeModel *model;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double  timeInterval;

@end

@implementation TJInvitePrizeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DSLog(@"+++++appear----%f--%f",_timeInterval,_passTime);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestHongBao];[self requestHomePageGoodsJingXuan];
    [self requestHongBaoListLog];
    self.title = @"邀请好友";
    [self.collectionV registerNib:[UINib nibWithNibName:@"TJInvitePrizeCell" bundle:nil] forCellWithReuseIdentifier:@"InvitePrizeCell"];
    self.lab_five.hidden = YES;self.lab_four.hidden= YES;
    self.lab_three.hidden = YES;self.lab_two.hidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    DSLog(@"+++++dismiss----%f--%f",_timeInterval,_passTime);

}
- (void)dealloc{
    DSLog(@"+++++dealloc----%f--%f",_timeInterval,_passTime);

}
- (void)requestHomePageGoodsJingXuan{
    //    精选
    self.dataArr = [NSMutableArray array];
    NSDictionary *param = @{ @"page":@"1",
                             @"page_num":@"10",};
    [KConnectWorking requestNormalDataParam:param withRequestURL:HomePageGoods withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        self.dataArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
//        DSLog(@"--success--%@-%lu",responseObject,(unsigned long)self.dataArr.count);
        self.collectHeight.constant = self.dataArr.count*125;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionV reloadData];
        });

    } withFailure:^(NSError * _Nullable error) {
        DSLog(@"error--%@==",error);
    }];
   
}

- (void)requestHongBao{
    [KConnectWorking requestNormalDataParam:nil withRequestURL:RegisterHongBao withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        TJInvitePrizeModel *model = [TJInvitePrizeModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *money = [NSString stringWithFormat:@"%.2f",[model.money floatValue]/100];
            self.lab_prize.text = money;
            NSInteger i  = [model.num intValue]+1;
            [self.btn_share setTitle:[NSString stringWithFormat:@"分享后拆第%ld份现金",i] forState:UIControlStateNormal];
        });
        
    } withFailure:^(NSError * _Nullable error) {
        DSLog(@"error--%@==",error);
    }];
    
}
- (void)requestHongBaoListLog{
    self.hongBaoArr = [NSMutableArray array];
    WeakSelf
    [KConnectWorking requestNormalDataParam:nil withRequestURL:RegisterHongBaoLog withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        DSLog(@"--%@--log",responseObject);
        weakSelf.hongBaoArr = [TJHongBaoLogModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        for (int i=0; i<5; i++) {
            if (i+1>weakSelf.hongBaoArr.count) {
                
            }else{
                if (i==0) {
                    TJHongBaoLogModel *m = weakSelf.hongBaoArr[i];
                    NSString *one = [NSString stringWithFormat:@"%.2f",[m.money floatValue]/100];
                    self.lab_one.text = one;
                    if ([m.image containsString:@"http"]) {
                         [weakSelf.btn_one sd_setImageWithURL:[NSURL URLWithString:m.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }else{
                        [weakSelf.btn_one sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,m.image]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }
                    
                }
                if (i==1) {
                    DSLog(@"---第二个");
                    TJHongBaoLogModel *m = weakSelf.hongBaoArr[i];
                    self.lab_two.hidden = NO;
                    NSString *two = [NSString stringWithFormat:@"%.2f",[m.money floatValue]/100];
                    self.lab_two.text = two;
                    
                    if ([m.image containsString:@"http"]) {
                         [weakSelf.btn_two sd_setImageWithURL:[NSURL URLWithString:m.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }else{
                        [weakSelf.btn_two sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,m.image]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }
                  
                }
                if (i==2) {
                    DSLog(@"---第3个");
                    TJHongBaoLogModel *m = weakSelf.hongBaoArr[i];
                    self.lab_three.hidden = NO;

                    NSString *one = [NSString stringWithFormat:@"%.2f",[m.money floatValue]/100];
                    self.lab_three.text = one;
                    if ([m.image containsString:@"http"]) {
                         [weakSelf.btn_three sd_setImageWithURL:[NSURL URLWithString:m.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }else{
                        [weakSelf.btn_three sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,m.image]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }
                    
                }
                if (i==3) {
                    DSLog(@"---第4个");
                    TJHongBaoLogModel *m = weakSelf.hongBaoArr[i];
                    self.lab_four.hidden = NO;

                    NSString *one = [NSString stringWithFormat:@"%.2f",[m.money floatValue]/100];
                    self.lab_four.text = one;
                    if ([m.image containsString:@"http"]) {
                         [weakSelf.btn_four sd_setImageWithURL:[NSURL URLWithString:m.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }else{
                        [weakSelf.btn_four sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,m.image]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }
                  
                }
                if (i==4) {
                    DSLog(@"---第5个");
                    TJHongBaoLogModel *m = weakSelf.hongBaoArr[i];
                    self.lab_five.hidden = NO;

                    NSString *one = [NSString stringWithFormat:@"%.2f",[m.money floatValue]/100];
                    self.lab_five.text = one;
                    if ([m.image containsString:@"http"]) {
                        [weakSelf.btn_five sd_setImageWithURL:[NSURL URLWithString:m.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }else{
                       [weakSelf.btn_five sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,m.image]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
                    }
                    
                }
            }
        }
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag==4780) {
//        规则
        TJSignRuleController *ruleVc = [[TJSignRuleController alloc]init];
        ruleVc.type_title = @"活动规则";
        ruleVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self presentViewController:ruleVc animated:NO completion:nil];
        
    }else if (sender.tag==4781){
//        提现
        
        TJDrawMoneyController * dmvc = [[TJDrawMoneyController alloc]init];
//        dmvc.moneyNum = self.balance;
        [self.navigationController pushViewController:dmvc animated:YES];
    }else if (sender.tag==4782){
        
//        分享
        TJInvitationView *iview = [TJInvitationView invitationView];
        iview.backgroundColor = RGBA(1, 1, 1, 0.2);
        iview.frame = CGRectMake(0, 0, S_W, S_H);iview.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:iview];
    }
}
#pragma mark - share
- (void)shareButtonClick:(NSInteger)sender{
    
    [self countTime];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"大恩不言谢！大家帮我拆红包~"
                                     images:[UIImage imageNamed:@"morentouxiang"] //传入要分享的图片
                                        url:[NSURL URLWithString:self.model.share_url]
                                      title:@"我正在参加淘价猫的拆红包，拆一次领一次红包！快来帮我一起拆吧~"
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
        //短信
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
        pasteboard.string = self.model.share_url;
        if (pasteboard == nil) {
            [SVProgressHUD showInfoWithStatus:@"复制失败"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"已复制"];
        }
        
    }else if (sender==142){
        //       qq
        [ShareSDK share:SSDKPlatformSubTypeQQFriend //传入分享的平台类型
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
    }else if(sender==143){
        //        qqarz
        [ShareSDK share:SSDKPlatformSubTypeQZone //传入分享的平台类型
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
    }
}
#pragma mark ---- UICollectionViewDataSource

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((S_W-35)/2, 250);
}
//这个是两行cell之间的间距（上下行cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJInvitePrizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InvitePrizeCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    //    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    TJDefaultGoodsDetailController *goodVC = [[TJDefaultGoodsDetailController alloc]init];
    TJGoodsCollectModel *model = self.dataArr[indexPath.row];
    goodVC.gid = model.itemid;
    //    goodVC.price = model.itemprice;goodVC.priceQuan = model.itemendprice;
    [self.navigationController pushViewController:goodVC animated:YES];
}

- (void)countTime{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    
    //获取当前系统的时间，并用相应的格式转换
    [dataFormatter stringFromDate:[NSDate date]];
    NSString *currentDayStr = [dataFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dataFormatter dateFromString:currentDayStr];
    
    //优惠结束的时间，也用相同的格式去转换
    NSDate *date =  [NSDate dateWithTimeInterval:24*60*60 sinceDate:currentDate];
    NSString *deadlineStr = [dataFormatter stringFromDate:date];
    NSDate *deadlineDate = [dataFormatter dateFromString:deadlineStr];
    
    _timeInterval= [deadlineDate timeIntervalSinceDate:currentDate]*1000;
    if (_timeInterval!=0)
    {
        //时间间隔是100毫秒，也就是0.1秒
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }else{
        //        [_countdownBackView removeFromSuperview];
        [_timer invalidate];
    }
    
}

- (void)timerAction{
    // 每间隔100毫秒定时器触发执行该方法
    [self getTimeFromTimeInterval:_timeInterval] ;
    
    
    // 当时间间隔为0时干掉定时器
    if (_timeInterval-_passTime == 0)
    {
        [_timer invalidate] ;
        _timer = nil ;
    }
}
// 通过时间间隔计算具体时间(小时,分,秒,毫秒)
- (void)getTimeFromTimeInterval : (double)timeInterval
{
    
    //1s=1000毫秒
    _passTime += 100.f;//毫秒数从0-9，所以每次过去100毫秒
    
    //小时数
    NSString *hours = [NSString stringWithFormat:@"%ld", (long)((timeInterval-_passTime)/1000/60/60)];
    //分钟数
    NSString *minute = [NSString stringWithFormat:@"%ld", (NSInteger)((timeInterval-_passTime)/1000/60)%60];
    //秒数
    NSString *second = [NSString stringWithFormat:@"%ld", ((NSInteger)(timeInterval-_passTime))/1000%60];
    //毫秒数
    CGFloat sss = ((NSInteger)((timeInterval - _passTime)))%1000/100;
    
    
    NSString *ss = [NSString stringWithFormat:@"0%.lf", sss];
    
    if (minute.integerValue < 10) {
        minute = [NSString stringWithFormat:@"0%@", minute];
    }
    
    
    self.lab_hour.text = [NSString stringWithFormat:@"%@",hours];
    self.lab_min.text = [NSString stringWithFormat:@"%@",minute];
    self.lab_ss.text = [NSString stringWithFormat:@"%@",second];
    self.lab_mss.text = [NSString stringWithFormat:@"%@",ss];
    
    if (timeInterval - _passTime <= 0) {
        //        [_countdownBackView removeFromSuperview];
        //        [self removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
    }
    
}


@end
