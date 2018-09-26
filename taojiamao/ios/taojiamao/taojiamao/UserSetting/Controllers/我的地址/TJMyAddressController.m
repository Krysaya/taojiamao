//
//  TJMyAddressController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMyAddressController.h"
#import "TJMyAddressCell.h"
#import "TJMyAddressModel.h"
#import "TJAddAddressController.h"

#define AddNewAddress 65721894

static NSString *const SettingMyAddressCell = @"SettingMyAddressCell";

@interface TJMyAddressController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate,TJMyAddressDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据


@property (nonatomic, strong) UIButton *editBtn;
@property(nonatomic,strong)TJButton * addNewAdd;

@end

@implementation TJMyAddressController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    if ([self.type isEqualToString:@"fb"]) {
        [self loadRequestMyAddressList];

    }else{
        if (self.dataArray.count>0) {
        }else{
            [self loadRequestMyAddressList];
        }
    }
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.editBtn.frame =CGRectMake(0,0, 60, 44);
//    [self.editBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
//    [self.editBtn setTitle:@"编辑"forState:UIControlStateNormal];
//    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.editBtn addTarget:self action:@selector(editCell:)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
//    self.navigationItem.rightBarButtonItem = barBut;
    
    self.title = @"我的收货地址";
    [self setUI];
   
}
-(void)loadRequestMyAddressList{
WeakSelf
    
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
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = AddressList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
//        NSLog(@"----address-success-===%@",responseObject);
        weakSelf.dataArray = [TJMyAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {

    }];
}
- (void)loadReuqstDeleteAddressWithAddressID:(NSString *)ID{
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    
    NSString *strid = [ID stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"address_id":strid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
//    DSLog(@"-sign++:%@--strID--%@----id-:%@",md5Str,strid,ID);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = DeleteAddress;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.parameters = @{  @"address_id":ID,};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----DELETE-success-===%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadRequestMyAddressList];
        });
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
-(void)setUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.yj_y, S_W, S_H-50) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.allowsMultipleSelectionDuringEditing = YES;
    tableView.backgroundColor = KBGRGB;
    
    [tableView registerClass:[TJMyAddressCell class] forCellReuseIdentifier:SettingMyAddressCell];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];self.tableView = tableView;
    
    self.addNewAdd = [[TJButton alloc]initWith:@"添加新地址" delegate:self font:16*W_Scale titleColor:[UIColor whiteColor] backColor:KKDRGB tag:AddNewAddress];
    [self.view addSubview:self.addNewAdd];
    WeakSelf
    [self.addNewAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
    }];
}

#pragma mark - tableViewDelegate
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete ;
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    DSLog(@"删除");
    TJMyAddressModel *model = self.dataArray[indexPath.section];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:model.id];
    NSString *strGid = arr.mj_JSONString;
    TJAlertController * avc = [TJAlertController alertWithTitle:@"提示" message:@"确定要删除此条地址吗?" style:UIAlertControllerStyleAlert sureClick:^(UIAlertAction * _Nonnull action) {
        [self loadReuqstDeleteAddressWithAddressID:strGid];
    } cancelClick:^(UIAlertAction * _Nonnull action) {
        
    }];
    [self presentViewController:avc animated:YES completion:nil];
    
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJMyAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:SettingMyAddressCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.section];
    cell.deletage =self;
    cell.indexPath = indexPath;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.type isEqualToString:@"fb"]) {
        TJMyAddressModel *m = self.dataArray[indexPath.section];
        [self.delegate getSongAddressInfoValue:m];
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        return 10;
//    }else{
        return 5;
//    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
#pragma mark - TJMyAddressDelegate
-(void)editClick:(NSIndexPath *)index{
    DSLog(@"bianji地址");
    TJAddAddressController * aevc = [[TJAddAddressController alloc]init];
    aevc.model = self.dataArray[index.section];
    [self.navigationController pushViewController:aevc animated:YES];
}

#pragma mark - TJBUttonDelagate
-(void)buttonClick:(UIButton *)but{
    DSLog(@"添加新地址");
    TJAddAddressController * aevc = [[TJAddAddressController alloc]init];
    [self.navigationController pushViewController:aevc animated:YES];
}
#pragma mark - lazy
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)selectorPatnArray{
    if (!_selectorPatnArray) {
        _selectorPatnArray = [NSMutableArray array];
    }
    return _selectorPatnArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
}


@end
