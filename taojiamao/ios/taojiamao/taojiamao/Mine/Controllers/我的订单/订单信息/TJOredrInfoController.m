//
//  TJOredrInfoController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/20.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJOredrInfoController.h"
#import "TJMallOrdersCell.h"
#import "TJOredrInfoCell.h"
@interface TJOredrInfoController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_one;
@property (weak, nonatomic) IBOutlet UILabel *lab_two;
@property (weak, nonatomic) IBOutlet UILabel *lab_three;
@property (weak, nonatomic) IBOutlet UILabel *lab_four;
@property (weak, nonatomic) IBOutlet UIImageView *img_one;
@property (weak, nonatomic) IBOutlet UIImageView *img_two;
@property (weak, nonatomic) IBOutlet UIImageView *img_three;
@property (weak, nonatomic) IBOutlet UIImageView *img_four;
@property (weak, nonatomic) IBOutlet UILabel *lab_b_one;
@property (weak, nonatomic) IBOutlet UILabel *lab_b_two;
@property (weak, nonatomic) IBOutlet UILabel *lab_b_three;
@property (weak, nonatomic) IBOutlet UILabel *lab_b_four;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TJOredrInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单信息";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJOredrInfoCell" bundle:nil] forCellReuseIdentifier:@"OrderInfoCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TJMallOrdersCell" bundle:nil] forCellReuseIdentifier:@"OrdersCell"];
}

- (void)setTableView{
   
   
}
- (void)requestTaoBaoOrderInfo{
    [KConnectWorking requestNormalDataParam:@{@"id":self.gid} withRequestURL:[NSString stringWithFormat:@"%@/%@",MyOrderList,self.gid] withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TJOredrInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoCell"];
        return cell;
    }else{
        TJMallOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersCell"];
        return cell;
        
    }
}
@end
