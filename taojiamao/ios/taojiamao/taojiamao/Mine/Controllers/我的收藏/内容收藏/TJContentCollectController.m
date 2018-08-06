
//
//  TJContentCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJContentCollectController.h"
#import "TJContentListCell.h"
#import "TJNoImageCell.h"
#import "TJBigImageCell.h"
#import "TJThreeImageCell.h"
#import "TJContetenCollectListModel.h"
@interface TJContentCollectController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TJContentCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;

    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJContentListCell" bundle:nil] forCellReuseIdentifier:@"smallimgCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJNoImageCell" bundle:nil] forCellReuseIdentifier:@"noimgCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJBigImageCell" bundle:nil] forCellReuseIdentifier:@"bigimgCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJThreeImageCell" bundle:nil] forCellReuseIdentifier:@"threeimgCell"];

    [self.view addSubview:tableView];
    self.contentTabView = tableView;
}
#pragma mark - tableViewDelagte
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJContetenCollectListModel *model = self.dataArr[indexPath.row];
    if ([model.show_type intValue]==0) {
        return 70;
    }else if([model.show_type intValue]==1){
        return 100;
    }else if([model.show_type intValue]==2){
        return 250;
    }else{
        return 155;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJContetenCollectListModel *model = self.dataArr[indexPath.row];
    if ([model.show_type intValue]==1) {
        
        TJContentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallimgCell" forIndexPath:indexPath];
        [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_contentEditStatus];
        return cell;
        
    }else if([model.show_type intValue]==2){
         TJBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bigimgCell" forIndexPath:indexPath];
        [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_contentEditStatus];

        return cell;
    }else if([model.show_type intValue]==3){
        TJThreeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeimgCell" forIndexPath:indexPath];
        
        [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_contentEditStatus];
        return cell;
    }else{
        TJNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noimgCell" forIndexPath:indexPath];
        [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_contentEditStatus];
        return cell;
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //编辑设置成自定义的必须把系统的设置为None
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_contentEditStatus) {
        TJContetenCollectListModel *model = [_dataArr objectAtIndex:indexPath.row];
        model.isChecked = !model.isChecked;
        NSLog(@"=点了==%ld",indexPath.row);
        [tableView reloadData];
        }
}
//侧滑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        NSLog(@"单行neirong取消收藏");
    TJContetenCollectListModel *model = self.dataArr[indexPath.row];
    
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:model.gid];
    NSString *strGid = arr.mj_JSONString;
    NSString *a = [strGid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":@"2",
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
                               @"type":@"2",};
    } onSuccess:^(id  _Nullable responseObject) {
                
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"取消成功！"];
            [self.contentTabView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        DSLog(@"--error%@",error);
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"-delete-≈≈error-msg=======dict%@",dic_err);
    }];
    
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}
@end
