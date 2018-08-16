

//
//  TJKdFabuController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdFabuController.h"
#import "PGDatePickManager.h"
#import "TJKdChooseSchoolController.h"
#import "TJKdOrderInfoModel.h"
#import "TJMySchoolListModel.h"
#import "TJMyAddressModel.h"
#import "TJKdQuAddressModel.h"

#import "TJOrderPayController.h"//支付
#import "TJKdQuAddressController.h"//取件
#import "TJMyAddressController.h"//送件

#define SJ_Address  20
#define QJ_Address  21
#define Start_time  30
#define End_time  31
#define JiaJiButton 40
#define BuJiaJiButton 41
#define OneButton  101
#define TwoButton  102
#define ThreeButton 103
#define FourButton 104
#define FiveButton 105
#define SixButton 110


@interface TJKdFabuController ()<UITextFieldDelegate,AddressControllerDelegate,QuAddressControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,PGDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_song;
@property (weak, nonatomic) IBOutlet UIView *view_qu;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_phone;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UILabel *lab_quAddress;
@property (weak, nonatomic) IBOutlet UITextField *tf_nums;
@property (weak, nonatomic) IBOutlet UITextField *tf_qjm;
@property (weak, nonatomic) IBOutlet UITextField *tf_day;
@property (weak, nonatomic) IBOutlet UITextField *tf_starttime;
@property (weak, nonatomic) IBOutlet UITextField *tf_endtime;
@property (weak, nonatomic) IBOutlet UIButton *btn_jj;
@property (weak, nonatomic) IBOutlet UIButton *btn_bjj;
@property (weak, nonatomic) IBOutlet UIView *view_jj;
@property (weak, nonatomic) IBOutlet UIButton *btn_one;
@property (weak, nonatomic) IBOutlet UIButton *btn_two;
@property (weak, nonatomic) IBOutlet UIButton *btn_three;
@property (weak, nonatomic) IBOutlet UIButton *btn_four;
@property (weak, nonatomic) IBOutlet UIButton *btn_five;
@property (weak, nonatomic) IBOutlet UIButton *btn_six;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;



@property(nonatomic,assign)BOOL edit;
@property (nonatomic, strong) TJMyAddressModel *m_song;
@property (nonatomic, strong) TJKdQuAddressModel *m_qu;
@property (nonatomic, strong) UIButton *btnjj_select;
@property (nonatomic, strong) UIButton *btnjjf_select;
@property (nonatomic, strong) UIView *view_bg;

@property (nonatomic, strong) NSArray *hourArr;
@property (nonatomic, strong) NSArray *minArr;

@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *min;
@property (nonatomic, strong) NSString *start_hour;
@property (nonatomic, strong) NSString *end_hour;
@property (nonatomic, strong) NSString *start_min;
@property (nonatomic, strong) NSString *end_min;

@end

