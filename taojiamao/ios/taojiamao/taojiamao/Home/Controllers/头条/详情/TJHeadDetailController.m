//
//  TJHeadDetailController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadDetailController.h"
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
@end

@implementation TJHeadDetailController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.title_art;
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"share" withSelectImage:nil];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-54-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
     [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineContentCell" bundle:nil] forCellReuseIdentifier:@"contentCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineShareCell" bundle:nil] forCellReuseIdentifier:@"shareCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineThreeCell" bundle:nil] forCellReuseIdentifier:@"tuijianCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJMoreCommentsCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];

    [self.view addSubview:tableView];
    WeakSelf
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNewsInfoList];
        [weakSelf requestReplyList];

    }];
    [tableView.mj_header beginRefreshing];
    self.tableView = tableView;
    
    
}

- (void)requestNewsInfoList{

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
                                @"id":self.aid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = [NSString stringWithFormat:@"%@/%@",NewsArticles,self.aid];
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
//                request.parameters = @{@"type":type};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----newsinfo-success-===%@",responseObject);
        [self.tableView.mj_header endRefreshing];
        NSDictionary *dict = responseObject[@"data"];
        if (dict.count>0) {
            TJArticlesInfoListModel *model = [TJArticlesInfoListModel mj_objectWithKeyValues:dict[@"detail"]];
            TJArticlesListModel *remodel = [TJArticlesListModel mj_objectWithKeyValues:dict[@"relate"]];
            self.model = model;
            self.remodel = remodel;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
       
        
    } onFailure:^(NSError * _Nullable error) {
        [SVProgressHUD showInfoWithStatus:@"请重试~"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)requestReplyList{
    //
    self.commentArr = [NSMutableArray array];
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
                                @"aid":self.aid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = CommentsList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"aid":self.aid,
                                };
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--pl%@==success==",responseObject);

        NSDictionary *dict = responseObject[@"data"];
        if (dict.count>0) {
            self.commentArr = [TJCommentsListModel mj_objectArrayWithKeyValuesArray:dict];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
       
    } onFailure:^(NSError * _Nullable error) {

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
        return self.commentArr.count;
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
            TJHeadLineContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
            cell.baseView = tableView;
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
    if (scrollView.contentOffset.y==0) {
//        DSLog(@"原位");
        self.view_bottom.hidden = NO;
        self.tableView.frame = CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-54);
    }else if (scrollView.contentOffset.y>0){
//        DSLog(@"bottom");
        self.view_bottom.hidden = YES;
        self.tableView.frame = CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight);
    }
}
#pragma mark- collect

- (IBAction)sendCollectArticlesRequest:(UIButton *)sender {
//    收藏文章
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
                                @"type":@"2",
                                @"rid":self.aid,
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
        request.parameters = @{@"type":@"2",@"rid":self.aid};
    }onSuccess:^(id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        });
    }onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==1) {
//          推荐
            
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
                                @"type":i,
                                @"aid":self.aid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = CommentsPraises;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"type":i,@"aid":self.aid};
    }onSuccess:^(id  _Nullable responseObject) {
//        [SVProgressHUD showInfoWithStatus:@"点赞了~"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        //2.将indexPath添加到数组
        NSArray <NSIndexPath *> *indexPathArray = @[indexPath];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
    }];
}
#pragma mark - return

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    发布评论
    DSLog(@"send");
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    
    NSString *content = [textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"content":content,
                                @"aid":self.aid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = PulishComments;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"content":textField.text,@"aid":self.aid};
    }onSuccess:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        
    }onFailure:^(NSError * _Nullable error) {
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
    TJMoreCommentsCell *cell = (TJMoreCommentsCell *)[[sender superview] superview];
    NSIndexPath  *index = [self.tableView indexPathForCell:cell];
    TJCommentsListModel *m = self.commentArr[index.row-1];
    self.pid = m.id;
    TJCommentsSendView *view = [TJCommentsSendView commentsSendView];
    view.frame = CGRectMake(0, 0, S_W, S_H);view.delegate = self;
    [self.view addSubview:view];
  
}
- (void)sendButtonClick:(NSString *)text{
    DSLog(@"pl----pl=评论send");
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {
    }else{
        userid = @"";
    }
    
    NSString *content = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"content":content,
                                @"aid":self.aid,
                                @"pid":self.pid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = PulishComments;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"pid":self.pid,@"content":text,@"aid":self.aid};
    }onSuccess:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
      
    }onFailure:^(NSError * _Nullable error) {
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
                                     images:[UIImage imageNamed:@"fail.jpg"] //传入要分享的图片
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:self.title_art
                                       type:SSDKContentTypeWebPage];
    if (button.tag==130) {
//        好友
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
//        朋友圈
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
    }else{
        [SVProgressHUD showInfoWithStatus:@"暂不支持分享！"];
    }
}

@end
