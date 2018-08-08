
//
//  TJOrderInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderInfoController.h"
#import "TJOrderHeadViewCell.h"//头
#import "TJOrderInfoCell.h"//四个
#import "TJOrderTypeCell.h"//快递类型
#import "TJOrderInfoOneCell.h"//取件码，时间
#import "TJAdressCell.h"
#import "TJAdressTwoCell.h"
@interface TJOrderInfoController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJOrderInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.navigationController.navigationBar.barTintColor = RGB(81, 162, 249);
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJOrderHeadViewCell" bundle:nil] forCellReuseIdentifier:@"OrderHeadViewCell"];
  [tableView registerNib:[UINib nibWithNibName:@"TJOrderInfoOneCell" bundle:nil] forCellReuseIdentifier:@"OrderInfoOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJOrderTypeCell" bundle:nil] forCellReuseIdentifier:@"OrderTypeCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressCell" bundle:nil] forCellReuseIdentifier:@"AdressCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressTwoCell" bundle:nil] forCellReuseIdentifier:@"AdressTwoCell"];
   
   [tableView registerNib:[UINib nibWithNibName:@"TJOrderInfoCell" bundle:nil] forCellReuseIdentifier:@"OrderInfoCell"];
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        TJOrderHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeadViewCell"];
        return cell;
    }else if (indexPath.row==1){
        TJOrderInfoOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoOneCell"];
        return cell;
    }else if (indexPath.row==2){
        TJOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTypeCell"];
        return cell;
    }else if (indexPath.row==3){
        TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
        return cell;
    }else if (indexPath.row==4){
        TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
        return cell;
    }else{
        TJOrderInfoOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoCell"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 65;
    }else if (indexPath.row==1){
        return 85;
    }else if (indexPath.row==2){
        return 85;
    }else if (indexPath.row==3){
        return 100;
    }else if (indexPath.row==4){
        return 70;
    }else{
        return 147;
    }
}


@end
