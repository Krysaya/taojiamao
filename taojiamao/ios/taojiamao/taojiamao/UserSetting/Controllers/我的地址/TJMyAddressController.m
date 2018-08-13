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
#import "TJAddEditAddressController.h"

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
    [self netWork];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame =CGRectMake(0,0, 60, 44);
    [self.editBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self.editBtn setTitle:@"编辑"forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.editBtn addTarget:self action:@selector(editCell:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
    self.navigationItem.rightBarButtonItem = barBut;
    
    self.title = @"我的收货地址";
    
    [self setUI];
}
-(void)netWork{
    
    
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
        NSLog(@"----address-success-===%@",responseObject);
        self.dataArray = [TJMyAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        //            NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        //            NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        //            DSLog(@"--个人信息-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
    
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.yj_y, S_W, S_H-50) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
//    self.editBtn.hidden = YES;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TJMyAddressCell class] forCellReuseIdentifier:SettingMyAddressCell];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.addNewAdd = [[TJButton alloc]initWith:@"添加新地址" delegate:self font:16*W_Scale titleColor:[UIColor whiteColor] backColor:KKDRGB tag:AddNewAddress];
    [self.view addSubview:self.addNewAdd];
    WeakSelf
    [self.addNewAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
    }];
}
- (void)editCell:(UIButton *)sender{
    self.tableView.editing = YES;
    if (self.tableView.editing) {
        [sender setTitle:@"删除" forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        
    }
    
    
//    [self.tableView setEditing:!self.tableView.editing animated:YES];

}

#pragma mark - tableViewDelegate

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete ;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中数据
    TJMyAddressCell *cell = (TJMyAddressCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    [self.selectorPatnArray addObject:self.dataArray[indexPath.section]];
    if (self.selectorPatnArray.count == 0) {
//        self
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.selectorPatnArray.count > 0) {

        [self.selectorPatnArray removeObject:self.dataArray[indexPath.section]];
    }
    
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
    cell.model = self.dataArray[indexPath.section];
    cell.deletage =self;
    cell.indexPath = indexPath;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87*H_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 5;
    }
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
-(void)deleteClick:(NSIndexPath *)index{
    DSLog(@"删除");
//    WeakSelf
    TJAlertController * avc = [TJAlertController alertWithTitle:@"提示" message:@"确定要删除此条地址吗?" style:UIAlertControllerStyleAlert sureClick:^(UIAlertAction * _Nonnull action) {
//        [weakSelf.dataArray removeObject:self.selectorPatnArray[index.section]];
//        [weakSelf.tableView reloadData];
    } cancelClick:^(UIAlertAction * _Nonnull action) {
        
    }];
    [self presentViewController:avc animated:YES completion:nil];
}
-(void)editClick:(NSIndexPath *)index{
    DSLog(@"编辑");
    TJAddEditAddressController * aevc = [[TJAddEditAddressController alloc]init];
    aevc.model = self.dataArray[index.section];
    [self.navigationController pushViewController:aevc animated:YES];
}
#pragma mark - TJBUttonDelagate
-(void)buttonClick:(UIButton *)but{
    DSLog(@"添加新地址");
    TJAddEditAddressController * aevc = [[TJAddEditAddressController alloc]init];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
