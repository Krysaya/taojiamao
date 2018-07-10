//
//  TJRankingListController.m
//  taojiamao
//
//  Created by yueyu on 2018/6/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJRankingListController.h"
#import "TJAwardController.h"
#import "TJInviteController.h"
@interface TJRankingListController ()
{
    NSMutableDictionary *_listDict;
}
@property(nonatomic,strong)TJAwardController *awardC;
@property(nonatomic,strong)TJInviteController *inviteC;


@end

@implementation TJRankingListController

-(TJAwardController *)awardC{
    if (_awardC == nil) {
        _awardC = [[TJAwardController alloc]init];
    }
    return _awardC;
}

-(TJInviteController *)inviteC{
    if (_inviteC == nil) {
        _inviteC = [[TJInviteController alloc]init];
    }
    return _inviteC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _listDict = [NSMutableDictionary dictionary];
    NSArray *arr = @[@"奖励排行",@"邀请排行"];
    UISegmentedControl *segmentC = [[UISegmentedControl alloc]initWithItems:arr];
    segmentC.frame = CGRectMake(0, 0, 180, 30);

    segmentC.selectedSegmentIndex = 0;
    segmentC.tintColor = RGB(245, 73, 118);//245,73,118
    [segmentC
     addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentC;
    [self.view addSubview:self.awardC.view];
    
    // Do any additional setup after loading the view.
}

//根据字典中是否存在相关页面对应的key，没有的话存储
- (UIViewController *)controllerForSegIndex:(NSUInteger)segIndex {
    NSString *keyName = [NSString stringWithFormat:@"VC_%ld",segIndex];
    
    UIViewController *controller = (UIViewController *)[_listDict objectForKey:keyName];
    
    if (!controller) {
        if (segIndex == 0) {//奖励
            controller = self.awardC;
            
        }else {//邀请
            controller = self.inviteC;
        }
        [_listDict setObject:controller forKey:keyName];
    }
    
    return controller;
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
{
    NSUInteger segIndex = [sender selectedSegmentIndex];
    UIViewController *controller = [self controllerForSegIndex:segIndex];
    NSArray *array2 = [self.view subviews];
    //NSLog(@"array2-->%@",array2);
    //将当旧VC的view移除，然后在添加新VC的view
    if (array2.count != 0) {
        if (segIndex == 0) {
            [_awardC.view removeFromSuperview];
            NSLog(@"remove--oneVC");
        }else {
            [_inviteC.view removeFromSuperview];
            NSLog(@"remove--twoVC");
        }
    }
    [self.view addSubview:controller.view];
    
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
