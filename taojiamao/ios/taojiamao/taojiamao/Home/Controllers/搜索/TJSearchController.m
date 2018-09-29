//
//  TJSearchController.m
//  taojiamao
//
//  Created by yueyu on 2018/5/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//   搜索

#import "TJSearchController.h"
#import "TJSearchContentController.h"
#import "TJFiltrateView.h"
#import "TJJHSGoodsListModel.h"
#import "TJSuperSearchController.h"

@interface TJSearchController ()<UITextFieldDelegate,ZJScrollPageViewDelegate,TJButtonDelegate>

@property(nonatomic,strong)UIView * naview;
@property(nonatomic,strong)TJTextField * search;
@property (nonatomic, strong) ZJContentView *contentView;
@property (nonatomic, strong) ZJScrollSegmentView *segment;

@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) NSString *indexxx;
@property (nonatomic, strong) TJSearchContentController *vc1;
@property (nonatomic, strong) TJSuperSearchController *vc2;
@end

@implementation TJSearchController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(255, 255, 255);
    [self setNavSerachBar];
    // 必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    TJSearchContentController *vc1 = [[TJSearchContentController alloc]init];
    TJSuperSearchController *vc2 = [[TJSuperSearchController alloc]init];

    self.childVCs = @[vc1,vc2];
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KALLRGB;
    style.scrollLineColor = KALLRGB;
    style.scrollLineSize = CGSizeMake(70, 2);
    style.scrollContentView = NO;
    
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 10+SafeAreaTopHeight, 200, 30) segmentStyle:style delegate:self titles:@[@"本站搜索",@"超级搜索"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    self.segment = segment;
    segment.center = CGPointMake(self.view.center.x, 90);
    [self.view addSubview:segment];

    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, SafeAreaTopHeight+30+20, S_W, S_H - SafeAreaTopHeight -50) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];

    
}

-(void)setNavSerachBar{

    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_left"] forState:UIControlStateNormal];
    [backButton setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    self.naview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W-140, 32)];
    self.search = [TJTextField setTextFieldWith:@"请输入搜索内容" font:15 textColor:RGB(51, 51, 51) backColor:RGB(222, 222, 222)];
    self.search.text = self.searchText;
//    self.search.end
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    label.backgroundColor = [UIColor clearColor];
    self.search.leftViewMode = UITextFieldViewModeAlways;
    self.search.leftView = label;
    self.search.frame = self.naview.bounds;
    self.search.layer.cornerRadius = 16;
    self.search.layer.masksToBounds = YES;
    self.search.returnKeyType = UIReturnKeySearch;
    self.search.delegate = self;
    
    [self.naview addSubview:self.search];
    self.navigationItem.titleView = self.naview;
    
    //    you边按钮
    TJButton *button_right = [[TJButton alloc]initWith:@"搜索" delegate:self font:16 titleColor:KALLRGB backColor:nil tag:478];
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_right];
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)buttonClick:(UIButton *)but{
    DSLog(@"-butttt--%@--%ld===%@--indexxxx",self.searchText,self.zj_currentIndex,self.indexxx);
//    self.zj_currentIndex = [self.indexxx integerValue];
    [self.contentView reload];
    NSInteger index = [self.indexxx integerValue];
    [self.segment setSelectedIndex:index animated:YES];


}
#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return _childVCs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    self.indexxx = [NSString stringWithFormat:@"%ld",index];
   
    if (index==0) {
    
        TJSearchContentController *vc = _childVCs[index];
        vc.strsearch = [TJOverallJudge stringContainCharactersInSet:self.searchText];

    }else{
        TJSuperSearchController *vc = _childVCs[index];
        vc.strsearch = [TJOverallJudge stringContainCharactersInSet:self.searchText];

    }
    return _childVCs[index];
    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}
#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DSLog(@"%@",textField.text);
    self.searchText = textField.text;
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.searchText = textField.text;
    return YES;
}
-(void)dealloc{
//    DSLog(@"%s",__func__);
}
@end
