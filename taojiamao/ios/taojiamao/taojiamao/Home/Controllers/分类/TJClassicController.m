
//
//  TJClassicController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJClassicController.h"
#import "TJClassicSecondCell.h"
#import "TJClassicFirstCell.h"
#import "TJGoodCatesMainListModel.h"
@interface TJClassicController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView_left;
@property (nonatomic, strong) UITableView *tableView_right;
@property (nonatomic, strong) NSDictionary *dict_son;

@property (nonatomic, strong) NSMutableArray *dataArr_left;
@property (nonatomic, strong) NSMutableArray *dataArr_right;

@property (nonatomic, strong) NSString *select_index;
@property (nonatomic, strong) NSString *index;

@end

@implementation TJClassicController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadGoodsCatesList];
    self.select_index = @"0";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    self.view.backgroundColor = RGB(245, 245, 245);
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, S_H) style:UITableViewStylePlain];
    tableV.tag = 1000;
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.tableFooterView = [UIView new];
    [tableV registerNib:[UINib nibWithNibName:@"TJClassicFirstCell" bundle:nil] forCellReuseIdentifier:@"classicFirstCell"];
   
   
    [self.view addSubview:tableV];
    self.tableView_left = tableV;

    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(100, SafeAreaTopHeight, S_W-100, 110);
//    bgView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:bgView];
    
    
    
    UITableView *tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(100, 110+SafeAreaTopHeight, S_W-100, S_H-110-64) style:UITableViewStylePlain];
    tableV2.tag = 2000;
    tableV2.delegate = self;
    tableV2.dataSource = self;
    tableV2.separatorStyle = UITableViewCellSeparatorStyleNone;

    [tableV2 registerClass:[TJClassicSecondCell class] forCellReuseIdentifier:@"classicCell"];
    [self.view addSubview:tableV2];
    self.tableView_right= tableV2;
}

- (void)loadGoodsCatesList{
    self.dataArr_left = [NSMutableArray array];
    self.dataArr_right = [NSMutableArray array];

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
    DSLog(@"--sign==%@",md5Str);

    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = GoodsClassicList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"----主分类-success-===%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        for (int i=1; i<dict.count+1; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            TJGoodCatesMainListModel *model = [TJGoodCatesMainListModel mj_objectWithKeyValues:dict[str]];
            DSLog(@"---fl=%@",dict[str]);
            [self.dataArr_left addObject:model];
            
//
            NSArray * childsArray = [model._childs componentsSeparatedByString:@","];//以“,”切割

            for (NSString *str in childsArray) {
                TJGoodCatesMainListModel *childsModel = [TJGoodCatesMainListModel mj_objectWithKeyValues:model._sons[str]];
                [self.dataArr_right addObject:childsModel];
                DSLog(@"--childs==%ld",self.dataArr_right.count);
            }
        }
        
        
        

        
        DSLog(@"---num--%ld",self.dataArr_left.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView_left reloadData];
            [self.tableView_right reloadData];

        });
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--分类-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
}
#pragma mark  - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==1000) {
        return 1;
    }
    
    return self.dataArr_left.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1000) {
        return self.dataArr_left.count;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1000) {
        return 45;
    }
    
    return 250;
}
//section间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag==1000) {
//        left
         TJClassicFirstCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"classicFirstCell"];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.model = self.dataArr_left[indexPath.row];
        if (indexPath.row==0) {//指定第一行为选中状态
            
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            
        }
        

        return cell1;
    }else{
//        right
        //将字符串切割为数组
//        TJGoodCatesMainListModel *model = self.dataArr_left[i];
//
//        NSArray * childsArray = [model._childs componentsSeparatedByString:@","];//以“,”切割
//        NSMutableArray *arr = [NSMutableArray array];
//        for (NSString *str in childsArray) {
//            TJGoodCatesMainListModel *childsModel = [TJGoodCatesMainListModel mj_objectWithKeyValues:model._sons[str]];
//            [arr addObject:childsModel];
//            DSLog(@"--childs==%ld===%@",arr.count,childsModel.catname);
//        }
        TJClassicSecondCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"classicCell"];
//        [cell2 cellArr:self.dataArr_right[i]];
        
        
        return cell2;
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1000) {
        self.select_index = [NSString stringWithFormat:@"%ld",indexPath.row];
        [self.tableView_right reloadData];
    }
}
@end
