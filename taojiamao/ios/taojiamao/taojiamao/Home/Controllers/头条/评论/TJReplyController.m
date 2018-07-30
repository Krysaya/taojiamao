
//
//  TJReplyController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJReplyController.h"
#import "TJCommentsReplyCell.h"
#import "TJMoreCommentsCell.h"
@interface TJReplyController ()

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation TJReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"1条回复";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJCommentsReplyCell" bundle:nil] forCellReuseIdentifier:@"commentReplyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJMoreCommentsCell" bundle:nil] forCellReuseIdentifier:@"replyCell"];

}

- (void)requestReplyList{
//
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
                                @"aid":@"",
                                @"cid":@"",
                                
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = CommentsList;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"aid":@"",
                               @"cid":@""};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"--pl%@==success==",responseObject);
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--评论-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        TJMoreCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replyCell" forIndexPath:indexPath];
        cell.view_bg.hidden = YES;
        return cell;
    }else {
        TJCommentsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentReplyCell" forIndexPath:indexPath];
        
        return cell;
    }
   
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
