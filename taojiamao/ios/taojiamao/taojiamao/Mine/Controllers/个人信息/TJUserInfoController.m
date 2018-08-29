//
//  TJUserInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/11.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJUserInfoController.h"
#import "TJOrderClaimController.h"

#define UserInfoCell @"UserInfoCell"
#define UserInfoFont  14

@interface TJUserInfoController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation TJUserInfoController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self setUI];
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UserInfoCell];
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UserInfoCell forIndexPath:indexPath];
    if (indexPath.section==0) {
        UILabel * label = [self setLabelWith:@"会员头像" font:UserInfoFont color:RGB(51, 51, 51)];
        UIImageView * icon = [[UIImageView alloc]initWithImage:self.iconImage];
        UIImageView * jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:icon];
        [cell.contentView addSubview:jj];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(21*W_Scale);
        }];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(-56*W_Scale);
            make.height.width.mas_equalTo(50*W_Scale);
        }];
        [jj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(-20*W_Scale);
            make.height.mas_equalTo(11*H_Scale);
            make.width.mas_equalTo(6*W_Scale);
        }];
        
    }else{
        UILabel * name = [self setLabelWith:@"会员昵称" font:UserInfoFont color:RGB(51, 51, 51)];
        UILabel * nick = [self setLabelWith:self.nickName font:UserInfoFont color:RGB(51, 51, 51)];
        UIImageView * jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        
        [cell.contentView addSubview:name];
        [cell.contentView addSubview:nick];
        [cell.contentView addSubview:jj];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(21*W_Scale);
        }];
        [nick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(name.mas_right).offset(17*W_Scale);
        }];
        [jj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(-20*W_Scale);
            make.height.mas_equalTo(11*H_Scale);
            make.width.mas_equalTo(6*W_Scale);
        }];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath.section==0?75*H_Scale:49*H_Scale;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WeakSelf
    if (indexPath.section==0) {
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
    }else{
        DSLog(@"修改昵称");
        TJOrderClaimController * ocvc = [[TJOrderClaimController alloc]init];
        ocvc.changeNick = YES;
        [self.navigationController pushViewController:ocvc animated:YES];
    }
}
#pragma mark -UIImagePickerController
//-(void)imagePickerController{
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
//    // 2. 创建图片选择控制器
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    /**
//     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
//     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
//     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
//     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
//     }
//     */
//    // 3. 设置打开照片相册类型(显示所有相簿)
//    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//     ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    // 照相机
//    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//    ipc.delegate = self;
// 
//    [self presentViewController:ipc animated:YES completion:nil];
//
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; //通过key值获取到图片
    NSData *fileData1 = UIImageJPEGRepresentation(image, 1.0);
//    NSURL *urlimg = [info objectForKey:UIImagePickerControllerImageURL];
    //获取

//    NSLog(@"===选中图片===length————%ld==%@",fileData1.length,fileData1);
       //上传图片到服务器--在这里进行图片上传的网络请求
    NSNumber * uid = GetUserDefaults(UID);
    NSString *userid = [NSString stringWithFormat:@"%@",uid];
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
    NSLog(@"md=======%@===time=%@==uid=%@==",md5Str,timeStr,userid);
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = UploadHeaderImg;
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;charset=utf-8;"];
        
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            
                            };
//        [request addFormDataWithName:@"head[]" fileData:fileData1];
//        [request addFormDataWithName:<#(nonnull NSString *)#> fileName:<#(nonnull NSString *)#> mimeType:<#(nonnull NSString *)#> fileData:<#(nonnull NSData *)#>];
        [request addFormDataWithName:@"head" fileName:@"aa" mimeType:@"image/jpeg" fileData:fileData1];
        
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestType = kXMRequestUpload;
    } onSuccess:^(id  _Nullable responseObject) {
        
        NSLog(@"----上传照片-success-===%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"上传成功！"];
        [picker dismissViewControllerAnimated:YES completion:^{}];

    } onFailure:^(NSError * _Nullable error) {
//        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
//        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--上传照片≈error-msg=======dict%@",error);
        [picker dismissViewControllerAnimated:YES completion:^{}];

    }];
   
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];

}

#pragma makr -setlabel
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
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
@end
