//
//  TJMiddleClickController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/21.
//  Copyright © 2018年 yueyu. All rights reserved.
// --------------热推

#import "TJMiddleClickController.h"
#import "TJSearchView.h"
#import "TJFiltrateView.h"
//#import "TJHomeFootShowModel.h"
#import "TJHomeFootShowCell.h"
#import "TJDefaultGoodsDetailController.h"

#import "TJJHSGoodsListModel.h"
static NSString * const TJMiddleClickControllerCell = @"TJMiddleClickControllerCell";

@interface TJMiddleClickController ()<TJSearchViewDelegate,TJFiltrateViewDelegate,UITableViewDelegate,UITableViewDataSource,TJHomeFootShowCellDeletage,TJButtonDelegate>

@property(nonatomic,strong)TJSearchView * search;
@property(nonatomic,strong)TJFiltrateView * filtrate;

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * footData;
@property(nonatomic,strong)NSMutableArray * shareCells;

@property(nonatomic,strong)UIView * bottomShare;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UIButton * random;
@property(nonatomic,strong)TJLabel * numberLabel;
@property(nonatomic,strong)TJButton * shareButton;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSString *searchStr;
@end

@implementation TJMiddleClickController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热推TOP";

    [self setSearchFiltrateView];
    [self setUIBottomShare];
    [self setUItableView];
    [self requestSearchGoodsTopWithOrderType:@"0" withKeyString:@""];

}

