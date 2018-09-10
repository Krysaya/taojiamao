//
//  TJMultipleChoiceView.m
//  taojiamao
//
//  Created by yueyu on 2018/5/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMultipleChoiceView.h"

#define TwoButtonsH  41
#define TableViewW   269

#define ResetButton  1591
#define SureButton   1592

#define TBButton     1011
#define TMButton     1012

@interface TJMultipleChoiceView()<UITableViewDelegate,UITableViewDataSource,TJButtonDelegate>

@property(nonatomic,strong)UIView * bg;

@property(nonatomic,strong)UIView * tableback;

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)TJTextField * MIN;
@property(nonatomic,strong)TJTextField * MAX;
@property(nonatomic,strong)TJButton * TB;
@property(nonatomic,strong)TJButton * TM;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIButton * record;
@property(nonatomic,copy)NSString * recordStr;
@property(nonatomic,strong)UIButton * TBTM;
@property(nonatomic,copy)NSString * TBTMStr;

@property(nonatomic,strong)TJButton * reset;
@property(nonatomic,strong)TJButton * sure;

@end

@implementation TJMultipleChoiceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}
-(void)setUI{
    UIView *bg = [[UIView alloc]initWithFrame:S_F];
    bg.backgroundColor = RGBA(1, 1, 1, 0.2);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [bg addGestureRecognizer:tap];
    [self addSubview:bg];
    self.bg = bg;
//    self.back = [[UIButton alloc]initWithFrame:self.bounds];
//    self.back.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//    [self addSubview:self.back];
//    [self.back addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableback = [[UIView alloc]initWithFrame:CGRectMake(S_W-TableViewW, 0, TableViewW, S_H)];
    self.tableback.backgroundColor = [UIColor whiteColor];
    [bg addSubview:self.tableback];
    
    
    CGFloat Y = IsX?35+24:35;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Y,TableViewW, S_H-Y-SafeAreaBottomHeight-TwoButtonsH) style:UITableViewStylePlain];
    [self.tableback addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TJBaseTableCell class] forCellReuseIdentifier:@"testqwer"];
    
    WeakSelf
    self.reset = [[TJButton alloc]initWith:@"重置" delegate:self font:15 titleColor:RGB(51, 51, 51) backColor:[UIColor whiteColor] tag:ResetButton cornerRadius:0.0 borderColor:RGB(51, 51, 51) borderWidth:0.5 withBackImage:nil withSelectImage:nil];
    [self.tableback addSubview:self.reset];
    [self.reset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.tableView);
        make.width.mas_equalTo(TableViewW*0.5);
        make.bottom.mas_equalTo(weakSelf.tableback).offset(-SafeAreaBottomHeight);
        make.height.mas_equalTo(TwoButtonsH);
    }];
    
    self.sure = [[TJButton alloc]initWith:@"完成" delegate:self font:15 titleColor:[UIColor whiteColor] backColor:KALLRGB tag:SureButton];
    [self.tableback addSubview:self.sure];
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.reset.mas_right);
        make.width.height.centerY.mas_equalTo(weakSelf.reset);
    }];
    
}
#pragma mark - TJButtonDelegate
-(void)buttonClick:(UIButton *)but{
    if (but.tag==TBButton || but.tag==TMButton) {
        
        if (!(but == self.TBTM)) {
            self.TBTM.selected = NO;
            [self.TBTM setBackgroundColor:RGB(244, 244, 244)];
            but.selected = YES;
            [but setBackgroundColor:[UIColor redColor]];
            self.TBTM = but;
            self.TBTMStr = but.titleLabel.text;
        }
       
    }else if (but.tag==ResetButton){
        self.record.selected = NO;
        [self.record setBackgroundColor:RGB(244, 244, 244)];
        self.record = nil;
        self.recordStr= @"";
        
        self.TBTM.selected = NO;
        [self.TBTM setBackgroundColor:RGB(244, 244, 244)];
        self.TBTM = nil;
        self.TBTMStr = @"";
        
        self.MIN.text = @"";
        self.MAX.text = @"";
        
    }else if (but.tag==SureButton){

        NSMutableDictionary *dict = @{}.mutableCopy;
        if (![TJOverallJudge judgeBlankString:self.MIN.text]) {
             dict[@"min"] = self.MIN.text;
        }
        if (![TJOverallJudge judgeBlankString:self.MAX.text]) {
            dict[@"max"] = self.MAX.text;
        }
        if (![TJOverallJudge judgeBlankString:self.TBTMStr]) {
            if ([self.TBTMStr isEqualToString:@"天猫"]) {
                 dict[@"type"] = @"C";
            }else{
                 dict[@"type"] = @"B";
            }
        }
        if (![TJOverallJudge judgeBlankString:self.recordStr]) {
            dict[@"class"] = self.recordStr;
        }
//        if (self.deletage) {
            [self.deletage buttonSureSelectString:dict];
//        }
        
        [self removeFromSuperview];

        DSLog(@"%@----%@---%@----%@",self.MIN.text,self.MAX.text,self.TBTMStr,self.recordStr);
    }else{
        if (!(but==self.record)) {
            self.record.selected = NO;
            [self.record setBackgroundColor:RGB(244, 244, 244)];
            but.selected = YES;
            [but setBackgroundColor:[UIColor redColor]];
            self.record = but;
            self.recordStr = but.titleLabel.text;
        }
    }
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TJBaseTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"testqwer" forIndexPath:indexPath];
    WeakSelf
    if (indexPath.section==0) {
        
        self.MIN = [TJTextField setTextFieldWith:@"最低价" font:15 textColor:RGB(61, 61, 61) backColor:RGB(244, 244, 244)];
        self.MIN.layer.cornerRadius = 4;
        self.MIN.layer.masksToBounds = YES;
        self.MIN.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:self.MIN];
        [self.MIN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(6);
            make.width.mas_equalTo(107);
            make.height.mas_equalTo(35);
        }];
        
        UIView * line = [[UIView alloc]init];
        line.backgroundColor = RGB(244, 244, 244);
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(weakSelf.MIN.mas_right).offset(11);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(2);
        }];
        
        self.MAX = [TJTextField setTextFieldWith:@"最高价" font:15 textColor:RGB(61, 61, 61) backColor:RGB(244, 244, 244)];
        self.MAX.layer.cornerRadius = 4;
        self.MAX.layer.masksToBounds = YES;
        self.MAX.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:self.MAX];
        [self.MAX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(line.mas_right).offset(11);
            make.height.width.mas_equalTo(weakSelf.MIN);
        }];
        
    }else if(indexPath.section==1){
        
        self.TB = [[TJButton alloc]initWith:@"淘宝" delegate:self font:15 titleColor:RGB(61, 61, 61) backColor:RGB(244, 244, 244) tag:TBButton cornerRadius:4];
        [cell.contentView addSubview:self.TB];
        [self.TB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(6);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(35);
        }];
        
        self.TM =[[TJButton alloc]initWith:@"天猫" delegate:self font:15 titleColor:RGB(61, 61, 61) backColor:RGB(244, 244, 244) tag:TMButton cornerRadius:4];
        [cell.contentView addSubview:self.TM];
        [self.TM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.width.height.mas_equalTo(weakSelf.TB);
            make.left.mas_equalTo(weakSelf.TB.mas_right).offset(7);
        }];
    }else{
        UIView * view = [self setButtonsWith:self.dataArray];
        
        [cell.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(cell.contentView);
        }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return 250;
    }else{
        return 80;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * head = [[UIView alloc]init];
    head.backgroundColor = [UIColor whiteColor];
    TJLabel * label = [TJLabel setLabelWith:@"" font:15 color:RGB(77, 77, 77)];
    [head addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.top.bottom.right.mas_equalTo(head);
    }];
    if (section==0) {
        label.text = @"价格区间(元)";
    }else if (section==1){
        label.text = @"店铺类型";
    }else{
        label.text = @"商品分类";
    }
    return head;
}
-(void)tapClick{
    [self removeFromSuperview];
}
-(UIView*)setButtonsWith:(NSMutableArray*)array{
    UIView * view= [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat W = 80;
    CGFloat H = 35;
    NSInteger rank = 3;
    
    for (int i = 0; i <array.count; i++) {

        TJButton *button = [[TJButton alloc]initWith:array[i] delegate:self font:15 titleColor:RGB(61, 61, 61) backColor:RGB(244, 244, 244) tag:(1200+i) cornerRadius:4];
        
        NSInteger row = i / rank;
        NSInteger col = i % rank;
        CGFloat margin = (self.tableView.bounds.size.width - (W * rank)) / (rank + 1);
        CGFloat X = margin + (W+ margin) * col;
        CGFloat Y = margin + (H + margin) * row;
        
        button.frame = CGRectMake(X, Y, W, H);
        
        [view addSubview:button];
    }
    
    return view;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects: @"女装",@"男装",@"内衣",@"美妆",@"配饰",@"鞋品",@"箱包",@"儿童",@"母婴",@"数码",@"家电",@"车品",@"文体",@"宠物",nil];
    }
    return _dataArray;
}

-(UIButton *)record{
    if (!_record) {
        _record = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _record;
}

-(UIButton *)TBTM{
    if (!_TBTM) {
        _TBTM = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _TBTM;
}











@end
