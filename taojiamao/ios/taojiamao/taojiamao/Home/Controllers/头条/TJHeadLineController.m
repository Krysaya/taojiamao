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
#import "TJHeadLineDefaultCell.h"
#import "TJArticlesListModel.h"

@interface TJHeadLineController ()<TJButtonDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TJHeadLineController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestNewsList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initDelegate:self backColor:nil tag:5496 withBackImage:@"sgm" withSelectImage:nil];
    
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.frame = CGRectMake(0, 0, 44, 19);
    img.image = [UIImage imageNamed:@"headLine_img"];
    self.navigationItem.titleView = img;
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineDefaultCell" bundle:nil] forCellReuseIdentifier:@"defaultCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineOneCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineTwoCell" bundle:nil] forCellReuseIdentifier:@"twoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"TJHeadLineThreeCell" bundle:nil] forCellReuseIdentifier:@"threeCell"];
}

- (void)requestNewsList{
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
//                                @"type":type,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = NewsArticles;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
//        request.parameters = @{@"type":type};
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"----news-success-===%@",responseObject);
        
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJArticlesListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        DSLog(@"-%lu--arr==",(unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } onFailure:^(NSError * _Nullable error) {
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"--news-≈≈error-msg%@=======dict%@",dic_err[@"msg"],dic_err);
    }];
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

    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TJArticlesListModel *model = self.dataArr[indexPath.row];
    if ([model.show_type intValue]==0) {
        return 70;
    }else if([model.show_type intValue]==1){
        return 125;
    }else if([model.show_type intValue]==2){
        return 255;
    }else{
        return 170;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TJArticlesListModel *model = self.dataArr[indexPath.row];
    if ([model.show_type intValue]==1) {
        
        TJHeadLineThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
       
    }else if([model.show_type intValue]==2){
        TJHeadLineTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.model = model;

        return cell;
    }else if([model.show_type intValue]==3){
        TJHeadLineOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        
        cell.model = model;
        return cell;
    }else{
        TJHeadLineDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    
    
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJArticlesListModel *model = self.dataArr[indexPath.row];
    TJHeadDetailController *vc = [[TJHeadDetailController alloc]init];
    vc.aid = model.id;
    vc.title_art = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
