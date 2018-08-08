//
//  TJAddEditAddressController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAddEditAddressController.h"

#define OVERGO 746910

@interface TJAddEditAddressController ()<TJButtonDelegate>

@property(nonatomic,assign)BOOL edit;

@property(nonatomic,strong)UIView * headView;

@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)UIView * nameLine;

@property(nonatomic,strong)UILabel * phoneLabel;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UIView * phoneLine;

@property(nonatomic,strong)UILabel * areaLabel;
@property(nonatomic,strong)UILabel * areaPicker;
@property(nonatomic,strong)UIImageView * jj;
@property(nonatomic,strong)UIView * areaLine;

@property(nonatomic,strong)UILabel * detailsLabel;
@property(nonatomic,strong)YYTextView * details;

@property(nonatomic,strong)NSArray * areas;

@property(nonatomic,strong)TJButton * sure;

@end

@implementation TJAddEditAddressController

-(void)setModel:(TJMyAddressModel *)model{
    _model = model;
    self.edit = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.edit?@"编辑收货地址":@"添加收货地址";
    self.view.backgroundColor = RGB(245, 245, 245);

    [self setAllUIRiTNN];
//    [self showModel];
}
-(void)showModel{
    if (self.edit) {
        self.nameField.text = self.model.name;
        self.phoneField.text = self.model.tel;
//        self.areaPicker.text = self.model.full_address;
        self.details.text = self.model.address;
    }
}
-(void)setAllUIRiTNN{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, S_W, 267*H_Scale)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    WeakSelf
    self.nameLabel = [self setLabelWith:@"姓名" font:15*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17*H_Scale);
        make.left.mas_equalTo(20*W_Scale);
    }];
    
    self.nameField = [[UITextField alloc]init];
//    self.nameField.backgroundColor = [UIColor grayColor];
    self.nameField.placeholder = @"请输入姓名";
    self.nameField.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.headView addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.nameLabel);
        make.right.mas_equalTo(-20*W_Scale);
        make.width.mas_equalTo(243*W_Scale);
        make.height.mas_equalTo(25*H_Scale);
    }];
    
    self.nameLine = [[UIView alloc]init];
    self.nameLine.backgroundColor = RGB(217, 217, 217);
    [self.headView addSubview:self.nameLine];
    [self.nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(17*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(1);
    }];
    
    self.phoneLabel = [self setLabelWith:@"联系电话" font:15*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLine.mas_bottom).offset(17*H_Scale);
        make.left.mas_equalTo(weakSelf.nameLabel);
    }];
    
    self.phoneField = [[UITextField alloc]init];
//    self.phoneField.backgroundColor = [UIColor grayColor];

    self.phoneField.placeholder = @"请输入电话号码";
    self.phoneField.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.headView addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(weakSelf.nameField);
        make.centerY.mas_equalTo(weakSelf.phoneLabel);
    }];
    
    self.phoneLine = [[UIView alloc]init];
    self.phoneLine.backgroundColor = RGB(217, 217, 217);
    [self.headView addSubview:self.phoneLine];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneField.mas_bottom).offset(17*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
        make.height.width.mas_equalTo(weakSelf.nameLine);
    }];
    
    self.areaLabel = [self setLabelWith:@"所在地区" font:15*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.areaLabel];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.phoneLabel);
        make.top.mas_equalTo(weakSelf.phoneLine.mas_bottom).offset(17*H_Scale);
    }];
    
    self.areaPicker = [[UILabel alloc]init];
    self.areaPicker.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseArea)];
    [self.areaPicker addGestureRecognizer:tapGR];
    self.areaPicker.text= @"省市县选择";
    self.areaPicker.textColor = RGB(217, 217, 217);

    self.areaPicker.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.headView addSubview:self.areaPicker];
    [self.areaPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(weakSelf.nameField);
        make.centerY.mas_equalTo(weakSelf.areaLabel);
        make.height.mas_equalTo(45*H_Scale);
    }];
    
    self.jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    [self.headView addSubview:self.jj];
    [self.jj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.mas_equalTo(weakSelf.areaPicker);
        make.width.mas_equalTo(6*W_Scale);
        make.height.mas_equalTo(11*H_Scale);
        make.right.mas_equalTo(-30*W_Scale);
    }];
    
    self.areaLine = [[UIView alloc]init];
    self.areaLine.backgroundColor = RGB(217, 217, 217);
    [self.headView addSubview:self.areaLine];
    [self.areaLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.areaLabel.mas_bottom).offset(17*H_Scale);
        make.centerX.mas_equalTo(weakSelf.headView);
        make.height.width.mas_equalTo(weakSelf.nameLine);
    }];
    
    self.detailsLabel = [self setLabelWith:@"详细地址" font:15*W_Scale color:RGB(51, 51, 51)];
    [self.headView addSubview:self.detailsLabel];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.phoneLabel);
        make.top.mas_equalTo(weakSelf.areaLine.mas_bottom).offset(17*H_Scale);
    }];
    
    self.details = [[YYTextView alloc]init];
