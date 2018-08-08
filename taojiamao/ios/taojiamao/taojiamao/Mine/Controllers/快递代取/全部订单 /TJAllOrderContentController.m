
//
//  TJAllOrderContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAllOrderContentController.h"
#import "TJCourierTakeCell.h"

#import "TJOrderInfoController.h"//订单详情

@interface TJAllOrderContentController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation TJAllOrderContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
      [tableView registerNib:[UINib nibWithNibName:@"TJCourierTakeCell" bundle:nil] forCellReuseIdentifier:@"CourierTakeCell"];
    [self.view addSubview:tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 258;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        TJCourierTakeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CourierTakeCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        TJOrderInfoController *vc = [[TJOrderInfoController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
   
}

@end
