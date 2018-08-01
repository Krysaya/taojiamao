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
#import "TJArticlesInfoListModel.h"
@interface TJHeadDetailController ()<TJButtonDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *view_bottom;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TJHeadDetailController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestNewsInfoList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"share" withSelectImage:nil];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-50-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
     [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineContentCell" bundle:nil] forCellReuseIdentifier:@"contentCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineShareCell" bundle:nil] forCellReuseIdentifier:@"shareCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineThreeCell" bundle:nil] forCellReuseIdentifier:@"tuijianCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJMoreCommentsCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];

    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)requestNewsInfoList{
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
        //        request.parameters = @{@"type":type};
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"----newsinfo-success-===%@",responseObject);
        
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJArticlesInfoListModel mj_objectArrayWithKeyValuesArray:dict];
        DSLog(@"-%lu--arr==",(unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--news-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJArticlesInfoListModel *model = self.dataArr[0];
    TJHeadLineContentCell *cell = (TJHeadLineContentCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.tv_content.attributedText = [self attributedStringWithHTMLString:model.content];
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            CGFloat height = [cell.tv_content.attributedText boundingRectWithSize:CGSizeMake(S_W-30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
         
            return height;
        }
        return 50;
    }else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            return 30;
        }
        return 140;
        
    }else{
        
        if (indexPath.row==0) {
            return 30;
        }
        return 160;
    }
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
        TJArticlesInfoListModel *model = self.dataArr[0];

    if(indexPath.section==0){
        if (indexPath.row==0) {
            //            h5
            TJHeadLineContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
            cell.model = model;
            return cell;
        }else{
            //            分享
            TJHeadLineShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell"];
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
            cell.view_bg.hidden = NO;
            [cell.btn_more addTarget:self action:@selector(moreComments:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y==0) {
        DSLog(@"原位");
        self.view_bottom.hidden = NO;
    }else if (scrollView.contentOffset.y>0){
        DSLog(@"bottom");
        self.view_bottom.hidden = YES;
    }
}

- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString

{
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
}


#pragma mark - moreComments
- (void)moreComments:(UIButton *)sender
{
    TJReplyController *vc = [[TJReplyController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
