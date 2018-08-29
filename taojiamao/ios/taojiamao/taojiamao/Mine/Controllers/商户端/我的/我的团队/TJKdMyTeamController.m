//
//  TJKdMyTeamController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdMyTeamController.h"
#import "TJKdMyTeamListModel.h"

#import "TJKdMyTeamCell.h"
@interface TJKdMyTeamController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation TJKdMyTeamController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self loadRequestMyTeam];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的团队";
    self.tableView.rowHeight = 90;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJKdMyTeamCell" bundle:nil] forCellReuseIdentifier:@"KdMyTeamCell"];
}
#pragma mark - request
- (void)loadRequestMyTeam{
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
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdMyTeam;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"我的团队===%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        if (dict.count>0) {
            self.dataArr = [TJKdMyTeamListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        [SVProgressHUD showInfoWithStatus:@"没有数据啦~"];
        [SVProgressHUD dismissWithDelay:1];
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJKdMyTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KdMyTeamCell"];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}


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
#pragma mark - Table view delegate

// In a.xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
