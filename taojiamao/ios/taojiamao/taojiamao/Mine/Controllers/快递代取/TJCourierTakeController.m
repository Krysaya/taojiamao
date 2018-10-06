
//
//  TJCourierTakeController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCourierTakeController.h"
#import "TJKdUserOrderList.h"

#import "PopoverView.h"
#import "TJCourierTakeCell.h"
#import "TJKdFabuController.h"//发布
#import "TJOrderInfoController.h"//订单详情
#import "TJKdAllOrdersController.h"//全部订单
#import "TJMyAddressController.h"//地址
#import "TJEvaluationController.h"//评价
#import "TJKdAllOrdersController.h"//待评价
#import "TJNoticeController.h"//通知
#import "TJWaitingOrderController.h"//待接单
#import "TJKdMyQuanController.h"
#define RIGHTBTN  4783
@interface TJCourierTakeController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJCourierTakeController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]}];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setNavBarBgAlpha:0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    [self loadReuqestNearByTimesOrderList];

}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    //去掉导航栏底部的黑线
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快递代取";
   
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:RIGHTBTN withBackImage:@"kd_more" withSelectImage:nil];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 118+SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-118) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJCourierTakeCell" bundle:nil] forCellReuseIdentifier:@"CourierTakeCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)loadReuqestNearByTimesOrderList{
    self.dataArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":@"2",
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    //        DSLog(@"--%@--sign",md5Str);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdOrderList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"type":@"2"};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"=--zuiji-=--%@",responseObject);
        self.dataArr = [TJKdUserOrderList mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)buttonClick:(UIButton *)but{
//    popview
    // 不带图片
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"我的资产" handler:^(PopoverAction *action) {
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"我的地址" handler:^(PopoverAction *action) {
        TJMyAddressController * mavc = [[TJMyAddressController alloc]init];
        [self.navigationController pushViewController:mavc animated:YES];

    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"我的券" handler:^(PopoverAction *action) {
        TJKdMyQuanController *vc = [[TJKdMyQuanController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"全部订单" handler:^(PopoverAction *action) {
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
                TJKdFabuController *vc = [[TJKdFabuController alloc]init];
                [self.navigationController  pushViewController:vc animated:YES];
            }
            break;
        case 301:
        {
//          待接单
            DSLog(@"jd");
            TJWaitingOrderController *vc = [[TJWaitingOrderController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 302:
        {
//            待评价
            DSLog(@"pj");
            TJKdAllOrdersController *vc = [[TJKdAllOrdersController alloc]init];
            vc.selectIndex = @"2";
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 303:
        {
//         通知
            TJNoticeController *vc = [[TJNoticeController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - tableViewDelegate
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = self.headView;
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 118;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count+1;
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
        cell.model = self.dataArr[indexPath.row-1];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
    }else{
        TJKdUserOrderList *m = self.dataArr[indexPath.row-1];
        TJOrderInfoController *vc = [[TJOrderInfoController alloc]init];
        vc.kdid = m.id;
        vc.kdstatus = m.status;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - pinglun
- (void)pinglunClick:(UIButton *)sender{
    TJEvaluationController *vc = [[TJEvaluationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
