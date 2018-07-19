//
//  TJHeadLineController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/17.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineController.h"
#import "TJHeadLineOneCell.h"
#import "TJHeadLineTwoCell.h"
#import "TJHeadLineThreeCell.h"
#import "TJHeadDetailController.h"
#import "TJNoticeController.h"
@interface TJHeadLineController ()<TJButtonDelegate>

@end

@implementation TJHeadLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"sgm"];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.frame = CGRectMake(0, 0, 44, 19);
    img.image = [UIImage imageNamed:@"headLine_img"];
    self.navigationItem.titleView = img;
    
    self.tableView.tableFooterView = [UIView new];
     [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineOneCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineTwoCell" bundle:nil] forCellReuseIdentifier:@"twoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineThreeCell" bundle:nil] forCellReuseIdentifier:@"threeCell"];
}

- (void)buttonClick:(UIButton *)but{
    TJNoticeController *noticeV = [[TJNoticeController alloc]init];
    [self.navigationController pushViewController:noticeV animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 167;
    }else if (indexPath.row==1){
        return 255;
    }else{
        return 115;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        TJHeadLineOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        return cell;

    }else if (indexPath.row==1){
        TJHeadLineTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        return cell;

    }else{
        TJHeadLineThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        return cell;

    }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJHeadDetailController *vc = [[TJHeadDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
