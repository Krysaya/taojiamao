//
//  TJPopViewController.h
//  taojiamao
//
//  Created by yueyu on 2018/8/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJBaseViewController.h"
@class TJHomePageModel;
@interface TJPopViewController : TJBaseViewController
@property (nonatomic, strong) TJHomePageModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;

@end