@implementation TJKdFabuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hourArr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    self.minArr = @[@"00",@"30"];
    self.title = self.edit?@"修改订单":@"发布订单";
    UITapGestureRecognizer *songTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(songAddress)];
    [self.view_song addGestureRecognizer:songTap];
    UITapGestureRecognizer *quTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quAddress)];
    [self.view_qu addGestureRecognizer:quTap];
   
    [self showModel];
    
   
    self.tf_day.delegate  = self;
    self.tf_starttime.delegate = self;
    self.tf_endtime.delegate = self;
 
    
}
-(void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    self.edit = YES;
}
-(void)showModel{
    if (self.edit) {
        self.lab_name.text = self.model.name;
        self.lab_phone.text = self.model.daili_telephone;
//        self.lab_address.text = self.model
        //        self.details.text = self.model.address;
    }else{
        if (self.m_song==nil) {
            self.lab_address.text = @"请选择送件地址";
        }if (self.m_qu==nil) {
            self.lab_quAddress.text = @"请选择取件地址";
        }
        self.btnjj_select = self.btn_jj;
        self.btnjjf_select = self.btn_one;

    }
}
#pragma mark - tfdelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   

    if (textField.tag==29) {
        DSLog(@"月日");
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.isShadeBackgroud = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType1;
        datePicker.isHiddenMiddleText = true;
        datePicker.datePickerMode = PGDatePickerModeMonthDay;
        [self presentViewController:datePickManager animated:false completion:nil];
        
    }else {
        DSLog(@"time");
        UIView *bgView = [[UIView alloc]initWithFrame:S_F];
        bgView.backgroundColor = RGBA(51, 51, 51, 0.2);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
        [bgView addGestureRecognizer:tap];
        [self.view addSubview:bgView];
        self.view_bg = bgView;
        
        UIPickerView *timePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, S_H-200, S_W, 200)];
        timePicker.backgroundColor = [UIColor whiteColor];
        timePicker.delegate = self;
        timePicker.dataSource = self;
        [bgView addSubview:timePicker];
        if (textField.tag==30) {
            timePicker.tag = 111;

        }else{
            timePicker.tag = 112;

        }
        
        
    }
  
    return NO;
}
#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==1){
        return 2;
    }
    return self.hourArr.count;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [self.hourArr objectAtIndex:row];
    }else{
        return [self.minArr objectAtIndex:row];
    }
}
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
    if (component==0) {
        self.hour = self.hourArr[row];
    }else{
        self.min = self.minArr[row];
    }
    
    DSLog(@"--%@-%@",self.hour,self.min);
    if (self.hour.length<=0||self.min.length<=0) {
        
    }else{
        if (pickerView.tag==111) {
            self.tf_starttime.text = [NSString stringWithFormat:@"%@:%@",self.hour,self.min];
            self.start_hour = self.hour;
            self.start_min = self.min;
        }else{
            self.tf_endtime.text = [NSString stringWithFormat:@"%@:%@",self.hour,self.min];
            self.end_hour = self.hour;
            self.end_min = self.min;
        }
    }
}

#pragma mark - 点击选择送件地址
- (void)songAddress{
    DSLog(@"送件地址");
    TJMyAddressController *vc = [[TJMyAddressController alloc]init];
    vc.delegate =self;
    vc.type = @"fb";
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)quAddress{
    DSLog(@"qu件--%@",self.m_song.school_id);
    if (self.m_song.school_id.length<=0) {
        [SVProgressHUD showInfoWithStatus:@"请先选择送件地址！"];
    }else{
        TJKdQuAddressController *vc = [[TJKdQuAddressController alloc]init];
        vc.delegate = self;
        vc.schoolID = self.m_song.school_id;
        [self.navigationController pushViewController:vc animated:YES];}
    
}
- (IBAction)jiaJiBtnClick:(UIButton *)sender {
    if (!sender.selected) {
        self.btnjj_select.selected = !self.btnjj_select.selected;
        sender.selected = !sender.selected;
        self.btnjj_select = sender;
    }
    
    if (sender.tag==JiaJiButton) {
//
        self.bottomViewHeight.constant = 200.f;
        self.view_jj.hidden = NO;
    }else{
        self.view_jj.hidden = YES;
        self.bottomViewHeight.constant = 60.f;
    }
}
- (IBAction)chooseJiaJiFee:(UIButton *)sender {
    if (!sender.selected) {
        self.btnjjf_select.selected = !self.btnjjf_select.selected;
        sender.selected = !sender.selected;
        self.btnjjf_select = sender;
    }
}

