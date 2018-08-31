
//
//  TJAddAddressController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAddAddressController.h"
#import "TJKdChooseSchoolController.h"
#import "TJMyAddressModel.h"
#import "TJMySchoolListModel.h"
@interface TJAddAddressController ()<UITextFieldDelegate,ChooseSchoolControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,assign)BOOL edit;
@property (nonatomic, strong) NSString *schoolID;
@property (nonatomic, strong) UIView *view_bg;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_sex;
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_school;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;


@end

@implementation TJAddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.edit?@"编辑收货地址":@"添加收货地址";
    [self showModel];
    self.tf_school.delegate = self;
    self.tf_sex.delegate = self;
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.tf_name.text.length<=0 || self.tf_phone.text.length<=0 || self.tf_sex.text.length<=0 || self.tv_content.text.length<=0 ||self.tf_school.text.length<=0) {
        [SVProgressHUD showInfoWithStatus:@"输入不能为空！"];

    }else{
        if ([TJOverallJudge judgeMobile:self.tf_phone.text]) {
            NSString *userid = GetUserDefaults(UID);
            if (userid) {
            }else{
                userid = @"";
            }
            KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
            NSString *timeStr = [MD5 timeStr];
            NSString *name = [self.tf_name.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *content = [self.tv_content.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *sex;
            if ([self.tf_sex.text isEqualToString:@"女"]) {
                sex = @"1";
            }else{
                sex = @"2";
            }
            if (self.edit) {
                NSMutableDictionary *md = @{
                                            @"timestamp": timeStr,
                                            @"app": @"ios",
                                            @"uid":userid,
                                            @"name":name,
                                            @"sex":sex,
                                            @"telephone":self.tf_phone.text,
                                            @"school_id":self.schoolID,
                                            @"address":content,
                                            @"id":self.model.id,

                                            }.mutableCopy;
                
                NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
//                编辑
                [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                    request.url = EditAddress;
                    request.headers = @{@"timestamp": timeStr,
                                        @"app": @"ios",
                                        @"sign":md5Str,
                                        @"uid":userid,
                                        };
                    request.parameters = @{
                                           @"name":self.tf_name.text,
                                           @"sex":sex,
                                           @"telephone":self.tf_phone.text,
                                           @"school_id":self.schoolID,
                                           @"address":self.tv_content.text,
                                           @"id":self.model.id,
                                           };
                    request.httpMethod = kXMHTTPMethodPOST;
                } onSuccess:^(id  _Nullable responseObject) {
//                    NSLog(@"----edit+++address-success-===%@",responseObject);
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];

                    [self.navigationController popViewControllerAnimated:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });
                    
                } onFailure:^(NSError * _Nullable error) {
                }];
                
            }else{
                NSMutableDictionary *md = @{
                                            @"timestamp": timeStr,
                                            @"app": @"ios",
                                            @"uid":userid,
                                            @"name":name,
                                            @"sex":sex,
                                            @"telephone":self.tf_phone.text,
                                            @"school_id":self.schoolID,
                                            @"address":content,
                                            }.mutableCopy;
                
                NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
//                DSLog(@"-sign---%@",md5Str);
//                添加
                [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                    request.url = AddAddress;
                    request.headers = @{@"timestamp": timeStr,
                                        @"app": @"ios",
                                        @"sign":md5Str,
                                        @"uid":userid,
                                        };
                    request.parameters = @{
                                           @"name":self.tf_name.text,
                                           @"sex":sex,
                                           @"telephone":self.tf_phone.text,
                                           @"school_id":self.schoolID,
                                           @"address":self.tv_content.text,
                                           };
                    request.httpMethod = kXMHTTPMethodPOST;
                } onSuccess:^(id  _Nullable responseObject) {
                    [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });
                    
                } onFailure:^(NSError * _Nullable error) {
                    NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
                    [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
                }];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"手机号格式不正确!"];

        }
    }
}


-(void)setModel:(TJMyAddressModel *)model{
    _model = model;
    self.edit = YES;
}
-(void)showModel{
    if (self.edit) {
        self.tf_name.text = self.model.name;
        self.tf_phone.text = self.model.telephone;
//        self.details.text = self.model.address;
    }
}

#pragma mark - textfeildDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag==555) {
//        性别
        DSLog(@"性别");
        UIView *bgView = [[UIView alloc]initWithFrame:S_F];
        bgView.backgroundColor = RGBA(51, 51, 51, 0.2);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
        [bgView addGestureRecognizer:tap];
        [self.view addSubview:bgView];
        self.view_bg = bgView;
        
        UIPickerView *pickerV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, S_H-200, S_W, 200)];
        pickerV.delegate  = self;
        pickerV.dataSource =self;
        pickerV.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:pickerV];
    }else{
//        学校
        DSLog(@"学校");
        TJKdChooseSchoolController *vc = [[TJKdChooseSchoolController alloc]init];
        vc.delegate = self;
        [self.navigationController  pushViewController:vc animated:YES];
    }
    return NO;
}
#pragma mark - ChooseSchoolController代理
- (void)getSchoolInfoValue:(TJMySchoolListModel *)schoolModel{
    self.tf_school.text = schoolModel.name;
    self.schoolID = schoolModel.id;
}

#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return 1;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @[@"男",@"女"][row];
}
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"HANG%ld",row);
    self.tf_sex.text = @[@"男",@"女"][row];
}
- (void)removeView:(UITapGestureRecognizer *)tap
{
    [self.view_bg removeFromSuperview];
}
@end
