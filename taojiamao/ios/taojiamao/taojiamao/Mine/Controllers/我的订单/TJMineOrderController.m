//
//  TJMineOrderController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/2.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMineOrderController.h"
#import "TJTaoBaoOrderController.h"
#import "TJMallOrdersController.h"
@interface TJMineOrderController ()
{
    NSMutableDictionary *_listDic;
}

@property(nonatomic,strong)TJTaoBaoOrderController *taobVC;
@property (nonatomic, strong) TJMallOrdersController *mallVC;
@end


@implementation TJMineOrderController

- (TJTaoBaoOrderController *)taobVC{
    if (!_taobVC) {
        _taobVC = [[TJTaoBaoOrderController alloc]init];
    }
    return _taobVC;
}
- (TJMallOrdersController *)mallVC{
    if (!_mallVC) {
        _mallVC = [[TJMallOrdersController alloc]init];
    }
    return _mallVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _listDic = [NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
    //先生成存放标题的数据
    NSArray *array = [NSArray arrayWithObjects:@"淘宝订单",@"商城订单", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    
    segment.tintColor = KALLRGB;
    //根据内容定分段宽度
    segment.apportionsSegmentWidthsByContent = YES;
    //开始时默认选中下标(第一个下标默认是0)
    segment.selectedSegmentIndex = 0;
    //添加事件
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    //添加到视图
    self.navigationItem.titleView = segment;
    [self.view addSubview:self.taobVC.view];

    
}


//根据字典中是否存在相关页面对应的key，没有的话存储
- (UIViewController *)controllerForSegIndex:(NSUInteger)segIndex {
    NSString *keyName = [NSString stringWithFormat:@"VC_%ld",segIndex];
    
    UIViewController *controller = (UIViewController *)[_listDic objectForKey:keyName];
    
    if (!controller) {
        if (segIndex == 0) {//申请
            controller = self.taobVC;
            
        }else if (segIndex == 1) {//待办
            controller = self.mallVC;
        }
        [_listDic setObject:controller forKey:keyName];
    }
    
    return controller;
}




//点击不同分段就会有不同的事件进行相应
-(void)change:(UISegmentedControl *)sender{
    NSUInteger segIndex = [sender selectedSegmentIndex];
    UIViewController *controller = [self controllerForSegIndex:segIndex];
    NSArray *array2 = [self.view subviews];
    NSLog(@"array2-->%@",array2);
    //将当旧VC的view移除，然后在添加新VC的view
    if (array2.count != 0) {
        if (segIndex == 0) {
            [_mallVC.view removeFromSuperview];
            NSLog(@"remove--oneVC");
        }else if (segIndex == 1){
            [_taobVC.view removeFromSuperview];
            NSLog(@"remove--twoVC");
        }
    }
    [self.view addSubview:controller.view];
    
    //NSArray *sub = [self.view subviews];
    //NSLog(@"sub-->%@",sub);
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

