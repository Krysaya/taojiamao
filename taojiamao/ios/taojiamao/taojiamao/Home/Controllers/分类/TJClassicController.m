
//
//  TJClassicController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassicController.h"
#import "TJClassicSecondCell.h"
@interface TJClassicController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView_left;
@property (nonatomic, strong) UITableView *tableView_right;

@end

@implementation TJClassicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    self.view.backgroundColor = RGB(245, 245, 245);
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, S_H) style:UITableViewStylePlain];
    tableV.tag = 1000;
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.tableFooterView = [UIView new];
    [self.view addSubview:tableV];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(100, SafeAreaTopHeight, S_W-100, 110);
//    bgView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:bgView];
    
    
    
    UITableView *tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(100, 110+SafeAreaTopHeight, S_W-100, S_H-110-64) style:UITableViewStylePlain];
    tableV2.tag = 2000;
    tableV2.delegate = self;
    tableV2.dataSource = self;
    tableV2.separatorStyle = UITableViewCellSeparatorStyleNone;

    [tableV2 registerClass:[TJClassicSecondCell class] forCellReuseIdentifier:@"classicCell"];
    [self.view addSubview:tableV2];
    
    
}

#pragma mark  - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==1000) {
        return 1;
    }
    return 4;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1000) {
        return 4;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1000) {
        return 45;
    }
    
    return 250;
}
//section间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView.tag==1000) {
//        left
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text = @[@"女装",@"男装",@"内衣",@"母婴"][indexPath.row];
            
        }
        return cell;
    }else{
//        right
        TJClassicSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classicCell"];
        [cell cellHeaderTitle:@[@"女装",@"男装",@"内衣",@"母婴"][indexPath.section] withImageArr:@[@"",@"",@"",@"",@""] withtitleArr:@[@"羽绒服",@"打底裤",@"毛衣",@"卫衣",@"连衣裙"]];
        return cell;
    }
   
}
@end
