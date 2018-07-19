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

@interface TJHeadDetailController ()<TJButtonDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJHeadDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"sgm"];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
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
            return 25;
        }
        return 167;
    }else{
        if (indexPath.row==0) {
            return 25;
        }
        return 170;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if (indexPath.row==0) {
            //            h5
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"htmlCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"htmlCell"];
                cell.separatorInset = UIEdgeInsetsZero;

            }
            return cell;
        }else{
            //            分享
            TJHeadLineShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell"];
            return cell;
        }
    }else if (indexPath.row==1){
        if (indexPath.row==0) {
//            title
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
                cell.textLabel.text = @"相关推荐";
                cell.separatorInset = UIEdgeInsetsZero;

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
            }
            return cell;
        }else{
            //pinglu
            TJMoreCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
            return cell;
        }
        
    }
}

@end
