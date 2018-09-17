
//
//  TJMallOrdersController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/2.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMallOrdersController.h"
#import "TJMallOrdersCell.h"
#import "TJTBOrderInfoController.h"
//static NSString * const TJMallOrdersCell = @"TJMallOrdersCell";


@interface TJMallOrdersController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation TJMallOrdersController

- (void)viewDidLoad {
    [super viewDidLoad];
    //商城订单
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TJMallOrdersCell class] forCellReuseIdentifier:@"TJMallOrdersCell"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.dataArray.count;
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJMallOrdersCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TJMallOrdersCell" forIndexPath:indexPath];
//    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJTBOrderInfoController *vc = [[TJTBOrderInfoController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 229*H_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
