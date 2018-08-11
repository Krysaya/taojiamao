//
//  TJNoticeController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/28.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJNoticeController.h"
#import "TJNoticeCell.h"
#import "TJCourierInfoController.h"
#import "TJNoticeListModel.h"
#define CourierBtn  489053
#define Withdrawal  324253
@interface TJNoticeController ()<TJButtonDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,strong)TJButton *btn_Courier;
@property (nonatomic, strong) TJButton *btn_withdrawal;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TJNoticeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestInfoList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //通知
    self.title = @"消息通知";
    self.view.backgroundColor = RGB(245, 245, 245);
    [self setButton];
    [self setTableView];
}
- (void)requestInfoList{
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
                                @"type":@"0",
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = MessageNotice;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"type":@"0"};
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"----notice-success-===%@",responseObject);
        
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJNoticeListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        DSLog(@"-%lu--arr==",(unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
//        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
//        DSLog(@"--notice-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
}
- (void)setButton{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, S_W, 95)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    
    self.btn_Courier = [[TJButton alloc]initWith:@"快递信息" delegate:self font:12.0 titleColor:RGB(51, 51, 51)  tag:CourierBtn  withBackImage:@"courier_info" withEdgeType:@"bottom"];
    [bgView addSubview:self.btn_Courier];
    self.btn_withdrawal = [[TJButton alloc]initWith:@"提现消息" delegate:self font:12.0 titleColor:RGB(51, 51, 51) tag:Withdrawal  withBackImage:@"withdrawal_info" withEdgeType:@"bottom"];
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
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105+60, S_W, S_H-95-SafeAreaTopHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.rowHeight = 135;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = RGB(245, 245, 245);

    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"TJNoticeCell" bundle:nil] forCellReuseIdentifier:@"TJNoticeCell"];
    self.tableView = tableView;
}
#pragma mark - tableViewdelegate
- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJNoticeCell"];
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - butdelegate
- (void)buttonClick:(UIButton *)but{

    if (but.tag==CourierBtn) {
        TJCourierInfoController *info = [[TJCourierInfoController alloc]init];
        info.type = @"kd";
        
        [self.navigationController pushViewController:info animated:YES];
    }else{
        TJCourierInfoController *info = [[TJCourierInfoController alloc]init];
        info.type = @"tx";
        

        [self.navigationController pushViewController:info animated:YES];
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
