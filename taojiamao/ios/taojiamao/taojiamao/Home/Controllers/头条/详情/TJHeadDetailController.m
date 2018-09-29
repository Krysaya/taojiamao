//
//  TJHeadDetailController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadDetailController.h"
#import "TJTouTiaoInfoCell.h"
#import "TJHeadLineShareCell.h"
#import "TJMoreCommentsCell.h"
#import "TJHeadLineThreeCell.h"
#import "TJHeadLineContentCell.h"
#import "TJReplyController.h"

#import "TJInvitationView.h"
#import "TJArticlesListModel.h"
#import "TJArticlesInfoListModel.h"
#import "TJCommentsListModel.h"
#import "TJCommentsSendView.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface TJHeadDetailController ()<TJButtonDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SendBtnDelegate,ShareDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_bottom;
@property (weak, nonatomic) IBOutlet UIButton *btn_collect;

@property (weak, nonatomic) IBOutlet UIButton *btn_content;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TJArticlesInfoListModel *model;
@property (nonatomic, strong) TJArticlesListModel *remodel;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *commentArr;

@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *share_url;
@end

@implementation TJHeadDetailController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [KConnectWorking requestShareUrlData:@"2" withIDStr:self.aid withSuccessBlock:^(id  _Nullable responseObject) {
        self.share_url = responseObject[@"data"][@"share_url"];
    }];
    self.title = self.title_art;
    //    you边按钮
//    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"share" withSelectImage:nil];
//    
//    // 修改导航栏左边的item
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-54-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//     [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineContentCell" bundle:nil] forCellReuseIdentifier:@"contentCell"];
      [tableView registerNib:[UINib nibWithNibName:@"TJTouTiaoInfoCell" bundle:nil] forCellReuseIdentifier:@"contentCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineShareCell" bundle:nil] forCellReuseIdentifier:@"shareCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineThreeCell" bundle:nil] forCellReuseIdentifier:@"tuijianCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJMoreCommentsCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [self requestReplyList:self.aid];

    WeakSelf
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNewsInfoList:weakSelf.aid];

    }];
    [tableView.mj_header beginRefreshing];
}

- (void)requestNewsInfoList:(NSString *)aid{
    self.model = nil;
    self.remodel = nil;
    WeakSelf
    [KConnectWorking requestNormalDataMD5Param:nil withNormlParams:nil withRequestURL:[NSString stringWithFormat:@"%@/%@",NewsArticlesInfo,aid] withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        
    } withFailure:^(NSError * _Nullable error) {
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NSString  * receive = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding ];
        
                //字符串再生成NSData
                NSData *data = [receive dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
                //打印出后台给出的错误信息
                DSLog(@"%@============%@",error,dict[@"msg"]);
    }];
//    [KConnectWorking requestNormalDataParam:@{@"id":aid} withRequestURL:NewsArticlesInfo withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
//        DSLog(@"----newsinfo-success-===%@",responseObject);
//        [weakSelf.tableView.mj_header endRefreshing];
//        NSDictionary *dict = responseObject[@"data"];
//        if (dict.count>0) {
//            TJArticlesInfoListModel *model = [TJArticlesInfoListModel mj_objectWithKeyValues:dict[@"detail"]];
//            TJArticlesListModel *remodel = [TJArticlesListModel mj_objectWithKeyValues:dict[@"relate"]];
//            weakSelf.model = model;
//            weakSelf.remodel = remodel;
//            [weakSelf.tableView reloadData];
//        }
//    } withFailure:^(NSError * _Nullable error) {
//        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSString  * receive = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding ];
//
//        //字符串再生成NSData
//        NSData *data = [receive dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//
//        //打印出后台给出的错误信息
//        DSLog(@"%@============%@",error,dict[@"msg"]);
//
//
//
//        [SVProgressHUD showInfoWithStatus:@"请重试~"];
//        [weakSelf.tableView.mj_header endRefreshing];
//    }];

}

- (void)requestReplyList:(NSString *)aid{
    //
    self.commentArr = [NSMutableArray array];
    WeakSelf
    [KConnectWorking requestNormalDataParam:@{ @"aid":aid,} withRequestURL:CommentsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
//        DSLog(@"--pl%@==success==",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        weakSelf.commentArr = [TJCommentsListModel mj_objectArrayWithKeyValuesArray:dict];
        [weakSelf.tableView reloadData];
    } withFailure:^(NSError * _Nullable error) {
    }];
    
}

- (void)buttonClick:(UIButton *)but{
    
    TJInvitationView *iview = [TJInvitationView invitationView];
    iview.frame = CGRectMake(0, 0, S_W, S_H);
    iview.lab_tips.hidden = YES;
    iview.lab_title.text = @"文章分享";
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
}


#pragma mark - tabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return self.commentArr.count+1;
    }
        return 2;