#pragma mark - 提交
- (IBAction)takeInfoBtnClick:(UIButton *)sender {
    if (self.tf_nums.text.length<=0 || self.tf_qjm.text.length<=0 || self.tf_day.text.length<=0 || self.tf_starttime.text.length<=0 ||self.tf_endtime.text.length<=0) {
                [SVProgressHUD showInfoWithStatus:@"输入不能为空！"];
            }else{
                if (![TJOverallJudge judgeNumInputShouldNumber:self.tf_qjm.text]||![TJOverallJudge judgeNumInputShouldNumber:self.tf_nums.text]){
                    //判断取件码
                    [SVProgressHUD showInfoWithStatus:@"只能输入数字！"];
                }else{
                    NSString *userid = GetUserDefaults(UID);
                    if (userid) {
                    }else{
                        userid = @"";
                    }
                    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
                    NSString *timeStr = [MD5 timeStr];
                    NSString *kd = [@"圆通快递" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    
//
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                    [formatter setLocale:[NSLocale currentLocale]];
//                    [formatter setDateFormat:@"yyyyMdHHmm"];
                    
                    NSString *star = [NSString stringWithFormat:@"%@%@%@%@%@",self.year,self.month,self.day,self.start_hour,self.start_min];
//                    NSDate *date_star = [formatter dateFromString:star];

                    NSString *starttime = [self  timeAppendNSString:star];
                   
                    
                    
                    NSString *end = [NSString stringWithFormat:@"%@%@%@%@%@",self.year,self.month,self.day,self.end_hour,self.end_min];
                    NSString *endtime = [self timeAppendNSString:end];
                    DSLog(@"--start--%@===%@==end==%@==%@",starttime,star,endtime,end);

                    NSString *jiaji;
                    if (self.btnjj_select.tag==JiaJiButton) {
                        jiaji = [NSString stringWithFormat:@"%ld",self.btnjj_select.tag-100];
                        DSLog(@"---%ld--%@",self.btnjj_select.tag-100,jiaji);
                    }else{
                        jiaji = @"0";
                    }
                    if (self.edit) {
                        //                        修改订单
                    }else{
                        //                        发布订单
                        NSMutableDictionary *md = @{
                                                    @"timestamp": timeStr,
                                                    @"app": @"ios",
                                                    @"uid":userid,
                                                    @"shou_id":self.m_song.id,
                                                    @"qu_id":self.m_qu.id,
                                                    @"danhao":self.tf_nums.text,
                                                    @"qu_code":self.tf_qjm.text,
                                                    @"song_start_time":starttime,
                                                    @"song_end_time":endtime,
                                                    @"is_ji":jiaji,
                                                    @"dan_company":kd,
                                                    }.mutableCopy;
                        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
                        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                            request.url = KdUserReleaseOrder;
                            request.httpMethod = kXMHTTPMethodPOST;
                            request.headers = @{@"timestamp": timeStr,
                                                @"app": @"ios",
                                                @"sign":md5Str,
                                                @"uid":userid,
                                                };
                            request.parameters = @{@"shou_id":self.m_song.id,     @"qu_id":self.m_qu.id,      @"danhao":self.tf_nums.text,     @"qu_code":self.tf_qjm.text,  @"song_start_time":starttime,      @"song_end_time":endtime,@"is_ji":jiaji, @"dan_company":@"圆通快递",
                                
                                };
                        } onSuccess:^(id  _Nullable responseObject) {
                            DSLog(@"--fbffff-≈≈%@=======",responseObject);
                            //    支付
                            TJOrderPayController *vc = [[TJOrderPayController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                        } onFailure:^(NSError * _Nullable error) {
                                    NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                                    NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
                                    DSLog(@"---≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
                        }];
                    }
                }
                    
                
             
            }
        
    
}

#pragma mark -vc- delegate
 - (void)getSongAddressInfoValue:(TJMyAddressModel *)addressModel{
        self.m_song = addressModel;
        self.lab_name.text = addressModel.name;
        self.lab_address.text =  [NSString stringWithFormat:@"[送件地址]%@",addressModel.address];
        self.lab_phone.text = addressModel.telephone;
}
- (void)getQuAddressInfoValue:(TJKdQuAddressModel *)addressModel{
        self.m_qu = addressModel;
        self.lab_quAddress.text =  [NSString stringWithFormat:@"[取件地址]%@",addressModel.address];
;
 }
- (void)removeView:(UITapGestureRecognizer *)tap
{
    [self.view_bg removeFromSuperview];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *mm  = [NSString stringWithFormat:@"%ld",dateComponents.month];
    NSString *dd  = [NSString stringWithFormat:@"%ld",dateComponents.day];

    self.tf_day.text = [NSString stringWithFormat:@"%ld月%ld日",dateComponents.month,dateComponents.day];
    self.month = [NSString stringWithFormat:@"%ld",dateComponents.month];
    self.day = [NSString stringWithFormat:@"%ld",dateComponents.day];
    self.year = [NSString stringWithFormat:@"%ld",dateComponents.year];

    if (mm.length==1) {
        self.month = [NSString stringWithFormat:@"0%@",mm];
    }if (dd.length==1) {
        self.day = [NSString stringWithFormat:@"0%@",dd];
    }



}
-(NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMdHHmm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
-(NSString *)timeAppendNSString:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate *date = [formatter dateFromString:timeStr];
    DSLog(@"---date--%@",date);
//    NSString *dateStr = [formatter stringFromDate:date];
    NSString *time = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return time;
}
@end