//    self.details.backgroundColor = RGB(51, 51, 51);
    self.details.placeholderText = @"请输入详细地址";
    self.details.placeholderFont = [UIFont systemFontOfSize:15*W_Scale];
    self.details.font = [UIFont systemFontOfSize:15*W_Scale];
    [self.headView addSubview:self.details];
    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.phoneField);
        make.top.mas_equalTo(weakSelf.areaLine.mas_bottom).offset(14*H_Scale);
        make.width.mas_equalTo(weakSelf.nameField);
        make.height.mas_equalTo(66*H_Scale);
    }];
    
    self.sure = [[TJButton alloc]initWith:@"完成" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:KKDRGB tag:OVERGO cornerRadius:6.0];
    [self.view addSubview:self.sure];
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headView.mas_bottom).offset(40*H_Scale);
//        make.centerX.mas_equalTo(weakSelf.view);
//        make.width.mas_equalTo(335*W_Scale);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44*H_Scale);
    }];
}
-(void)buttonClick:(UIButton *)but{
    DSLog(@"%@--%@--%@--%lu",self.nameField.text,self.phoneField.text,self.details.text,(unsigned long)self.areas.count);
    if (self.nameField.text.length<=0 || self.phoneField.text.length<=0 || self.details.text.length<=0 ||self.areas.count==0) {
        DSLog(@"有选项为空");
    }else{
        if ([TJOverallJudge judgeMobile:self.phoneField.text]) {
            
            NSDictionary * dict =@{
                                   @"uid":GetUserDefaults(UID),
                                   @"province_id":self.areas[0],
                                   @"city_id":self.areas[1],
                                   @"area_id":self.areas[2],
                                   @"nickname":self.nameField.text,
                                   @"tel":self.phoneField.text,
                                   @"address":self.details.text,
                                   };
            NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:dict];
            if (self.edit) {
                DSLog(@"编辑");
                [mdict setValue:self.model.id forKey:@"id"];
//                [XDNetworking postWithUrl:UserUpdateAddress refreshRequest:NO cache:NO params:mdict progressBlock:nil successBlock:^(id response) {
//                    DSLog(@"编辑成功");
//                    [self.navigationController popViewControllerAnimated:YES];
//                } failBlock:^(NSError *error) {
//                    DSLog(@"%@",error);
//                }];
            }else{
                DSLog(@"添加");
//                [XDNetworking postWithUrl:UserAddAddress refreshRequest:NO cache:NO params:dict progressBlock:nil successBlock:^(id response) {
//                    DSLog(@"添加成功");
//                    [self.navigationController popViewControllerAnimated:YES];
//                } failBlock:^(NSError *error) {
//                    DSLog(@"%@",error);
//                }];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"手机号格式不正确"];
            DSLog(@"手机号格式不正确");
        }
    }
}

-(void)chooseArea{
    [self.view endEditing:YES];
    WeakSelf
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"河北省-石家庄市-裕华区" title:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
        
            weakSelf.areaPicker.textColor = RGB(51, 51, 51);
            
       
        weakSelf.areaPicker.text = address;
        NSArray* array = [zipcode componentsSeparatedByString:@"-"];
        self.areas = array;
    } cancelBlock:^{
        
    }];
}
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}
-(NSArray *)areas{
    if (!_areas) {
        _areas = [NSArray array];
    }
    return _areas;
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
