
//
//  TJKdQuAddressController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdQuAddressController.h"
#import "TJKdQuAddressCell.h"
#import "TJKdQuAddressModel.h"
@interface TJKdQuAddressController ()<UITableViewDelegate,UITableViewDataSource,TJKdQuAddressDelegate,TJButtonDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJKdQuAddressController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestQuAddressWithSchoolID:self.schoolID];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜鸟驿站地址";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, S_H-SafeAreaTopHeight-50) style:UITableViewStylePlain];
    tableView.backgroundColor = KBGRGB;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"TJKdQuAddressCell" bundle:nil] forCellReuseIdentifier:@"KdQuAddressCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
//    TJButton *btn = [[TJButton alloc]initWith:@"添加新地址" delegate:self font:16*W_Scale titleColor:[UIColor whiteColor] backColor:KKDRGB tag:684];
//    [self.view addSubview:btn];
//    WeakSelf
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.mas_equalTo(weakSelf.view);
//        make.top.mas_equalTo(tableView.mas_bottom);
//    }];
}
#pragma mark - request
- (void)loadRequestQuAddressWithSchoolID:(NSString *)schoolID{
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
                                @"school_id":schoolID,
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    //        DSLog(@"--%@--sign",md5Str);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdQuAddress;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{     @"school_id":schoolID,
};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----qu=-success-===%@",responseObject);
        self.dataArr = [TJKdQuAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJKdQuAddressCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"KdQuAddressCell"];
    cell.model = self.dataArr[indexPath.row];
    cell.deletage = self;
    cell.indexPath = indexPath;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    设置类型  ---1-点击消失 2.点击干啥
    TJKdQuAddressModel *m = self.dataArr[indexPath.row];
    [self.delegate getQuAddressInfoValue:m];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)editClick:(NSIndexPath *)index
{
//    编辑取件地址
}
#pragma mark - tjbutton
- (void)buttonClick:(UIButton *)but{
//    add
    
}
@end
