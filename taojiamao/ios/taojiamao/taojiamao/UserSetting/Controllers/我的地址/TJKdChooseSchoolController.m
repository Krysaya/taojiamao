
//
//  TJKdChooseSchoolController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdChooseSchoolController.h"
#import "TJChooseAreaCell.h"
#import "TJAreaListModel.h"

#import "ZYPinYinSearch.h"
#import "HCSortString.h"

#import "PGPickerView.h"
@interface TJKdChooseSchoolController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PGPickerViewDelegate,PGPickerViewDataSource>
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/

@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/

@property (nonatomic, strong) NSMutableArray *areaArr;//地区
@property (strong, nonatomic) UITableView  *tableView;

@end

@implementation TJKdChooseSchoolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所在学校";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"TJChooseAreaCell" bundle:nil] forCellReuseIdentifier:@"ChooseAreaCell"];
    [self.view addSubview:tableView];
    [self loadRequestAeraList];
}

- (void)loadKdSchoolListWithPic:(NSString *)pid{
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
                                @"int":pid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = SchoolList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"int":pid,
                                };
    } onSuccess:^(id  _Nullable responseObject) {
       
                DSLog(@"----学校---%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        
    }];
    
}

- (void)loadRequestAeraList{
    self.areaArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = AllAreasList;
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"data"];
      
            TJAreaListModel *model = [TJAreaListModel mj_objectWithKeyValues:dict];
            [self.areaArr addObject:model.name];
        
        dispatch_async(dispatch_get_main_queue(), ^{

        });
        
    } onFailure:^(NSError * _Nullable error) {
    }];
}
#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 3; }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section==0) {
        TJChooseAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseAreaCell"];
        cell.tf.delegate = self;
        return cell;
    }else{
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        }
        return cell;
    }
}

#pragma mark - textfiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //写你要实现的：页面跳转的相关代码
    PGPickerView *pickerV = [[PGPickerView alloc]initWithFrame:CGRectMake(0, 0, S_W, 200)];
    pickerV.delegate = self;
    pickerV.dataSource = self;
    pickerV.type = PGPickerViewType2;
    pickerV.rowHeight = 40;
    pickerV.isHiddenMiddleText = false;
    //设置线条的颜色
    pickerV.lineBackgroundColor = [UIColor redColor];
    //设置选中行的字体颜色
    pickerV.textColorOfSelectedRow = [UIColor blueColor];
    //设置未选中行的字体颜色
    pickerV.textColorOfOtherRow = [UIColor blackColor];
    [self.view addSubview:pickerV];
    return NO;
}

#pragma mark - pickerDelegate
- (NSInteger)numberOfComponentsInPickerView:(PGPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(PGPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.areaArr.count;
}
- (nullable NSString *)pickerView:(PGPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
       
        return self.areaArr[component];
    }
   
    return self.areaArr[component];
}

- (void)pickerView:(PGPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"row = %ld component = %ld", row, component);
}

@end
