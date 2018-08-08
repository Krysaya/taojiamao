
//
//  TJCourierTakeController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCourierTakeController.h"
#import "PopoverView.h"
#import "TJCourierTakeCell.h"
#import "TJFaBuController.h"//发布
#import "TJOrderInfoController.h"//订单详情
#import "TJKdAllOrdersController.h"//全部订单
#import "TJMyAddressController.h"//地址
#import "TJEvaluationController.h"//评价
#define RIGHTBTN  4783
@interface TJCourierTakeController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>
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
    self.navigationController.navigationBar.barTintColor = RGB(81, 162, 249);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快递代取";
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:RIGHTBTN withBackImage:@"kd_more" withSelectImage:nil];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, S_W, S_H-SafeAreaTopHeight) style:UITableViewStylePlain];
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
- (void)buttonClick:(UIButton *)but{
//    popview
    // 不带图片
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"我的资产" handler:^(PopoverAction *action) {
        DSLog(@"-%@---dian=",action.title);
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"我的地址" handler:^(PopoverAction *action) {
        DSLog(@"-%@---dian=",action.title);
        TJMyAddressController * mavc = [[TJMyAddressController alloc]init];
        [self.navigationController pushViewController:mavc animated:YES];

    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"我的券" handler:^(PopoverAction *action) {
        DSLog(@"-%@---dian=",action.title);

    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"全部订单" handler:^(PopoverAction *action) {
        DSLog(@"-%@---dian=",action.title);
        TJKdAllOrdersController *vc= [[TJKdAllOrdersController alloc ]init];
        [self.navigationController pushViewController:vc animated:YES];

    }];
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDefault;
    popoverView.hideAfterTouchOutside = YES; // 点击外部时不允许隐藏
    [popoverView showToView:but withActions:@[action1, action2, action3, action4]];
    
    
}
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 300:
            {
//             发布
                DSLog(@"fb");
                TJFaBuController *vc = [[TJFaBuController alloc]init];
                [self.navigationController  pushViewController:vc animated:YES];
            }
            break;
        case 301:
        {
//          待接单
            DSLog(@"jd");
            
        }
            break;
        case 302:
        {
//            待评价
            DSLog(@"pj");

        }
            break;
        case 303:
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
        [cell.btn_pl addTarget:self action:@selector(pinglunClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
    }else{
        TJOrderInfoController *vc = [[TJOrderInfoController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - pinglun
- (void)pinglunClick:(UIButton *)sender{
    TJEvaluationController *vc = [[TJEvaluationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
