//
//  TJBottomPopupView.m
//  taojiamao
//
//  Created by yueyu on 2018/5/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBottomPopupView.h"

#define LQButtonMid   357
#define BottomCancelB 358
#define TKLCopy       359
@interface TJBottomPopupView()<UIGestureRecognizerDelegate,TJButtonDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView * backView;

@property(nonatomic,strong)UICollectionView * FWCollectionView;
@property(nonatomic,strong)NSArray * FWData;
@property (nonatomic, strong) NSString *content;
@property(nonatomic,strong)UITableView * CSTableView;

@end

@implementation TJBottomPopupView

-(instancetype)initWithFrame:(CGRect)frame select:(CGFloat)select height:(CGFloat)h info:(id)info{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-h, frame.size.width, h)];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        
//        self.FWData = [NSArray arrayWithArray:(NSArray*)info];
        self.content = (NSString *)info;
        if (select == 2) {
            DSLog(@"淘口令");
            [self showDifferentViewWithTKL];

//            [self showDifferentViewWithLQ];
//        }else if (select==3){
//            DSLog(@"服务");
//            [self showDifferentViewWithFW];
//        }else if (select==4){
//            DSLog(@"参数");
//            [self showDifferentViewWithCS];
//        }else if (select==5){
        }
    }
    return self;
}
#pragma mark -showDifferentViewWithTKL
-(void)showDifferentViewWithTKL{
    WeakSelf
    TJLabel * title = [TJLabel setLabelWith:@"宝贝淘口令" font:15 color:RGB(77, 77, 77)];
    [self.backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.top.mas_equalTo(24);
    }];
    
    UIView * middle = [[UIView alloc]initWithFrame:CGRectMake(30, 66, S_W-30*W_Scale*2, 180)];
    middle.backgroundColor = [UIColor whiteColor];
    [self addBorderToLayer:middle];
    [self.backView addSubview:middle];
    
    TJLabel * title_content = [TJLabel setLabelWith:self.content font:15 color:RGB(77, 77, 77)];
    [middle addSubview:title_content];
    [title_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(middle);
        make.top.mas_equalTo(middle.mas_top).offset(25);
    }];
    
    TJButton * over = [[TJButton alloc]initWith:@"一键复制" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:KALLRGB tag:TKLCopy cornerRadius:20.0];
    [self.backView addSubview:over];
    [over mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(S_W-24);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark -showDifferentViewWithCS
-(void)showDifferentViewWithCS{
    WeakSelf
    TJLabel * title = [TJLabel setLabelWith:@"产品参数" font:15 color:RGB(77, 77, 77)];
    [self.backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.top.mas_equalTo(24*H_Scale);
    }];
    
    [self.backView addSubview:self.CSTableView];
    
    TJButton * over = [[TJButton alloc]initWith:@"完成" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:BottomCancelB cornerRadius:20.0];
    [self.backView addSubview:over];
    [over mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(351*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}
#pragma mark -showDifferentViewWithFW
-(void)showDifferentViewWithFW{
    WeakSelf
    TJLabel * title = [TJLabel setLabelWith:@"基础服务" font:15 color:RGB(77, 77, 77)];
    [self.backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.top.mas_equalTo(24*H_Scale);
    }];
    
    [self.backView addSubview:self.FWCollectionView];
    
    TJButton * over = [[TJButton alloc]initWith:@"完成" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:BottomCancelB cornerRadius:20.0];
    [self.backView addSubview:over];
    [over mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(351*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}
#pragma mark - showDifferentViewWithLQ
-(void)showDifferentViewWithLQ{
    WeakSelf
    TJLabel * title = [TJLabel setLabelWith:@"商品详情" font:15 color:RGB(77, 77, 77)];
    [self.backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.top.mas_equalTo(24*H_Scale);
    }];
    TJButton * lq = [[TJButton alloc]initDelegate:self backColor:nil tag:LQButtonMid withBackImage:@"quan1" withSelectImage:nil];
    [self.backView addSubview:lq];
    [lq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.top.mas_equalTo(title.mas_bottom).offset(27*H_Scale);
        make.width.mas_equalTo(336*W_Scale);
        make.height.mas_equalTo(94*H_Scale);
    }];
    TJLabel * num = [TJLabel setLabelWith:@"90" font:49 color:[UIColor whiteColor]];
    num.textInsets = UIEdgeInsetsMake(0.f, 0.f, -19.f, 0.f);
    [self.backView addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lq);
        make.left.mas_equalTo(58*W_Scale);
    }];
    
    TJLabel * symbol = [TJLabel setLabelWith:@"￥" font:16 color:[UIColor whiteColor]];
    [self.backView addSubview:symbol];
    [symbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(num.mas_bottom);
        make.right.mas_equalTo(num.mas_left).offset(-10*W_Scale);
    }];
    
    TJLabel * quan = [TJLabel setLabelWith:@"优惠券" font:26 color:[UIColor whiteColor]];
    [self.backView addSubview:quan];
    [quan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(num.mas_bottom);
        make.left.mas_equalTo(num.mas_right).offset(10*W_Scale);
    }];
    
    
    TJButton * over = [[TJButton alloc]initWith:@"完成" delegate:self font:17*W_Scale titleColor:[UIColor whiteColor] backColor:[UIColor redColor] tag:BottomCancelB cornerRadius:20.0];
    [self.backView addSubview:over];
    [over mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.backView);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(351*W_Scale);
        make.height.mas_equalTo(40*H_Scale);
    }];
}
#pragma mark - tapClick
-(void)tapClick{
    if (self.deletage && [self.deletage respondsToSelector:@selector(clickViewRemoveFromSuper)]) {
        [self.deletage clickViewRemoveFromSuper];
    }
}
#pragma mark - TJButtonDeletage
-(void)buttonClick:(UIButton *)but{
    if (but.tag == BottomCancelB) {
        [self removeFromSuperview];
    }else if(but.tag==LQButtonMid){
        DSLog(@"领券");
    }else if(but.tag==TKLCopy){
        DSLog(@"一键复制");
        [self.deletage buttonCopyClick];
    }
    
}
#pragma mark - GesrureRecognizerDeletage
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.backView]) {
        return NO;
    }
    return YES;
}
#pragma mark - setter getter
-(UICollectionView *)FWCollectionView{
    if (_FWCollectionView==nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(S_W/2, 50);
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        _FWCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65*W_Scale, S_W, 200*H_Scale) collectionViewLayout:layout];
        _FWCollectionView.backgroundColor = RandomColor;
        _FWCollectionView.delegate=self;
        _FWCollectionView.dataSource=self;
        [_FWCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GoodsDetailsFWCell"];
    }
    return _FWCollectionView;
}
-(UITableView *)CSTableView{
    if (!_CSTableView) {
        _CSTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66*H_Scale, S_W, 418*H_Scale) style:UITableViewStylePlain];
        _CSTableView.delegate = self;
        _CSTableView.dataSource =self;
        _CSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_CSTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GoodsDetailsCSCell"];
    }
    return _CSTableView;
}
#pragma mark -UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.FWData.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsDetailsFWCell" forIndexPath:indexPath];
    
    UIImageView * im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goods_bg.jpg"]];
    [cell.contentView addSubview:im];
    [im mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50*W_Scale);
        make.centerY.mas_equalTo(cell.contentView);
        make.width.height.mas_equalTo(15*W_Scale);
    }];
    TJLabel * la = [TJLabel setLabelWith:self.FWData[indexPath.item] font:13 color:RGB(51, 51, 51)];
    [cell.contentView addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(im);
        make.left.mas_equalTo(im.mas_right).offset(8);
    }];
    
    return cell;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailsCSCell" forIndexPath:indexPath];
    TJLabel * label1 = [TJLabel setLabelWith:@"销售渠道类型" font:13 color:RGB(102, 102, 102)];
    [cell.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(39*W_Scale);
    }];
    
    TJLabel * label2 = [TJLabel setLabelWith:@"闹手" font:13 color:RGB(51, 51, 51)];
    [cell.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.right.mas_equalTo(-39*W_Scale);
    }];
    
    return cell;
}

#pragma mrak - 加边框
- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
   
    border.strokeColor = KALLRGB.CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:15].CGPath;
    
    border.frame = view.bounds;
   
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @3];
    
    [view.layer addSublayer:border];
}



















@end
