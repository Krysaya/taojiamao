
//
//  TJPopViewController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJPopViewController.h"
#import "TJHomePageModel.h"
#import "TJLoginController.h"
#import "TJInvitePrizeController.h"
@interface TJPopViewController ()
@end

@implementation TJPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//    [self.img addGestureRecognizer:tap];
//    self.view.backgroundColor = RGBA(255, 255, 255, 0.1);
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModel:(TJHomePageModel *)model{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"pop_img"]];
}
- (IBAction)btnClick:(UIButton *)sender {
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
        [TJPublicURL goAnyViewController:self withidentif:self.model.flag withParam:nil];

    }else{
        TJLoginController * lvc = [[TJLoginController alloc]init];
        [TJAppManager sharedTJAppManager].loginVC = lvc;
        [self presentViewController:lvc animated:NO completion:nil];
    }

}


@end
