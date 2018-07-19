
//
//  TJShareMoneyController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJShareMoneyController.h"
#import "TJShareOneCell.h"
#import "TJShareTwoCell.h"
@interface TJShareMoneyController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabelView;

@end

@implementation TJShareMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.title = @"分享赚钱";
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 160)];
    img.backgroundColor = RandomColor;
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = img;
    [tableView registerNib:[UINib nibWithNibName:@"TJShareOneCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJShareTwoCell" bundle:nil] forCellReuseIdentifier:@"twoCell"];
    [self.view addSubview:tableView];
    
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
       
        TJShareOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        return cell;
    }else{
        TJShareTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        return cell;
    }
}
@end
