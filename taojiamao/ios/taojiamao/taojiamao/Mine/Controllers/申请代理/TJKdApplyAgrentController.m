

//
//  TJKdApplyAgrentController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/15.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdApplyAgrentController.h"
#import "TJMySchoolListModel.h"
#import "TJKdApplySchoolController.h"

@interface TJKdApplyAgrentController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,KdApplySchoolControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_sex;
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_yqm;
@property (weak, nonatomic) IBOutlet UITextField *tf_xj;
@property (weak, nonatomic) IBOutlet UITextField *tf_school;
@property (weak, nonatomic) IBOutlet UIButton *tf_photo;

@property (nonatomic, strong) UIView *view_bg;
@property (nonatomic, strong) NSString *schoolID;
@property (nonatomic, strong) NSData *imgData;
@property(nonatomic,strong) UIImagePickerController *imagePicker;


@end

@implementation TJKdApplyAgrentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请代理";
    self.tf_sex.delegate = self;
    self.tf_school.delegate = self;
    
}
- (UIImagePickerController *)imagePicker
{
    if (nil == _imagePicker) {
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

- (IBAction)choosePhoto:(UIButton *)sender {
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"" message:@"选取照片" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark -UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; //通过key值获取到图片
    NSData *fileData1 = UIImageJPEGRepresentation(image, 1.0);
    [self.tf_photo setImage:image forState:UIControlStateNormal];
    self.imgData = fileData1;
    [picker dismissViewControllerAnimated:YES completion:^{}];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag==894) {
        DSLog(@"sex");
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
        
        TJKdApplySchoolController *vc = [[TJKdApplySchoolController alloc]init];
        vc.delegate = self;
        [self.navigationController  pushViewController:vc animated:YES];
    }
    return NO;
}
#pragma mark - ChooseSchoolController代理
- (void)getApplySchoolInfoValue:(TJMySchoolListModel *)schoolModel{
    self.tf_school.text = schoolModel.name;
    self.schoolID = schoolModel.id;
}

- (IBAction)applyAgrentClick:(UIButton *)sender {
//    申请
    if (self.tf_name.text.length<=0 || self.tf_phone.text.length<=0 || self.tf_sex.text.length<=0 || self.tf_xj.text.length<=0 ||self.tf_school.text.length<=0) {
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
        NSString *grade = [self.tf_xj.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *sex;
        if ([self.tf_sex.text isEqualToString:@"女"]) {
            sex = @"1";
        }else{
            sex = @"2";
        }
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"name":name,
                                    @"sex":sex,
                                    @"telephone":self.tf_phone.text,
                                    @"school_id":self.schoolID,
                                    @"invite_code":self.tf_yqm.text,
                                    @"grade":grade,
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = KdApplyAgent;
            request.requestType = kXMRequestUpload;
            request.httpMethod = kXMHTTPMethodPOST;
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
                                   @"invite_code":self.tf_yqm.text,
                                   @"grade":self.tf_xj.text,
                                   };
            [request addFormDataWithName:@"head" fileName:@"aa" mimeType:@"image/jpeg" fileData:self.imgData];

        } onSuccess:^(id  _Nullable responseObject) {
            DSLog(@"msg==%@",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"申请成功"];
            [self.navigationController  popViewControllerAnimated:YES];
            
        } onFailure:^(NSError * _Nullable error) {
            DSLog(@"error==%@",error);

        }];}
        
        }
        
    
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
