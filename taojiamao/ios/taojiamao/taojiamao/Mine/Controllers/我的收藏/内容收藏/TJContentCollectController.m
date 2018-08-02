
//
//  TJContentCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentCollectController.h"
#import "TJContentListCell.h"
#import "TJContetenCollectListModel.h"
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
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJContentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentlistCell"];
    [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_contentEditStatus];

    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //编辑设置成自定义的必须把系统的设置为None
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_contentEditStatus) {
        TJContetenCollectListModel *model = [_dataArr objectAtIndex:indexPath.row];
        model.isChecked = !model.isChecked;
        NSLog(@"=点了==%ld",indexPath.row);
        [tableView reloadData];
        }
}
//侧滑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        NSLog(@"单行neirong取消收藏");
    
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}
@end
