
//
//  TJContentCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentCollectController.h"
#import "TJContentListCell.h"
@interface TJContentCollectController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TJContentCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.rowHeight = 120;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;

    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJContentListCell" bundle:nil] forCellReuseIdentifier:@"contentlistCell"];
    [self.view addSubview:tableView];
    self.contentTabView = tableView;
}
#pragma mark - tableViewDelagte
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJContentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentlistCell"];
    
    return cell;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //编辑设置成自定义的必须把系统的设置为None
//    return UITableViewCellEditingStyleNone;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contentEditStatus) {
        TJContentListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.frame = CGRectMake(43, 0, S_W, 120);
        cell.select_btn.selected = !cell.select_btn.selected;
        if (cell.select_btn.selected) {
            [cell.select_btn setImage:[UIImage imageNamed:@"check_light"] forState:UIControlStateNormal];
        }else{
            [cell.select_btn setImage:[UIImage imageNamed:@"check_default"] forState:UIControlStateNormal];
        }
    }else{
        //        非编辑状态
        
    }
}

//侧滑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"单行取消收藏");
        
    }else{
        
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}
@end
