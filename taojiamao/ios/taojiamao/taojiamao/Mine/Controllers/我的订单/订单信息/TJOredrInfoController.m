//
//  TJOredrInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/20.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOredrInfoController.h"
#import "TJMallOrdersCell.h"
#import "TJOredrInfoCell.h"
@interface TJOredrInfoController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TJOredrInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单信息";
    
}

- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+100, S_W, S_H-100-SafeAreaTopHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"TJOredrInfoCell" bundle:nil] forCellReuseIdentifier:@"OrderInfoCell"];

    [tableView registerNib:[UINib nibWithNibName:@"TJMallOrdersCell" bundle:nil] forCellReuseIdentifier:@"OrdersCell"];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TJOredrInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoCell"];
        return cell;
    }else{
        TJMallOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersCell"];
        return cell;
        
    }
}
@end
