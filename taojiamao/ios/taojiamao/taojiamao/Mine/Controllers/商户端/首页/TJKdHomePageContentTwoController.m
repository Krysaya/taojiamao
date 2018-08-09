
//
//  TJKdHomePageContentTwoController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
// 已接单

#import "TJKdHomePageContentTwoController.h"
#import "TJKdHomePageTwoCell.h"

@interface TJKdHomePageContentTwoController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJKdHomePageContentTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBGRGB;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = KBGRGB;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = 200;
    [tableView registerNib:[UINib nibWithNibName:@"TJKdHomePageTwoCell" bundle:nil] forCellReuseIdentifier:@"KdHomePageTwoCell"];
    [self.view addSubview:tableView];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdHomePageTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdHomePageTwoCell"];
    return cell;
}

@end
