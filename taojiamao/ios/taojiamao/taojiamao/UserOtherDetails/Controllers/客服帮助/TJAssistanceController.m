//
//  TJAssistanceController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAssistanceController.h"
#import "TJAssistanceCell.h"
#import "TJAssistanceModel.h"

#import "TJHelpDetailController.h"

#define OPENQQ    856749
#define OPENPHONE 8792167

static NSString * const TJUserAssistanceCell = @"TJUserAssistanceCell";

@interface TJAssistanceController ()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)UIView * QQAndPhone;
@property(nonatomic,strong)TJButton * openQQ;
@property(nonatomic,strong)TJButton * openPhone;
@property(nonatomic,strong)UILabel * introlabel;

@end

@implementation TJAssistanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服帮助";
    [self setUI];
    [self setQQAndPhone];
    [self network];
}
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.yj_y, S_W, S_H-175) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TJAssistanceCell class] forCellReuseIdentifier:TJUserAssistanceCell];
    [self.view addSubview:self.tableView];
    
    self.QQAndPhone = [[UIView alloc]init];
    self.QQAndPhone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.QQAndPhone];
    WeakSelf
    [self.QQAndPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
        make.height.mas_equalTo(125*H_Scale);
    }];
}
#pragma mark - setQQAndPhone
-(void)setQQAndPhone{
    self.openQQ = [[TJButton alloc]initWith:@"QQ在线客服" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:KALLRGB tag:OPENQQ cornerRadius:20];
    [self.QQAndPhone addSubview:self.openQQ];
    
    self.openPhone = [[TJButton alloc]initWith:@"客服热线" delegate:self font:14*W_Scale titleColor:KALLRGB backColor:[UIColor whiteColor] tag:OPENPHONE];
    [self.QQAndPhone addSubview:self.openPhone];
    
    self.introlabel = [[UILabel alloc]init];
    self.introlabel.text = @"温馨提示:客服工作时间周一至周六 8:00 - 18:00";
    self.introlabel.textColor =RGB(153, 153, 153);
    self.introlabel.font = [UIFont systemFontOfSize:11];
    [self.QQAndPhone addSubview:self.introlabel];
    WeakSelf
    [self.openQQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14*H_Scale);
        make.centerX.mas_equalTo(weakSelf.QQAndPhone);
        make.width.mas_equalTo(335*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
    
    [self.openPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.QQAndPhone);
        make.top.mas_equalTo(weakSelf.openQQ.mas_bottom).offset(15*H_Scale);
        make.height.mas_equalTo(17*H_Scale);
    }];
    
    [self.introlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.QQAndPhone);
        make.top.mas_equalTo(weakSelf.openPhone.mas_bottom).offset(15*H_Scale);
    }];
}
#pragma mark - TJButtonDelegate
-(void)buttonClick:(UIButton *)but{
    if (but.tag==OPENQQ) {
        DSLog(@"打开qq");
    }else{
        DSLog(@"打电话");
        NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"0311-25545522"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
        [self.view addSubview:callWebview];
    }
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJAssistanceCell * cell = [tableView dequeueReusableCellWithIdentifier:TJUserAssistanceCell forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:TJUserAssistanceCell cacheByIndexPath:indexPath configuration:^(TJAssistanceCell *cell) {
        cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
        cell.model = self.dataArray[indexPath.section];

    }];
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
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJAssistanceModel *m = self.dataArray[indexPath.row];
    TJHelpDetailController * advc = [[TJHelpDetailController alloc]init];
    advc.detailsID = m.id;
    [self.navigationController pushViewController:advc animated:YES];
}
#pragma mark - net
-(void)network{
    self.dataArray = [NSMutableArray array];
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
        request.url = MineAssistanceHelp;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--help-≈≈%@=======",responseObject);
        NSDictionary *dict = responseObject[@"data"][@"rows"];
    
        self.dataArray = [TJAssistanceModel mj_objectArrayWithKeyValuesArray:dict];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
    }];
}
#pragma mark - lazyLoaing
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
