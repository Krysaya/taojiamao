//
//  TJOrderPayController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOrderPayController.h"
#import "TJPaySuccessController.h"
#import "TJPayFailController.h"

#import "TJPayDefaultCell.h"
#import "TJPayMoneyCell.h"
#import "TJPayTypeCell.h"
#import "TJPayQuanCell.h"
@interface TJOrderPayController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJOrderPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBGRGB;

    self.title = @"订单支付";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-120) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJPayDefaultCell" bundle:nil] forCellReuseIdentifier:@"PayDefaultCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJPayMoneyCell" bundle:nil] forCellReuseIdentifier:@"PayMoneyCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJPayTypeCell" bundle:nil] forCellReuseIdentifier:@"PayTypeCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJPayQuanCell" bundle:nil] forCellReuseIdentifier:@"PayQuanCell"];
    [self.view addSubview:tableView];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, S_H-80, S_W-20, 44)];
    [btn setTitle:@"立即支付" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)sender{
    int a = 2;
    if (a==1) {
//        成功
        TJPaySuccessController *vc = [[TJPaySuccessController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
//        失败
        TJPayFailController *vc = [[TJPayFailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 45;
    }else if (indexPath.row==1){
        return 146;
    }else if (indexPath.row==2){
        return 235;
    }else{
        return 59;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        TJPayDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayDefaultCell"];
        return cell;
    }else if (indexPath.row==1){
        TJPayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayMoneyCell"];
        return cell;
    }else if (indexPath.row==2){
        TJPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTypeCell"];
        return cell;
    }else{
        TJPayQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayQuanCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJPayTypeCell *cell = (TJPayTypeCell *)[tableView cellForRowAtIndexPath:indexPath];
//    DSLog(@"cell---btn--%@",cell.select_status);

}

@end
