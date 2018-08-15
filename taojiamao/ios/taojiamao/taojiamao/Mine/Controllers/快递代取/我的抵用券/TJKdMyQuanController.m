
//
//  TJKdMyQuanController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyQuanController.h"

@interface TJKdMyQuanController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TJKdMyQuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的抵用券";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-50) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJKdQuAddressCell" bundle:nil] forCellReuseIdentifier:@"KdQuAddressCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    TJKdQuAddressCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"KdQuAddressCell"];
//    cell.deletage = self;
//    cell.indexPath = indexPath;
    return nil;
}
@end
