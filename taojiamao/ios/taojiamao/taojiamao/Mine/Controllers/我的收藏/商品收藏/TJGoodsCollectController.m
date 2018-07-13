
//
//  TJGoodsCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/13.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGoodsCollectController.h"
#import "TJGoodsListCell.h"
#import "SJAttributeWorker.h"
@interface TJGoodsCollectController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJGoodsCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:S_F style:UITableViewStylePlain];
    tableView.rowHeight = 150;
    tableView.delegate = self;
    tableView.dataSource = self;
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodslistCell"];
    NSAttributedString *str = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insertImage([UIImage imageNamed:@"tb_bs"], 0, CGPointMake(0, 0), CGSizeMake(27, 13));
        make.insertText(@" 淘米瑞春秋装新款套头圆领女士豹纹卫衣粉红宽松韩版的可能花费...", 1);
    });
    cell.titleLab.attributedText = str;
    return cell;
}


@end
