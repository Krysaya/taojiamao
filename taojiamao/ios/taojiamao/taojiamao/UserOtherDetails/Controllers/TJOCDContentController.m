//
//  TJOCDContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/10.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOCDContentController.h"
#import "TJOCDContentCell.h"

static NSString * const UserTJOcdContentCell = @"UserTJOcdContentCell";

@interface TJOCDContentController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation TJOCDContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setUI];
}

-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.yj_y, S_W, S_H-44-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TJOCDContentCell class] forCellReuseIdentifier:UserTJOcdContentCell];
    [self.view addSubview:self.tableView];
}

 #pragma mark -UITableViewDelegate,UITableViewDataSource
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     if (self.index==0) {
         return 2;
     }else if (self.index==1){
         return 10;
     }else{
         return 1;
     }
     return 20;
 }
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 1;
 }
 -(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     TJOCDContentCell * cell = [tableView dequeueReusableCellWithIdentifier:UserTJOcdContentCell forIndexPath:indexPath];

     return cell;
 }
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 78*H_Scale;
 }
 -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section==0) {
         return 10;
     }else{
         return 5;
     }
 }
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
 -(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return nil;
 }
 -(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
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
