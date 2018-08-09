
//
//  TJKdMyMoneyController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyMoneyController.h"
#import "TJKdMineDefaultCell.h"
@interface TJKdMyMoneyController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *view_bg;

@end

@implementation TJKdMyMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 49;
    tableView.sectionFooterHeight = 10;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJKdMineDefaultCell" bundle:nil] forCellReuseIdentifier:@"KdMineDefaultCell"];
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = self.view_bg;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdMineDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMineDefaultCell"];
    return cell;
}

@end
