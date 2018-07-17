
//
//  TJClassicController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassicController.h"

@interface TJClassicController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView_left;
@property (nonatomic, strong) UITableView *tableView_right;

@end

@implementation TJClassicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, S_H) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    
}



@end
