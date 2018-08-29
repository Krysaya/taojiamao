
//
//  TJKdMyMoneyController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyMoneyController.h"
#import "TJDrawMoneyController.h"
#import "TJAssetsDetailController.h"


#import "TJKdMineDefaultCell.h"

@interface TJKdMyMoneyController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *view_bg;

@end

@implementation TJKdMyMoneyController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 280+SafeAreaTopHeight, S_W, S_H-49-SafeAreaTopHeight-280) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 49;
    tableView.scrollEnabled = NO;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdMineDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMineDefaultCell"];
    cell.type = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        TJDrawMoneyController *vc = [[TJDrawMoneyController alloc]init];
        vc.type_tx = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        TJAssetsDetailController *vc = [[TJAssetsDetailController alloc]init];
        vc.type_mx = @"kd";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
