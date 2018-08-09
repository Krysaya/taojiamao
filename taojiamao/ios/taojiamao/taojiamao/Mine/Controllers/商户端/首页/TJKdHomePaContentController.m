
//
//  TJKdHomePaContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
// 未接单

#import "TJKdHomePaContentController.h"
#import "TJKdHomeOrderCell.h"
#import "TJOrderInfoController.h"
@interface TJKdHomePaContentController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJKdHomePaContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 250;
    tableView.backgroundColor = KBGRGB;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJKdHomeOrderCell" bundle:nil] forCellReuseIdentifier:@"KdHomeOrderCell"];
    [self.view addSubview:tableView];
    
}

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
    TJKdHomeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdHomeOrderCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