//    }
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, S_W, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, S_W, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJArticlesInfoListModel *model = self.model;

    if(indexPath.section==0){
        if (indexPath.row==0) {
            //            h5
            TJTouTiaoInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
//            cell.baseView = tableView;
            cell.model = model;
            
            return cell;
        }else{
            //            分享
            TJHeadLineShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell"];
            cell.delegate = self;
            [cell.btn_zan addTarget:self action:@selector(dianzanClick:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btn_zan setTitle:self.model.like_num forState:UIControlStateNormal];
            return cell;
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
//            title
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
                cell.textLabel.text = @"相关推荐";
                cell.textLabel.textColor = RGB(51, 51, 51);
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);;

            }
            return cell;
        }else{
//推荐
            TJHeadLineThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tuijianCell"];
            cell.model = self.remodel;
            return cell;
        }
    }else{
        if (indexPath.row==0) {
            //            title
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell2"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell2"];
                cell.textLabel.text = @"全部评论";
                cell.textLabel.textColor = RGB(51, 51, 51);
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);;

            }
            return cell;
        }else{
            //pinglu
            TJMoreCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
            cell.model = self.commentArr[indexPath.row-1];
            [cell.btn_more addTarget:self action:@selector(moreComments:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn_comments addTarget:self action:@selector(sendComments:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y==0) {
////        DSLog(@"原位");
//        self.view_bottom.hidden = NO;
//        self.tableView.frame = CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-54);
//    }else if (scrollView.contentOffset.y>0){
////        DSLog(@"bottom");
//        self.view_bottom.hidden = YES;
//        self.tableView.frame = CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight);
//    }
}
#pragma mark- collect

- (IBAction)sendCollectArticlesRequest:(UIButton *)sender {
//    收藏文章
    [KConnectWorking requestNormalDataParam:@{@"type":@"2",@"rid":self.aid} withRequestURL:AddCollect withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        sender.selected = YES;
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    } withFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==1) {
//          推荐
//            self.aid = self.remodel.id;
//            self.title = self.remodel.title;
//
//            [tableView.mj_header beginRefreshing];
        }
    }
}
- (IBAction)scrollAllContent:(UIButton *)sender {
    if (self.commentArr.count>0) {
        NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - zan
- (void)dianzanClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSString * i = [NSString stringWithFormat:@"%d",sender.selected];
    DSLog(@"--dian-%d---mei-",sender.selected);
    WeakSelf
    [KConnectWorking requestNormalDataParam:@{@"type":i,@"aid":self.aid} withRequestURL:CommentsPraises withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        //2.将indexPath添加到数组
        NSArray <NSIndexPath *> *indexPathArray = @[indexPath];
        [weakSelf.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
    } withFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
   
}
#pragma mark - return

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    发布评论
    DSLog(@"send");
    WeakSelf
    NSString *content = [textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [KConnectWorking requestNormalDataMD5Param:@{ @"content":content, @"aid":self.aid,} withNormlParams:@{@"content":textField.text,@"aid":self.aid} withRequestURL:PulishComments withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [textField resignFirstResponder];
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        [weakSelf requestReplyList:weakSelf.aid];
        NSIndexSet *indexSet= [[NSIndexSet alloc]initWithIndex:2];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } withFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
  
    return YES;
}

#pragma mark - moreComments
- (void)moreComments:(UIButton *)sender
{
    TJReplyController *vc = [[TJReplyController alloc]init];
    vc.aid = self.aid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)sendComments:(UIButton *)sender
{
    TJMoreCommentsCell *cell = (TJMoreCommentsCell *)[[[sender superview] superview] superview];
    NSIndexPath  *index = [self.tableView indexPathForCell:cell];
    TJCommentsListModel *m = self.commentArr[index.row-1];
    DSLog(@"-indexxxxxx-%@",index);
    self.pid = m.id;
    TJCommentsSendView *view = [TJCommentsSendView commentsSendView];
    view.frame = CGRectMake(0, 0, S_W, S_H);view.delegate = self;
    [self.view addSubview:view];
  
}
- (void)sendButtonClick:(UITextField *)textFiled{
    DSLog(@"pl----pl=评论send");
    WeakSelf
    NSString *content = [textFiled.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [KConnectWorking requestNormalDataMD5Param:@{@"content":content,@"aid":self.aid,@"pid":self.pid,} withNormlParams:@{ @"pid":self.pid,@"content":textFiled.text,@"aid":self.aid} withRequestURL:PulishComments withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        [textFiled resignFirstResponder];
        [weakSelf requestReplyList:weakSelf.aid];
        NSIndexSet *indexSet= [[NSIndexSet alloc]initWithIndex:2];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } withFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
  
}

#pragma mark - share
- (void)shareButtonClick:(UIButton *)button{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.title_art
                                     images:[UIImage imageNamed:@"logo"] //传入要分享的图片
                                        url:[NSURL URLWithString:self.share_url]
                                      title:self.title_art
                                       type:SSDKContentTypeWebPage];
    if (button.tag==130) {
//        朋友圈
        //进行分享
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
    }else if (button.tag==131){
//        好友
        //进行分享
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
    }else if (button.tag==132){
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
    }else if(button.tag==133){
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
