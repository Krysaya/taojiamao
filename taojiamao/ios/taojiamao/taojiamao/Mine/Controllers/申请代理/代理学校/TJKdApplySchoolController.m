
//
//  TJKdApplySchoolController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdApplySchoolController.h"
#import "TJChooseAreaCell.h"
#import "TJKdAddSchoolCell.h"
#import "TJAreaListModel.h"
#import "TJMySchoolListModel.h"
#import "ZYPinYinSearch.h"
#import "HCSortString.h"

@interface TJKdApplySchoolController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,TJButtonDelegate>
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/

@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/

@property (nonatomic, strong) NSMutableArray *areaArr;//地区
@property (nonatomic, strong) NSMutableArray *schoolArr;
@property (nonatomic, strong) TJAreaListModel *province;
@property (nonatomic, strong) TJAreaListModel *city;
@property (nonatomic, strong) UIPickerView *pickerV;
@property (strong, nonatomic) UITableView  *tableView;
@property (nonatomic, strong) UIView *pick_View;
@property (nonatomic, strong) UIView *tf_View;
@property (nonatomic, strong) UITextField *tf_school;

@end

@implementation TJKdApplySchoolController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestAeraList];
    [self loadKdSchoolListWithPic:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所在学校";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJChooseAreaCell" bundle:nil] forCellReuseIdentifier:@"ChooseAreaCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJKdAddSchoolCell" bundle:nil] forCellReuseIdentifier:@"KdAddSchoolCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)loadKdSchoolListWithPic:(NSString *)pid{
    self.schoolArr = @{}.mutableCopy;
    self.indexDataSource = [NSArray array];
    self.allDataSource = [NSDictionary dictionary];
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
                                //                                @"int":pid,
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
        
    } onSuccess:^(id  _Nullable responseObject) {
        NSArray *arr = [TJMySchoolListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        self.allDataSource = [HCSortString sortAndGroupForArray:arr PropertyName:@"name"];
        
        self.indexDataSource = [HCSortString sortForStringAry:[self.allDataSource allKeys]];
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
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = AllAreasList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        self.areaArr = [TJAreaListModel mj_objectArrayWithKeyValuesArray:dict];
        
        self.province = [self.areaArr firstObject];
        self.city = [self.province.son firstObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } onFailure:^(NSError * _Nullable error) {
    }];
}
#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexDataSource.count+1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        NSArray *value = [self.allDataSource objectForKey:self.indexDataSource[section-1]];
        return value.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return nil;
    }else{
        return self.indexDataSource[section-1];
        
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexDataSource;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            TJKdAddSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdAddSchoolCell"];
            return cell;
        }else{
            TJChooseAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseAreaCell"];
            cell.tf.delegate = self;
            return cell;
        }
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            NSArray *value = [self.allDataSource objectForKey:self.indexDataSource[indexPath.section-1]];
            TJMySchoolListModel *m = value[indexPath.row];
            cell.textLabel.text = m.name;
        }
        return cell;
    }
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            DSLog(@"添加学校");
            UIView *view = [[UIView alloc]initWithFrame:S_F];
            view.backgroundColor = RGBA(51, 51, 51, 0.2);
            [self.view addSubview:view];
            self.tf_View = view;
            
            UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(20, S_H/2-80, S_W-40, 175)];
            bg.backgroundColor = [UIColor whiteColor];
            bg.layer.masksToBounds = YES;bg.layer.cornerRadius = 6;
            [view addSubview:bg];
            
            UILabel *lab_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, S_W-40, 30)];
            lab_title.text = @"输入学校名称";lab_title.textAlignment = NSTextAlignmentCenter;
            [bg addSubview:lab_title];

            TJButton *btn  = [[TJButton alloc]initWith:@"确定" delegate:self font:15 titleColor:[UIColor whiteColor] backColor:KKDRGB tag:329 cornerRadius:6];
            btn.frame = CGRectMake(S_W-60-40, 10, 50, 27);
            [bg addSubview:btn];
            
            UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, S_W-40, 1)];
            img_line.backgroundColor = RGB(245, 245, 245);
            [bg addSubview:img_line];
            
            UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(30, 80, S_W-40-60, 40)];
            tf.layer.borderColor = RGB(245, 245, 245).CGColor;tf.borderStyle = UITextBorderStyleNone;
            tf.layer.borderWidth = 1.0f;
            [bg addSubview:tf];
            self.tf_school = tf;
        }
    }else{
        NSArray *value = [self.allDataSource objectForKey:self.indexDataSource[indexPath.section-1]];
        TJMySchoolListModel *m = value[indexPath.row];
        //        if (self.delegate&&[self.delegate respondsToSelector:@selector(getArgument:atIndex:)]) {
        [self.delegate getApplySchoolInfoValue:m];
        //        }
        [self.navigationController  popViewControllerAnimated:YES];
    }
}
#pragma mark - textfiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //写你要实现的：页面跳转的相关代码
    UIView *view = [[UIView alloc]initWithFrame:S_F];
    view.backgroundColor = RGBA(51, 51, 51, 0.2);
    [self.view addSubview:view];
    self.pick_View = view;
    
    UIView *bg_view = [[UIView alloc]initWithFrame:CGRectMake(0, S_H-250, S_W, 250)];
    bg_view.backgroundColor = [UIColor whiteColor];
    [view addSubview:bg_view];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, S_W, 30)];
    lab.text = @"选择地区";
    lab.textAlignment = NSTextAlignmentCenter;
    [bg_view addSubview:lab];
    
    TJButton *btn = [[TJButton alloc]initWith:@"确定" delegate:self font:15 titleColor:[UIColor whiteColor] backColor:KKDRGB tag:8934 cornerRadius:2];
    btn.frame = CGRectMake(S_W-60, 8, 50, 27);
    [bg_view addSubview:btn];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, S_W, 0.8)];
    img.backgroundColor = RGB(222, 222, 222);
    [bg_view addSubview:img];
    
    UIPickerView *pickerV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, S_W, 200)];
    pickerV.backgroundColor = [UIColor whiteColor];
    pickerV.delegate = self;
    pickerV.dataSource = self;
    [self pickerView:pickerV didSelectRow:0 inComponent:0];
    
    [bg_view addSubview:pickerV];
    return NO;
}

