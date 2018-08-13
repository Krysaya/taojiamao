
//
//  TJBargainContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBargainContentController.h"
#import "TJBargainHeadCell.h"
#import "TJGoodsListCell.h"

@interface TJBargainContentController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation TJBargainContentController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)zj_viewDidLoadForIndex:(NSInteger)index{
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource =self;
    [tableView registerNib:[UINib nibWithNibName:@"TJBargainHeadCell" bundle:nil] forCellReuseIdentifier:@"BargainHeadCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.view addSubview:tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        TJBargainHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BargainHeadCell"];
        return cell;
    }
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    [cell cellWithArr:nil forIndexPath:indexPath isEditing:NO withType:@"0"];
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 134;
    }
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}











@end
