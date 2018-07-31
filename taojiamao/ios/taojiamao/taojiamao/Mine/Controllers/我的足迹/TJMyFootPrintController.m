
//
//  TJMyFootPrintController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMyFootPrintController.h"
#import "TJMyFootPrintCell.h"
#import "SJAttributeWorker.h"
#import "TJGoodsInfoListModel.h"
@interface TJMyFootPrintController ()


@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@property (nonatomic, strong) NSArray *childArr;
@end

@implementation TJMyFootPrintController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestFootPrint];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的足迹";
    self.tableView.rowHeight = 120;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJMyFootPrintCell" bundle:nil] forCellReuseIdentifier:@"footPrintCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFootPrint{
    self.dataArr = [NSMutableArray array];
    self.dataDict = [NSMutableDictionary dictionary];
    self.childArr = [NSArray array];
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
        request.url = MineFootPrint;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--zuji-≈≈%@=======",responseObject);

        self.dataDict = responseObject[@"data"][@"data"];
       
        self.childArr = responseObject[@"data"][@"keys"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--足迹-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.childArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = self.childArr[section];
    NSMutableArray *arr = [TJGoodsInfoListModel mj_objectArrayWithKeyValuesArray:self.dataDict[key]];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJMyFootPrintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footPrintCell"];
    NSString *key = self.childArr[indexPath.section];
    NSMutableArray *arr = [TJGoodsInfoListModel mj_objectArrayWithKeyValuesArray:self.dataDict[key]];
    cell.model = arr[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]init];
    [view addSubview:lab];
    lab.frame = CGRectMake(12, 12, 100, 30);
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = RGB(153, 153, 153);
    lab.text = self.childArr[section];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