#pragma mark - pickerDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return self.areaArr.count;
    }else{
        return self.province.son.count;
    }
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        TJAreaListModel *m = self.areaArr[row];
        return m.name;
    }else{
        TJAreaListModel *m = [self.province.son objectAtIndex:row];
        return m.name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.province = self.areaArr[row];
        self.city = self.province.son[0];
        [pickerView reloadComponent:1];
    }else {
        self.city = self.province.son[row];
    }
    
    DSLog(@"--CITYID%@-%@==PID-%@-%@",self.city.name,self.city.id,self.province.name,self.province.id)
}

#pragma mark - button
- (void)buttonClick:(UIButton *)but{
    if (but.tag==8934) {
        [self.pick_View removeFromSuperview];

    }else{

        if (self.city==nil&&self.province==nil) {
            DSLog(@"-55555-CITYID%@-%@==PID-%@-%@",self.city.name,self.city.id,self.province.name,self.province.id)
            [SVProgressHUD showInfoWithStatus:@"请先选择所在地区！"];
            [self.tf_View removeFromSuperview];

        }else{
        NSString *userid = GetUserDefaults(UID);
        if (userid) {
        }else{
            userid = @"";
        }
        NSString *schoolname = [self.tf_school.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"name":schoolname,
                                    @"province_id":self.province.id,
                                    @"city_id":self.city.id,
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = KdAddSchool;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.parameters = @{ @"name":self.tf_school.text,
                                    @"province_id":self.province.id,
                                    @"city_id":self.city.id,};
            request.httpMethod = kXMHTTPMethodPOST;
        } onSuccess:^(id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [self.tf_View removeFromSuperview];
            [self loadKdSchoolListWithPic:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
            });
            
        } onFailure:^(NSError * _Nullable error) {
            [self.tf_View removeFromSuperview];

        }];}

    }
}
@end
