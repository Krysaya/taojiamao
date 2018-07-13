
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

@end
