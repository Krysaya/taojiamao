
//
//  TJGoodsCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsCollectController.h"
#import "TJGoodsListCell.h"
#import "TJGoodsCollectModel.h"
#import "SJAttributeWorker.h"
@interface TJGoodsCollectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * indexArr;

@end

@implementation TJGoodsCollectController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.rowHeight = 150;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    //    tableView.allowsMultipleSelection = YES;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.view addSubview:tableView];
    self.goodsTabView = tableView;
}

#pragma mark - tableViewDelagte
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    
    [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_goodsEditStatus withType:@"0"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (_goodsEditStatus) {
        TJGoodsCollectModel *model = [_dataArr objectAtIndex:indexPath.row];
        model.isChecked = !model.isChecked;
        [self.indexArr addObject:model.gid];
        NSLog(@"=点了==%ld",indexPath.row);
        
        [tableView reloadData];
    }
   
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //编辑设置成自定义的必须把系统的设置为None
    
        return UITableViewCellEditingStyleDelete;
   
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    可编辑
    return YES;
    
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    设置进入编辑状态的时候，cell不会缩进
    return NO;
    
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作

    TJGoodsCollectModel *model = self.dataArr[indexPath.row];
    
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:model.itemid];
    NSString *strGid = arr.mj_JSONString;
    NSString *a = [strGid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":@"1",
                                @"gid":a,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    DSLog(@"--%@==str=sign=%@=",strGid,md5Str);

    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = CancelGoodsCollect;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{
                               @"gid":strGid,
                                  @"type":@"1",};
    } onSuccess:^(id  _Nullable responseObject) {
//        NSLog(@"-delete-success-===%@",responseObject);
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"取消成功！"];
            [self.goodsTabView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        DSLog(@"--error%@",error);
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"-delete-≈≈error-msg=======dict%@",dic_err);
    }];
}

- (NSMutableArray *)indexArr{
    if (!_indexArr) {
        _indexArr = [NSMutableArray array];
    }
    return _indexArr;
}
@end
