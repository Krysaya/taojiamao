
//
//  TJGoodsCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsCollectController.h"
#import "TJGoodsListCell.h"
#import "TJGoodsCollectModel.h"
#import "SJAttributeWorker.h"
@interface TJGoodsCollectController ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, assign) BOOL isEditing;

@end

@implementation TJGoodsCollectController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    for (int i = 0; i < 20; i ++) {
//        TJGoodsCollectModel *m = [TJGoodsCollectModel new];
//        [_dataArr addObject:m];
//    }

    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.rowHeight = 150;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    //    tableView.allowsMultipleSelection = YES;
    tableView.tableFooterView = [UIView new];
    [tableView registerNib:[UINib nibWithNibName:@"TJGoodsListCell" bundle:nil] forCellReuseIdentifier:@"goodslistCell"];
    [self.view addSubview:tableView];
    self.goodsTabView = tableView;
    // Do any additional setup after loading the view.
}

#pragma mark - tableViewDelagte
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    
    [cell cellWithArr:self.dataArr forIndexPath:indexPath isEditing:_goodsEditStatus];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (_goodsEditStatus) {
        TJGoodsCollectModel *model = [_dataArr objectAtIndex:indexPath.row];
        model.isChecked = !model.isChecked;
        [tableView reloadData];
    }
   
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //编辑设置成自定义的必须把系统的设置为None
//    
//        return UITableViewCellEditingStyleNone;
//   
//}

@end
