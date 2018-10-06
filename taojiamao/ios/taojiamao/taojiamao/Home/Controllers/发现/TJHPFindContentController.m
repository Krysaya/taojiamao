
//
//  TJHPFindContentController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/29.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHPFindContentController.h"
#import "TJHPFindCell.h"
#import "TJHPFindGoodsModel.h"
#import "TJHPFindModel.h"
#import "TJFindPopView.h"
#import <Social/Social.h>
@interface TJHPFindContentController ()<UITableViewDelegate,UITableViewDataSource,ImgClickDelegate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataGoodsArr;

@property(nonatomic,strong)UITableView *tabelView;
@end

@implementation TJHPFindContentController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     NSString *indexx = [NSString stringWithFormat:@"%ld",self.zj_currentIndex+1];
    [self loadReuqestNormalDataWithType:indexx];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-120) style:UITableViewStylePlain];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
//     [tabelView registerNib:[UINib nibWithNibName:@"TJHPFindCell" bundle:nil] forCellReuseIdentifier:@"FindCell"];
    [self.view addSubview:tabelView];
    self.tabelView = tabelView;
    
//    WeakSelf
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
//        [weakSelf loadReuqestDataWithType:self.indes withcid:self.cidd];
    }];
    [footer setTitle:@"----我们是有底线的----" forState:MJRefreshStateNoMoreData];
//    self.tabelView.mj_footer = footer;
    
}

- (void)loadReuqestNormalDataWithType:(NSString *)type {
    self.dataGoodsArr = [NSMutableArray array];
    self.page = 1;
    NSString *pag = [NSString stringWithFormat:@"%ld",self.page];
    [SVProgressHUD show];
    WeakSelf
    NSMutableDictionary *param = @{}.mutableCopy;
    param[@"page"] = pag;
    param[@"page_num"] = @"10";
    param[@"type"] = type;
    [KConnectWorking requestNormalDataParam:param withRequestURL:[NSString stringWithFormat:@"%@/%@",HPFindGoods,type] withMethodType:kXMHTTPMethodGET withSuccessBlock:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        DSLog(@"----%@",responseObject);
        weakSelf.dataGoodsArr = [TJHPFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [weakSelf.tabelView reloadData];
        weakSelf.page++;
    } withFailure:^(NSError * _Nullable error) {
        [SVProgressHUD dismiss];
//        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSString  * receive = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding ];
//
//        //字符串再生成NSData
//        NSData *data = [receive dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//
//        DSLog(@"0--%@---",dict[@"msg"]);
    }];
}
#pragma mark - tableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataGoodsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJHPFindCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = (TJHPFindCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"TJHPFindCell" owner:self options:nil]  lastObject];
    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题        //
        [[cell.subviews objectAtIndex:1] removeFromSuperview];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
        
    }
    cell.btn_share.tag = indexPath.row;
    [cell.btn_share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//    TJHPFindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindCell" forIndexPath:indexPath];
    cell.model = self.dataGoodsArr[indexPath.row];
    cell.delegate = self;
    return cell;
    
}
- (void)imgClickWithIndex:(UIButton *)sender{
    TJHPFindCell *cell = (TJHPFindCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
    TJHPFindModel *m = self.dataGoodsArr[indexPath.row];
    TJHPFindGoodsModel *model = m.good[sender.tag-200];
    TJFindPopView *popView = [[TJFindPopView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) withImgURL:model.itempic];
//    popView
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
//    [self.view addSubview:popView];
}
- (void)shareClick:(UIButton *)sender{
//    TJHPFindCell *cell = (TJHPFindCell *)[sender viewWithTag:<#(NSInteger)#>];
//    NSIndexPath *indexPath = sender.tag;
    TJHPFindModel *m = self.dataGoodsArr[sender.tag];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<m.good.count; i++) {
        TJHPFindGoodsModel *mm = m.good[i];
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL: [NSURL URLWithString:mm.itempic]];
        [arr addObject:img.image];
    }
//    UIImageView *imgv = [[UIImageView alloc]init]; [imgv sd_setImageWithURL: [NSURL URLWithString:@""]];
//    UIImage *img2 = [UIImage imageNamed:@"logo"];
//
//    NSArray *images = @[imgv.image,img2];
    UIActivityViewController  * activityController = [[UIActivityViewController alloc] initWithActivityItems:arr applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
    
 
}
@end
