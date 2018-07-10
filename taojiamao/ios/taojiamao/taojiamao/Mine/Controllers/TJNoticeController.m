//
//  TJNoticeController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJNoticeController.h"
#import "TJNoticeCell.h"

#define CourierBtn  489053
#define Withdrawal  324253
@interface TJNoticeController ()<TJButtonDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)TJButton *btn_Courier;
@property (nonatomic, strong) TJButton *btn_withdrawal;
@end

@implementation TJNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //通知
    self.title = @"消息通知";
    self.view.backgroundColor = RGB(245, 245, 245);
    [self setButton];
    [self setTableView];
}

- (void)setButton{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, S_W, 95)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    
    self.btn_Courier = [[TJButton alloc]initWith:@"快递信息" delegate:self font:12.0 titleColor:RGB(51, 51, 51)  tag:CourierBtn  withBackImage:@"courier_info"];
    [bgView addSubview:self.btn_Courier];
    self.btn_withdrawal = [[TJButton alloc]initWith:@"提现消息" delegate:self font:12.0 titleColor:RGB(51, 51, 51) tag:CourierBtn  withBackImage:@"withdrawal_info"];
    [bgView addSubview:self.btn_withdrawal];
    
    
    [self.btn_Courier mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        make.left.mas_equalTo(bgView.mas_left).offset(75);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(80);
    }];
    [self.btn_withdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        make.right.mas_equalTo(bgView.mas_right).offset(-75);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(80);
    }];
    
}

- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105+60, S_W, S_H) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.rowHeight = 135;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = RGB(245, 245, 245);

    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"TJNoticeCell" bundle:nil] forCellReuseIdentifier:@"TJNoticeCell"];
    
}
#pragma mark - tableViewdelegate
- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJNoticeCell"];
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return   UITableViewCellEditingStyleDelete;
    
}

//先要设Cell可编辑

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return YES;
    
}
//修改编辑按钮文字

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return @"删除";
    
}

//设置进入编辑状态时，Cell不会缩进

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return NO;
    
}

#pragma mark - butdelegate
- (void)buttonClick:(UIButton *)but{
    if (but.tag==CourierBtn) {
        
    }else{
        
    }
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
