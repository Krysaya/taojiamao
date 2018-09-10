//
//  TJDetailListController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/23.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJDetailListController.h"
#import "TJDetailListCell.h"
#import "TJAssetsDetailListModel.h"
@interface TJDetailListController ()<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TJDetailListController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)zj_viewWillAppearForIndex:(NSInteger)index{
//  NSString *str = [NSString stringWithFormat:@"%ld",index+1];
//    [self loadMembersMingXiList:str];
}
- (void)zj_viewDidLoadForIndex:(NSInteger)index{
   
    NSString *str = [NSString stringWithFormat:@"%ld",index+1];
    if ([self.type_mxx isEqualToString:@"put"]) {
//        普通
        DSLog(@"put");
        [self loadMembersMingXiList:str withUserType:@"1"];
    }else{
//        快递
        DSLog(@"kuaid");

        [self loadMembersMingXiList:str withUserType:@"2"];

    }
    self.tableView.rowHeight = 62;
    self.tableView.backgroundColor =RGB(245, 245, 245);
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJDetailListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    
}

- (void)loadMembersMingXiList:(NSString *)type withUserType:(NSString *)userType{
    self.dataArr = [NSMutableArray array];
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
                                @"style":type,
                                @"user_type":userType,

                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = UserBalanceDetail;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"style":type,
                               @"user_type":userType,
                               };
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--jjjffffmmmmxxxx-%@",responseObject);
        self.dataArr = [TJAssetsDetailListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {

    }];
}
- (void)requestMembersDetailWithIndex:(NSInteger)index{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
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
