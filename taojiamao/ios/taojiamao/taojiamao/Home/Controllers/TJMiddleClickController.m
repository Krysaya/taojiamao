//
//  TJMiddleClickController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/21.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMiddleClickController.h"
#import "TJSearchView.h"
#import "TJFiltrateView.h"
#import "TJHomeFootShowModel.h"
#import "TJHomeFootShowCell.h"
#import "TJGoodsDetailsController.h"

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

@end

@implementation TJMiddleClickController

-(void)requestData{
    //使用的是首页接口 test
    NSDictionary * dict = @{@"page":@(1)};
    [XDNetworking postWithUrl:HomeFootRecommend refreshRequest:NO cache:NO params:dict progressBlock:nil successBlock:^(id response) {
        
        NSArray * temp = response[@"data"];
        for (NSDictionary * d in temp) {
            TJHomeFootShowModel * model = [TJHomeFootShowModel yy_modelWithDictionary:d];
            for (int i =0 ; i<4; i++) {
               [self.footData addObject:model];
            }
        }
        [self.tableView reloadData];
        
    } failBlock:^(NSError *error) {
        DSLog(@"%@",error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热推TOP";
    [self requestData];
    [self setSearchFiltrateView];
    [self setUIBottomShare];
    [self setUItableView];
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
    self.bottomShare.backgroundColor = RandomColor;
    [self.view addSubview:self.bottomShare];
    
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading1"]];
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
    
    self.shareButton = [[TJButton alloc]initWith:@"一键分享" delegate:self font:17 titleColor:RGB(255, 255, 255) backColor:RGB(255, 79, 119) tag:3521 cornerRadius:20];
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
        int rand = arc4random_uniform((int)self.footData.count);
        for (int j=0; j<temp.count; j++) {
            NSNumber * number = temp[j];
            while ([number intValue] == rand) {
                rand = arc4random_uniform((int)self.footData.count);
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
    
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,2)];
    
    return attr;
}
-(void)setSearchFiltrateView{
    self.search = [[TJSearchView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, S_W, 65) placeholder:@"输入关键字搜索商品" title:@"搜索"];
    self.search.delegate  = self;
    [self.view addSubview:self.search];
    
    self.filtrate = [[TJFiltrateView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+self.search.mj_h, S_W, 45) withMargin:33];
    self.filtrate.deletage =self;
    [self.view addSubview:self.filtrate];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.footData.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJHomeFootShowCell * cell = [tableView dequeueReusableCellWithIdentifier:TJMiddleClickControllerCell forIndexPath:indexPath];
    cell.model = self.footData[indexPath.row];
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
    return 150*H_Scale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJGoodsDetailsController * gdvc = [[TJGoodsDetailsController alloc]init];
    gdvc.model = self.footData[indexPath.row];
    [self.navigationController pushViewController:gdvc animated:YES];
}
#pragma mark - TJHomeFootShowCellDeletage
-(void)deletageWithModel:(TJHomeFootShowModel *)model withCell:(TJHomeFootShowCell *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSNumber * index = [NSNumber numberWithInteger:indexPath.row];
    DSLog(@"%@",index);
    if ([self.shareCells containsObject:index]) {
        [self.shareCells removeObject:index];
        self.numberLabel.attributedText = [self textChangeColor:[NSString stringWithFormat:@"已选择%02lu张",(unsigned long)self.shareCells.count]];
    }else{
        [self.shareCells addObject:index];
        self.numberLabel.attributedText = [self textChangeColor:[NSString stringWithFormat:@"已选择%02lu张",(unsigned long)self.shareCells.count]];
    }
}
#pragma mark - TJSearchViewDelegate,TJFiltrateViewDelegate
-(void)SearchButtonClick:(NSString *)text{
    DSLog(@"%@",text);
}
-(void)popupFiltrateView{
    DSLog(@"呼出筛选框");
}
-(void)requestWithKind:(NSString *)kind{
    DSLog(@"%@",kind);
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
    DSLog(@"%s",__func__);
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
