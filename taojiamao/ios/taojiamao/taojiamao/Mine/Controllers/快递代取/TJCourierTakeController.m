
//
//  TJCourierTakeController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCourierTakeController.h"
#import "TJCourierTakeCell.h"
#import "TJFaBuController.h"//发布
@interface TJCourierTakeController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TJCourierTakeController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self resetSystemNavibar];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.backgroundColor = RGB(76, 160, 252);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快递代取";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, S_W, S_H-64-50) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJCourierTakeCell" bundle:nil] forCellReuseIdentifier:@"CourierTakeCell"];
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            {
//             发布
                DSLog(@"fb");
              
            }
            break;
        case 101:
        {
//          待接单
            DSLog(@"jd");
            TJFaBuController *vc = [[TJFaBuController alloc]init];
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;
        case 102:
        {
//            待评价
            DSLog(@"pj");

        }
            break;
        case 103:
        {
//         通知
        }
            break;
        default:
            break;
    }
}

#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = self.headView;
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }
    return 258;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = KBGRGB;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"最近订单";
        }
        return cell;
    }else{
        TJCourierTakeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CourierTakeCell"];
        
        return cell;
    }
}

@end
