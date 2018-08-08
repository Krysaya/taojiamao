//
//  TJSettingController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJSettingController.h"
#import "TJAssistanceCell.h"
#import "TJCleanCacheCell.h"
#import "SDImageCache.h"
#import "TJMyAddressController.h"
#import "TJAccountSafeController.h"
#import "TJBindTBController.h"

#define LogOut 7878787878
static NSString *const TJSettingCell = @"TJSettingCell";
static NSString *const TJSettingCleanCacheCell = @"TJSettingCleanCacheCell";
@interface TJSettingController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)TJButton * logout;
@property(nonatomic,assign)BOOL ShowQU;
@property(nonatomic,copy)NSString * area;
@end

@implementation TJSettingController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.title = @"账户设置";

    [self setUI];
   
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.yj_y, S_W, S_H-50) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = KBGRGB;
    [self.tableView registerClass:[TJAssistanceCell class] forCellReuseIdentifier:TJSettingCell];
    [self.tableView registerClass:[TJCleanCacheCell class] forCellReuseIdentifier:TJSettingCleanCacheCell];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.logout = [[TJButton alloc]initWith:@"退出当前账户" delegate:self font:16*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:LogOut];
    [self.view addSubview:self.logout];
    WeakSelf
    [self.logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = self.dataArray[section];
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count-1) {
        TJCleanCacheCell * cell = [tableView dequeueReusableCellWithIdentifier:TJSettingCleanCacheCell forIndexPath:indexPath];
        NSUInteger size = [[SDWebImageManager sharedManager].imageCache getSize];
        cell.size = size;
        return cell;
    }else{
        TJAssistanceCell * cell = [tableView dequeueReusableCellWithIdentifier:TJSettingCell forIndexPath:indexPath];
        cell.onlyString = self.dataArray[indexPath.section][indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47*H_Scale;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.ShowQU && section==0) {
        UIView * v = [[UIView alloc]init];
        UIView * w = [[UIView alloc]initWithFrame:CGRectMake(0, 10, S_W, 47*H_Scale)];
        w.backgroundColor = [UIColor whiteColor];
        [v addSubview:w];
        UILabel * label1 = [[UILabel alloc]init];
        label1.text = @"所属区域";
        [w addSubview:label1];
        label1.textColor = RGB(51, 51, 51);
        label1.font = [UIFont systemFontOfSize:14*W_Scale];
        [w addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(w);
            make.left.mas_equalTo(30*W_Scale);
        }];
        
        UILabel * label2 = [[UILabel alloc]init];
        label2.text = self.area;
        [w addSubview:label2];
        label2.textColor = RGB(51, 51, 51);
        label2.font = [UIFont systemFontOfSize:14*W_Scale];
        [w addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(w);
            make.right.mas_equalTo(-30*W_Scale);
        }];
        
        return v;
    }else{
      return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return self.ShowQU?57*H_Scale:10;
    }else{
        return 10;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        if (indexPath.row==0) {
//            TJMyAddressController * mavc = [[TJMyAddressController alloc]init];
//            [self.navigationController pushViewController:mavc animated:YES];
        }else if (indexPath.row==1){
            TJAccountSafeController * asvc = [[TJAccountSafeController alloc]init];
            [self.navigationController pushViewController:asvc animated:YES];
        }else{
            TJBindTBController * bvc = [[TJBindTBController alloc]init];
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            DSLog(@"%ld",(long)indexPath.row);
        }else if (indexPath.row==1){
            DSLog(@"%ld",(long)indexPath.row);
        }else{
            DSLog(@"%ld",(long)indexPath.row);
        }
    }
    else{
        WeakSelf
        TJAlertController * alert = [TJAlertController alertWithTitle:@"" message:@"确定要清除缓存吗？" style:UIAlertControllerStyleAlert sureClick:^(UIAlertAction * _Nonnull action) {
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
                [weakSelf.tableView reloadData];
            }];
        } cancelClick:^(UIAlertAction * _Nonnull action) {
            DSLog(@"取消");
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark - TJButtonDeletage
-(void)buttonClick:(UIButton *)but{
    DSLog(@"登出");
    
    WeakSelf
    TJAlertController * alert = [TJAlertController alertWithTitle:@"温馨提示" message:@"确定要退出此账号吗？" style:UIAlertControllerStyleAlert sureClick:^(UIAlertAction * _Nonnull action) {
        RemoveUserDefaults(UID);
        RemoveUserDefaults(TOKEN);
        RemoveUserDefaults(HADLOGIN);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } cancelClick:^(UIAlertAction * _Nonnull action) {
        DSLog(@"取消");
    }];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@[@"我的收货地址",@"账户安全",@"账户绑定"],@[@"关于我们",@"服务条款",@"隐私政策"],@[@"清除缓存"], nil];
    };
    return _dataArray;
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
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
