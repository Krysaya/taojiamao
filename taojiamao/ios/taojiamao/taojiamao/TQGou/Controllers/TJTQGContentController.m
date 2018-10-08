
//
//  TJTQGContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTQGContentController.h"
#import "TJTqgGoodsModel.h"
#import "TJTQGCell.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibcTradeSDK/AlibcTradePageFactory.h>
#import <AlibcTradeSDK/AlibcTradeService.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

static NSString * const TQGContentCell = @"GContentCell";

@interface TJTQGContentController ()<UITableViewDelegate,UITableViewDataSource,ShareBtnDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSString *shareurl;

@property (nonatomic, strong) TJTqgGoodsModel *selectM;
@property (nonatomic, assign) int page;
@end

@implementation TJTQGContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
        UITableView *tabelV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaTopHeight-50) style:UITableViewStylePlain];
        tabelV.delegate = self;
        tabelV.dataSource = self;
        tabelV.rowHeight = 157;
        tabelV.tableFooterView = [UIView new];
        [tabelV registerNib:[UINib nibWithNibName:@"TJTQGCell" bundle:nil] forCellReuseIdentifier:TQGContentCell];
        [self.view addSubview:tabelV];
        self.tableView = tabelV;
    WeakSelf
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf requestNextGoodsList:weakSelf.model];
    }];
    [footer setTitle:@"----我们是有底线的----" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
}


- (void)requestGoodsListWithModel:(TJTqgTimesListModel *)model{
    //    商品列表
    self.page = 1;
    NSString *pag = [NSString stringWithFormat:@"%d",self.page];
    NSDictionary *param = @{@"page_no":pag,
                            @"page_size":@"10",
                            @"start_time": model.arg,
                            };
    self.dataArr  = [NSMutableArray array];
    WeakSelf
    [KConnectWorking requestNormalDataParam:param withRequestURL:TQGGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
//        没数据判断
        weakSelf.dataArr = [TJTqgGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
         [weakSelf.tableView reloadData];
        weakSelf.page++;
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)requestNextGoodsList:(TJTqgTimesListModel *)model{
    WeakSelf
    NSString *pag = [NSString stringWithFormat:@"%d",self.page];
    NSDictionary *param = @{@"page_no":pag,
                            @"page_size":@"10",
                             @"start_time": model.arg,
                            };
    [KConnectWorking requestNormalDataParam:param withRequestURL:TQGGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [weakSelf.tableView.mj_footer endRefreshing];
        NSArray *array = [TJTqgGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        if (array.count==0) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.dataArr addObjectsFromArray:array];
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        }
       
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TJTQGCell *cell = [tableView dequeueReusableCellWithIdentifier:TQGContentCell];
    cell.type = self.indexx;
    cell.model = self.dataArr[indexPath.row];
    [cell.btn_qiang addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_fen addTarget:self action:@selector(btnShareClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJTqgGoodsModel *m = self.dataArr[indexPath.row];
    id <AlibcTradePage >page = [AlibcTradePageFactory page:m.click_url];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeAuto;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            DSLog(@"success!==tqg详情：======%@",result);
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {

        }];
    });
}
- (void)btnClick:(UIButton *)sender{
    TJTQGCell *cell = (TJTQGCell *)[[sender superview] superview];
    NSIndexPath  *index = [self.tableView indexPathForCell:cell];
    TJTqgGoodsModel *m = self.dataArr[index.row];
    id <AlibcTradePage >page = [AlibcTradePageFactory page:m.click_url];
    AlibcTradeShowParams *showParam = [[AlibcTradeShowParams alloc]init];
    showParam.openType = AlibcOpenTypeAuto;
    AlibcTradeTaokeParams *taoKeParam = [[AlibcTradeTaokeParams alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:taoKeParam trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            DSLog(@"success!==tqg详情：======%@",result);
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            
        }];
    });
}
- (void)btnShareClick:(UIButton *)sender{
    TJTQGCell *cell = (TJTQGCell *)[[sender superview] superview];
    NSIndexPath  *index = [self.tableView indexPathForCell:cell];
    TJTqgGoodsModel *m = self.dataArr[index.row];
    self.selectM = m;
    [KConnectWorking requestShareUrlData:@"1" withIDStr:m.num_iid withSuccessBlock:^(id  _Nullable responseObject) {
        self.shareurl = responseObject[@"data"][@"share_url"];
    }];
    
    TJInvitationView *iview = [TJInvitationView invitationView];
    iview.backgroundColor = RGBA(1, 1, 1, 0.2);
    iview.frame = CGRectMake(0, 0, S_W, S_H);iview.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
    
}

#pragma mark - share
- (void)shareButtonClick:(NSInteger)sender{
    //创建分享参数
    TJTqgGoodsModel *model = self.selectM;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:model.title
                                     images:[NSURL URLWithString:model.pic_url] //传入要分享的图片
                                        url:[NSURL URLWithString:self.shareurl]
                                      title:model.title
                                       type:SSDKContentTypeWebPage];
    
    if (sender==140) {
        //        朋友圈
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil  delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
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
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil   delegate:nil  cancelButtonTitle:@"确定"  otherButtonTitles:nil];
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
         [shareParams SSDKSetupSMSParamsByText:model.title title:model.title images:nil attachments:nil recipients:nil type:SSDKContentTypeAuto];
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
@end
