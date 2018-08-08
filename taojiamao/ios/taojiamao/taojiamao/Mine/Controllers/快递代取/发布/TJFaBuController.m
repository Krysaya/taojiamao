
//
//  TJFaBuController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJFaBuController.h"
#import "TJOrderPayController.h"//支付



#import "TJAdressCell.h"
#import "TJAdressTwoCell.h"
#import "TJTextFiledCell.h"
#import "TJPostageMoneyCell.h"//加急

@interface TJFaBuController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJFaBuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    self.view.backgroundColor = KBGRGB;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-120) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor  = KBGRGB;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressCell" bundle:nil] forCellReuseIdentifier:@"AdressCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressTwoCell" bundle:nil] forCellReuseIdentifier:@"AdressTwoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJTextFiledCell" bundle:nil] forCellReuseIdentifier:@"TextFiledCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJPostageMoneyCell" bundle:nil] forCellReuseIdentifier:@"PostageMoneyCell"];
    [self.view addSubview:tableView];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, S_H-80, S_W-20, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnClick:(UIButton *)sender
{
    TJOrderPayController *vc = [[TJOrderPayController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 100;
    }else if (indexPath.row==1){
        return 80;
    }else if (indexPath.row==5){
        return 210;
    }else{
        return 55;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
        return cell;
    }else if (indexPath.row==1){
        
    TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
        return cell;
    } else if (indexPath.row==2||indexPath.row==3||indexPath.row==4){
        TJTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFiledCell"];
        return cell;
    }else {
        TJPostageMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostageMoneyCell"];
        return cell;
    }

    
}

@end
