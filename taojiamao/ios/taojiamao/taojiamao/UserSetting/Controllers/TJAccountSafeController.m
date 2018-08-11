//
//  TJAccountSafeController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/14.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAccountSafeController.h"
#import "TJChangePhoneController.h"

#define TJAccountSafeCell @"TJAccountSafeCell"
#define AccountSafeFont 14*W_Scale

@interface TJAccountSafeController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation TJAccountSafeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户安全";
    [self setUI];
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TJAccountSafeCell];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TJAccountSafeCell forIndexPath:indexPath];
    if (indexPath.section==0) {
        UILabel * intro = [self setLabelWith:@"修改手机号" font:AccountSafeFont color:RGB(51, 51, 51)];
//        UILabel * phone = [self setLabelWith:GetUserDefaults(UserPhone) font:AccountSafeFont color:RGB(128, 128, 128)];
        UILabel * phone = [self setLabelWith:self.phone font:AccountSafeFont color:RGB(128, 128, 128)];
        UIImageView * jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        
        [cell.contentView addSubview:intro];
        [cell.contentView addSubview:phone];
        [cell.contentView addSubview:jj];
        
        [intro mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(20*W_Scale);
        }];
        [jj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(-20*W_Scale);
            make.height.mas_equalTo(11*H_Scale);
            make.width.mas_equalTo(6*W_Scale);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(jj.mas_left).offset(-15*W_Scale);
        }];
        
    }else if(indexPath.section==1){
        UILabel * intro = [self setLabelWith:@"设置提现账户" font:AccountSafeFont color:RGB(51, 51, 51)];
        UILabel * phone = [self setLabelWith:@"未设置" font:AccountSafeFont color:RGB(128, 128, 128)];
        UIImageView * jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        
        [cell.contentView addSubview:intro];
        [cell.contentView addSubview:phone];
        [cell.contentView addSubview:jj];
        
        [intro mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(20*W_Scale);
        }];
        [jj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(-20*W_Scale);
            make.height.mas_equalTo(11*H_Scale);
            make.width.mas_equalTo(6*W_Scale);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(jj.mas_left).offset(-15*W_Scale);
        }];
    }else{
        UILabel * intro = [self setLabelWith:@"修改密码" font:AccountSafeFont color:RGB(51, 51, 51)];
        UIImageView * jj = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        
        [cell.contentView addSubview:intro];
        [cell.contentView addSubview:jj];
        
        [intro mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(20*W_Scale);
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
    
    return 47*H_Scale;
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
 
    TJChangePhoneController * cpvc = [[TJChangePhoneController alloc]init];
    cpvc.vcID = indexPath.section;
    cpvc.phoneNum = self.phone;
    [self.navigationController pushViewController:cpvc animated:YES];

}
#pragma makr -setlabel
-(UILabel*)setLabelWith:(NSString*)text font:(CGFloat)font color:(UIColor*)c{
    UILabel*label =  [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = c;
    return label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
