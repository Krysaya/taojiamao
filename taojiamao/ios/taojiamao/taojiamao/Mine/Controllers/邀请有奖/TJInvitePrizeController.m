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
#import "TJDefaultGoodsDetailController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface TJInvitePrizeController ()<UICollectionViewDelegate,UICollectionViewDataSource,ShareBtnDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *big_scroll;
@property (weak, nonatomic) IBOutlet UILabel *lab_prize;
@property (weak, nonatomic) IBOutlet UILabel *lab_hour;
@property (weak, nonatomic) IBOutlet UILabel *lab_min;
@property (weak, nonatomic) IBOutlet UILabel *lab_ss;
@property (weak, nonatomic) IBOutlet UILabel *lab_mss;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectHeight;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) TJInvitePrizeModel *model;
//@property (nonatomic, strong) UICollectionView *collectionV;
@end

@implementation TJInvitePrizeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestHongBao];[self requestHomePageGoodsJingXuan];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";

    [self.collectionV registerNib:[UINib nibWithNibName:@"TJInvitePrizeCell" bundle:nil] forCellWithReuseIdentifier:@"InvitePrizeCell"];
}

- (void)requestHomePageGoodsJingXuan{
    //    精选
    self.dataArr = [NSMutableArray array];
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
                                @"page":@"1",
                                @"page_num":@"10",
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = HomePageGoods;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.parameters = @{  @"page":@"1",
                                 @"page_num":@"10",};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        self.dataArr = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];

        DSLog(@"--success--%@-%lu",responseObject,(unsigned long)self.dataArr.count);
        self.collectHeight.constant = self.dataArr.count*125;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionV reloadData];
        });

    } onFailure:^(NSError * _Nullable error) {
        DSLog(@"error--%@==",error);
    }];
}

- (void)requestHongBao{
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
        request.url = RegisterHongBao;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--dfs--%@",responseObject);

        TJInvitePrizeModel *model = [TJInvitePrizeModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = model;
        dispatch_async(dispatch_get_main_queue(), ^{
        self.lab_prize.text = [NSString stringWithFormat:@"%.2f",[model.money floatValue]];
            NSInteger i  = [model.num intValue]+1;
        [self.btn_share setTitle:[NSString stringWithFormat:@"分享后拆第%ld份现金",i] forState:UIControlStateNormal];

        });
    } onFailure:^(NSError * _Nullable error) {
        DSLog(@"--error--%@",error);
    }];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag==4780) {
//        规则
        TJSignRuleController *ruleVc = [[TJSignRuleController alloc]init];
        ruleVc.title = @"活动规则";
        ruleVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self presentViewController:ruleVc animated:NO completion:nil];
        
    }else if (sender.tag==4781){
//        提现
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
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"大恩不言谢！大家帮我拆红包~"
                                     images:[UIImage imageNamed:@"morentouxiang"] //传入要分享的图片
                                        url:[NSURL URLWithString:self.model.share_url]
                                      title:@"我正在参加淘价猫的拆红包，拆一次领一次红包！快来帮我一起拆吧~"
                                       type:SSDKContentTypeWebPage];
    if (sender==140) {
        //        朋友圈
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
        
    }else  if (sender==141) {
        //        好友
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
         }];    }else  if (sender==144) {
        //
    }else  if (sender==145) {
        //link
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.model.share_url;
        if (pasteboard == nil) {
            [SVProgressHUD showInfoWithStatus:@"复制失败"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"已复制"];
        }    }else{
        [SVProgressHUD showInfoWithStatus:@"暂不支持"];
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

@end
