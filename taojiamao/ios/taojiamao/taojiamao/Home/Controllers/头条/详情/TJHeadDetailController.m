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
#import "TJReplyController.h"

@interface TJHeadDetailController ()<TJButtonDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJHeadDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"share"];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-50) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineShareCell" bundle:nil] forCellReuseIdentifier:@"shareCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJHeadLineThreeCell" bundle:nil] forCellReuseIdentifier:@"tuijianCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJMoreCommentsCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];

    [self.view addSubview:tableView];
    
}

- (void)buttonClick:(UIButton *)but{
    
//    TJNoticeController *noticeV = [[TJNoticeController alloc]init];
//    [self.navigationController pushViewController:noticeV animated:YES];
}


#pragma mark - tabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
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
    if(indexPath.section==0){
        if (indexPath.row==0) {
            //            h5
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"htmlCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"htmlCell"];
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);;

            }
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

#pragma mark - moreComments
- (void)moreComments:(UIButton *)sender
{
    TJReplyController *vc = [[TJReplyController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