- (void)requestSearchGoodsTopWithOrderType:(NSString *)type withKeyString:(NSString *)keyStr{
    self.dataArr = [NSMutableArray array];    [SVProgressHUD show];

     NSString *str = [keyStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *param = @{
                            @"keyword":keyStr,
                            @"order":type,
                            @"is_top":@"1",
                            };
    NSDictionary *mdParam = @{@"keyword":str,
                              @"order":type,
                              @"is_top":@"1",
                              };
    [KConnectWorking requestNormalDataMD5Param:mdParam withNormlParams:param withRequestURL:SearchGoodsList withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        DSLog(@"=-=-=-=%@--top===",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        self.dataArr = [TJJHSGoodsListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        if (self.dataArr.count>0) {
            
        }else{
            self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nolist"]];
        }
        
    } withFailure:^(NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"加载失败，请重试~"];
    }];
}
-(void)setUItableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.filtrate.yj_y+self.filtrate.yj_height+5, S_W, S_H-self.filtrate.yj_y-self.filtrate.yj_height-5-self.bottomShare.yj_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerClass:[TJHomeFootShowCell class] forCellReuseIdentifier:TJMiddleClickControllerCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)setUIBottomShare{
    WeakSelf
    self.bottomShare = [[UIView alloc]initWithFrame:CGRectMake(0, S_H-55-SafeAreaBottomHeight, S_W, 55+SafeAreaBottomHeight)];
    self.bottomShare.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomShare];
    
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_default"]];
    [self.bottomShare addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.width.height.left.mas_equalTo(15);
        
    }];
    
    self.random = [[UIButton alloc]init];
    [self.random addTarget:self action:@selector(randomClick) forControlEvents:UIControlEventTouchUpInside];
    [self.random setTitle:@"一键随机(共9件)" forState:UIControlStateNormal];
    [self.random setTitleColor:RGB(151, 151, 151) forState:UIControlStateNormal];
    self.random.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.bottomShare addSubview:self.random];
    [self.random mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.icon);
    }];
    
    self.numberLabel = [TJLabel setLabelWith:@"" font:13 color:RGB(151, 151, 151)];
    self.numberLabel.attributedText = [self textChangeColor:@"已选择00张"];
    [self.bottomShare addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.random);
        make.top.mas_equalTo(weakSelf.random.mas_bottom).offset(5);
    }];
    
    self.shareButton = [[TJButton alloc]initWith:@"一键分享" delegate:self font:17 titleColor:[UIColor whiteColor] tag:3521 withBackImage:@"share" withEdgeType:@"right"];
    self.shareButton.layer.masksToBounds = YES;
    self.shareButton.layer.cornerRadius = 20;
    self.shareButton.backgroundColor = KALLRGB;
    [self.bottomShare addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(weakSelf.random.mas_right).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(202);
    }];
    
}
-(void)randomClick{
    DSLog(@"随机9个");
    [self.shareCells removeAllObjects];
    NSMutableArray * temp = [NSMutableArray array];
    for(int i=0;i<9;i++){
        int rand = arc4random_uniform((int)self.dataArr.count);
        for (int j=0; j<temp.count; j++) {
            NSNumber * number = temp[j];
            while ([number intValue] == rand) {
                rand = arc4random_uniform((int)self.dataArr.count);
                j=-1;
            }
        }
        [temp addObject:[NSNumber numberWithInt:rand]];
    }
    self.shareCells = temp;
    self.numberLabel.attributedText = [self textChangeColor:[NSString stringWithFormat:@"已选择%02lu张",(unsigned long)self.shareCells.count]];
    [self.tableView reloadData];
}
-(void)buttonClick:(UIButton *)but{
    DSLog(@"%lu",(unsigned long)self.shareCells.count);
}
-(NSMutableAttributedString*)textChangeColor:(NSString*)str{
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attr addAttribute:NSForegroundColorAttributeName value:KALLRGB range:NSMakeRange(3,2)];
    
    return attr;
}
-(void)setSearchFiltrateView{
    self.search = [[TJSearchView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 65) placeholder:@"输入关键字搜索商品" title:@"搜索"];
    self.search.delegate  = self;
    [self.view addSubview:self.search];
    
    self.filtrate = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+self.search.mj_h, S_W, 45) withMargin:25];
    self.filtrate.backgroundColor = [UIColor whiteColor];
    self.filtrate.deletage =self;
    [self.view addSubview:self.filtrate];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJHomeFootShowCell * cell = [tableView dequeueReusableCellWithIdentifier:TJMiddleClickControllerCell forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    cell.showShare = YES;
    cell.deletage =self;
    NSNumber * index = [NSNumber numberWithInteger:indexPath.row];
    if ([self.shareCells containsObject:index]) {
        cell.isShare = YES;
    }else{
        cell.isShare = NO;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJJHSGoodsListModel *m = self.dataArr[indexPath.row];
    TJDefaultGoodsDetailController * gdvc = [[TJDefaultGoodsDetailController alloc]init];
    gdvc.gid = m.itemid;
    [self.navigationController pushViewController:gdvc animated:YES];
}
#pragma mark - TJHomeFootShowCellDeletage
//-(void)deletageWithModel:(TJHomeFootShowModel *)model withCell:(TJHomeFootShowCell *)cell{
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    NSNumber * index = [NSNumber numberWithInteger:indexPath.row];
//    DSLog(@"%@",index);
//    if ([self.shareCells containsObject:index]) {
//        [self.shareCells removeObject:index];
//        self.numberLabel.attributedText = [self textChangeColor:[NSString stringWithFormat:@"已选择%02lu张",(unsigned long)self.shareCells.count]];
//    }else{
//        [self.shareCells addObject:index];
//        self.numberLabel.attributedText = [self textChangeColor:[NSString stringWithFormat:@"已选择%02lu张",(unsigned long)self.shareCells.count]];
//    }
//}
#pragma mark - TJSearchViewDelegate,TJFiltrateViewDelegate
-(void)SearchButtonClick:(NSString *)text{
    DSLog(@"点了搜索%@",text);
    self.searchStr = text;
    [self requestSearchGoodsTopWithOrderType:@"0" withKeyString:self.searchStr];

}
-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
}
-(void)requestWithKind:(NSString *)kind{
    DSLog(@"%@",kind);
    if ([kind isEqualToString:@"综合"]) {
        DSLog(@"%@",kind);
        [self requestSearchGoodsTopWithOrderType:@"0" withKeyString:self.searchStr];
        
    }else if ([kind isEqualToString:@"销量"]){
        DSLog(@"%@",kind);
        [self requestSearchGoodsTopWithOrderType:@"6" withKeyString:self.searchStr];
    }else if ([kind isEqualToString:@"价格"]){
        DSLog(@"%@",kind);
        [self requestSearchGoodsTopWithOrderType:@"2" withKeyString:self.searchStr];

        
    }else if ([kind isEqualToString:@"优惠券"]){
        DSLog(@"%@",kind);
        [self requestSearchGoodsTopWithOrderType:@"4" withKeyString:self.searchStr];

    }else{
        DSLog(@"%@",kind);
        
    }
    
}

-(NSMutableArray *)footData{
    if (!_footData) {
        _footData = [NSMutableArray array];
    }
    return _footData;
}
-(NSMutableArray *)shareCells{
    if (!_shareCells) {
        _shareCells = [NSMutableArray array];
    }
    return _shareCells;
}

-(void)dealloc{
//    DSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
