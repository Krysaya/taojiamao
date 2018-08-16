
//
//  TJFaBuController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJFaBuController.h"

//#import "PGPickerView.h"

#import "TJOrderPayController.h"//支付
#import "TJKdQuAddressController.h"//取件
#import "TJMyAddressController.h"//送件


#import "TJAdressCell.h"
#import "TJAdressTwoCell.h"
#import "TJTextFiledCell.h"

#import "TJPostageMoneyCell.h"//加急

#import "TJMyAddressModel.h"
#import "TJKdQuAddressModel.h"
#import "TJKdOrderInfoModel.h"
@interface TJFaBuController ()<UITableViewDelegate,UITableViewDataSource,AddressControllerDelegate,QuAddressControllerDelegate,UITextFieldDelegate>
@property(nonatomic,assign)BOOL edit;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *view_bg;

@property (nonatomic, strong) TJMyAddressModel *m_song;
@property (nonatomic, strong) TJKdQuAddressModel *m_qu;

@end

@implementation TJFaBuController
-(void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
    self.edit = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.edit?@"修改订单":@"发布订单";

    self.view.backgroundColor = KBGRGB;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-120) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor  = KBGRGB;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressCell" bundle:nil] forCellReuseIdentifier:@"AdressCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJAdressTwoCell" bundle:nil] forCellReuseIdentifier:@"AdressTwoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJTextFiledCell" bundle:nil] forCellReuseIdentifier:@"TextFiledCell"];
     [tableView registerNib:[UINib nibWithNibName:@"TJKdChooseTimeCell" bundle:nil] forCellReuseIdentifier:@"KdChooseTimeCell"];
    [tableView registerNib:[UINib nibWithNibName:@"TJPostageMoneyCell" bundle:nil] forCellReuseIdentifier:@"PostageMoneyCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, S_H-80, S_W-20, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnClick:(UIButton *)sender
{

//    支付
    TJOrderPayController *vc = [[TJOrderPayController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 100;
    }else if (indexPath.row==1){
        return 80;
    }else if (indexPath.row==5){
        return 210;
    }else{
        return 60;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        TJAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressCell"];
        cell.type = @"fb";
        cell.m_fb = self.m_song;
        return cell;
    }else if (indexPath.row==1){
        
    TJAdressTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressTwoCell"];
        cell.type = @"fb";
        cell.m_qu = self.m_qu;
        return cell;
    } else if (indexPath.row==2||indexPath.row==3){
        TJTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFiledCell"];
        cell.type = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        return cell;
    }
    else {
        TJPostageMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostageMoneyCell"];
        return cell;
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        DSLog(@"送件地址");
        TJMyAddressController *vc = [[TJMyAddressController alloc]init];
        vc.delegate =self;
        vc.type = @"fb";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        DSLog(@"qu件--%@",self.m_song.school_id);
        if (self.m_song.school_id.length<=0) {
            [SVProgressHUD showInfoWithStatus:@"请先选择送件地址！"];
        }else{
        TJKdQuAddressController *vc = [[TJKdQuAddressController alloc]init];
        vc.delegate = self;
        vc.schoolID = self.m_song.school_id;
        [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark - tfdelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UIView *bgView = [[UIView alloc]initWithFrame:S_F];
    bgView.backgroundColor = RGBA(51, 51, 51, 0.2);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
    [bgView addGestureRecognizer:tap];
    [self.view addSubview:bgView];
    self.view_bg = bgView;
    if (textField.tag==88) {
//        月日
       
        
    }
   
    
    return NO;
}
#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 7;
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
    
}
- (void)removeView:(UITapGestureRecognizer *)tap
{
    [self.view_bg removeFromSuperview];
}

#pragma mark -vc- delegate
- (void)getSongAddressInfoValue:(TJMyAddressModel *)addressModel{
    self.m_song = addressModel;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
}
- (void)getQuAddressInfoValue:(TJKdQuAddressModel *)addressModel{
    self.m_qu = addressModel;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
}
@end
