//
//  TJTQGouController.m
//  taojiamao
//
//  Created by yueyu on 2018/4/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTQGouController.h"
#import "TJTQGContentController.h"
#import "WMPageController.h"
#define RightMargin 44*W_Scale
#define TopHeight 50*H_Scale


@interface TJTQGouController ()
@property(nonatomic,strong)NSMutableArray * contents;
//@property(nonatomic,strong)NSMutableArray<TJGoodsCategory*>*category;
@end

@implementation TJTQGouController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIImageView *headerImg = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@""]];
    self.navigationItem.titleView = headerImg;
    [self setPageControllers];

  
//

    // Do any additional setup after loading the view.
}
-(void)setPageControllers{
    
    self.menuViewStyle = WMMenuViewStyleLine;
    self.selectIndex = 0;
    self.titleSizeNormal = 13;
    self.titleSizeSelected = 14;
    self.menuItemWidth = 93*W_Scale;
    self.menuView.backgroundColor = [UIColor blackColor];
    
//    self.progressColor = KALLRGB;
//    self.progressHeight = 50;
//    self.contents = [[NSMutableArray array]init];
    

}

#pragma mark - requestGoodsChooseNet
//-(void)requestGoodsChooseNet{
//    //test1
//    NSDictionary * parm = @{ };
//    [XDNetworking postWithUrl:GOODSCATEGORY refreshRequest:NO cache:YES params:parm progressBlock:nil successBlock:^(id response) {
//        DSLog(@"%@",[response class]);
//        //先清空存储
//        [self.category removeAllObjects];
//        NSArray * dict = response[@"data"];
//        TJGoodsCategory * model = [[TJGoodsCategory alloc]init];
//        model.name = @"全部";
//        model.id = AllId;
//        [self.category addObject:model];
//        for (NSDictionary* d in dict) {
//            TJGoodsCategory * model = [TJGoodsCategory yy_modelWithDictionary:d];
//            [self.category addObject:model];
//        }
//        NSMutableArray * temp =[NSMutableArray array];
//        for (TJGoodsCategory*model in self.category) {
//            [temp addObject:model.name];
//        }
//        self.titles = temp.copy;
//        [self reloadData];
//    } failBlock:^(NSError *error) {
//        DSLog(@"%@",error);
//    }];
//}

#pragma mark -WMPageControllerSetting
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    NSLog(@"====%ld",self.titles.count);
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    NSLog(@"====%@",self.titles[index]);

    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    TJTQGContentController * ccvc = [[TJTQGContentController alloc] init];
//    ccvc.testName = self.titles[index];
    return ccvc;
}
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
//    return width;
//}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, S_W - 2*leftMargin,TopHeight);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}
- (WMMenuItem *)menuView:(WMMenuView *)menu initialMenuItem:(WMMenuItem *)initialMenuItem atIndex:(NSInteger)index{
    
//    NSString *str = 
    NSString *time = @"08:00";
    NSString *status = @"已开抢";
    NSString *info = [NSString stringWithFormat:@"%@\n%@",time,status];
    initialMenuItem.text = info;
    return initialMenuItem;
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index{
    
        return [UIColor whiteColor];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - lazyloading
//- (NSMutableArray *)contents{
//    if (_contents==nil) {
//        _contents = [[NSMutableArray array]initWithObjects:@"08：00已开抢",@"08：00已开抢",@"08：00已开抢",@"08：00已开抢",@"08：00已开抢",@"08：00已开抢",nil];
//    }
//    return _contents;
//}

- (NSArray *)titles {
    return @[@"08：00已开抢",@"09：00已开抢",@"10：00已开抢",@"11：00已开抢",@"12：00已开抢",@"08：00已开抢"];
}

//-(NSMutableArray<TJGoodsCategory *> *)category{
//    if (!_category) {
//        _category = [NSMutableArray array];
//    }
//    return _category;
//}


@end
