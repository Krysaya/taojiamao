//
//  TJCollectController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJCollectController.h"
#import "ZJScrollPageView.h"
#import "TJGoodsCollectController.h"
#import "TJContentCollectController.h"
#import "TJGoodsListCell.h"
#import "TJContentListCell.h"
#import "TJGoodsCollectModel.h"
#import "TJContetenCollectListModel.h"
@interface TJCollectController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJContentView *contentView;
@property (nonatomic, strong) NSArray *childVCs;
//底部全选背景
@property(nonatomic,weak) UIView *bottomBgView;
@property(nonatomic,assign) NSInteger isSelect;

@property (nonatomic, strong) NSMutableArray *dataArr_collcet;
@property (nonatomic, strong) TJGoodsCollectController *vc1;
@property (nonatomic, strong) TJContentCollectController *vc2;
@end

@implementation TJCollectController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestGoodsCollcetion:@"1"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    TJGoodsCollectController *vc1 = [[TJGoodsCollectController alloc]init];
    self.vc1 = vc1;
    TJContentCollectController *vc2 = [[TJContentCollectController alloc]init];
    self.vc2 = vc2;
    _childVCs = @[vc1,vc2];
    
    //    self.title = @"我的收藏";
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    style.showLine= YES;
    style.scrollTitle = NO;
    style.adjustCoverOrLineWidth = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.normalTitleColor = RGB(51, 51, 51);
    style.selectedTitleColor = KALLRGB;
    style.scrollLineColor = KALLRGB;
    style.scrollLineSize = CGSizeMake(40, 2);
    style.scrollContentView = NO;
    WeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc]initWithFrame:CGRectMake(0, 10, 200, 30) segmentStyle:style delegate:self titles:@[@"商品收藏",@"内容收藏"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
       [weakSelf.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    self.navigationItem.titleView = segment;
    
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64, S_W, S_H - 64 - SafeAreaBottomHeight) segmentView:segment parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:content];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    [self setupBottomStatus];
}

- (void)requestGoodsCollcetion:(NSString *)type{
//    收藏列表
    self.dataArr_collcet = [NSMutableArray array];
    
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                @"type":type
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = GoodsCollection;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.requestSerializerType = kXMRequestSerializerRAW;
        request.parameters = @{@"type":type};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"--success-===%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        if ([type intValue]==1) {
            self.dataArr_collcet = [TJGoodsCollectModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.vc1.dataArr = self.dataArr_collcet;
                [self.vc1.goodsTabView reloadData];
                
            });
        }else{
//            neirong
            self.dataArr_collcet = [TJContetenCollectListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.vc2.dataArr = self.dataArr_collcet;
                [self.vc2.contentTabView reloadData];
                
            });
        }
        
        
    } onFailure:^(NSError * _Nullable error) {
        DSLog(@"--error%@",error);
        NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
        DSLog(@"-收藏-≈≈error-msg=======dict%@",dic_err);
    }];
}
#pragma mark - 编辑
- (void)editClick:(UIButton *)sender{
    
    if (self.isSelect==0) {
        NSLog(@"sp--%@",sender.titleLabel.text);
        TJGoodsCollectController *vc = _childVCs[0];

//        点击 编辑--编辑状态
//           -完成--取消
        if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
            [sender setTitle:@"完成" forState:UIControlStateNormal];
            
            //           编辑
                [self updateMasonrys];
                [UIView animateWithDuration:0.5 animations:^{
                    vc.goodsTabView.frame = CGRectMake(0, 0, S_W, S_H-50);
                    [vc.view layoutIfNeeded];
                    
                }];
            
            vc.goodsEditStatus = YES;
            
        }else{
            [sender setTitle:@"编辑" forState:UIControlStateNormal];
            TJGoodsCollectController *vc = _childVCs[0];
    
            [self resetMasonrys];
            [UIView animateWithDuration:0.5 animations:^{
                vc.goodsTabView.frame = CGRectMake(0, 0, S_W, S_H);
                [vc.view layoutIfNeeded];
                
            }];
            vc.goodsEditStatus = NO;
        

        }
        
        [vc.goodsTabView reloadData];

    }else{
        NSLog(@"nr");
        TJContentCollectController *vc = _childVCs[1];

        if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
            [sender setTitle:@"完成" forState:UIControlStateNormal];
            
            //           编辑
            [self updateMasonrys];
            [UIView animateWithDuration:0.5 animations:^{
                vc.contentTabView.frame = CGRectMake(0, 0, S_W, S_H-50);
                [vc.view layoutIfNeeded];
                
            }];
            vc.contentEditStatus = YES;
            
        }else{
            [sender setTitle:@"编辑" forState:UIControlStateNormal];
            [self resetMasonrys];
            [UIView animateWithDuration:0.5 animations:^{
                vc.contentTabView.frame = CGRectMake(0, 0, S_W, S_H);
                [vc.view layoutIfNeeded];
                
            }];
            vc.contentEditStatus = NO;
        }
        [vc.contentTabView reloadData];

    }
}

//Method
- (void)updateMasonrys{
    [self.bottomBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
        make.height.mas_equalTo(@50);
    }];
}
- (void)resetMasonrys{
    [self.bottomBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(50);
        make.height.mas_equalTo(@50);
    }];
}


//底部
- (void)setupBottomStatus{
    UIView *bottomBgView = [[UIView alloc]init];
    bottomBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBgView];
    [bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(44);
        make.height.mas_equalTo(@44);
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"取消收藏" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelCollect:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KALLRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 15;
    [bottomBgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(bottomBgView.mas_right).offset(-12);
    }];
    self.bottomBgView = bottomBgView;

}
- (void)cancelCollect:(UIButton *)sender
{
  
    if (self.isSelect==0) {
//        商品
        DSLog(@"sp");
    }else{
//         内容
        DSLog(@"-cancel--%ld",self.vc2.selectArr.count);
        
        NSString *userid = GetUserDefaults(UID);
        if (userid) {
        }else{
            userid = @"";
        }
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSString *strGid = self.vc2.selectArr.mj_JSONString;
        NSString *a = [strGid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"type":@"2",
                                    @"gid":a,
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        DSLog(@"--%@==str=sign=%@=",strGid,md5Str);
        
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = CancelGoodsCollect;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.httpMethod = kXMHTTPMethodPOST;
            request.parameters = @{
                                   @"gid":strGid,
                                   @"type":@"2",};
        } onSuccess:^(id  _Nullable responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showSuccessWithStatus:@"取消成功！"];
                [self.vc2.contentTabView reloadData];
            });
            
        } onFailure:^(NSError * _Nullable error) {
            DSLog(@"--error%@",error);
            NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
            DSLog(@"-delete-≈≈error-msg=======dict%@",dic_err);
        }];
        
    }
}
#pragma mark- ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return _childVCs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    self.isSelect = index;
    NSString *str = [NSString stringWithFormat:@"%ld",index+1];
    [self requestGoodsCollcetion:str];
    return _childVCs[index];
   
}


- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}


@end
