
//
//  TJKdOrderPayController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/18.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJKdOrderPayController.h"
#import "TJKdMyQuanController.h"
#import "TJKdMyQuanModel.h"
#import "TJKdOrderInfoModel.h"
@interface TJKdOrderPayController ()<MyQuanControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_total;
@property (weak, nonatomic) IBOutlet UILabel *lab_sjf;
@property (weak, nonatomic) IBOutlet UILabel *lab_dyq;
@property (weak, nonatomic) IBOutlet UILabel *lab_jjf;
@property (weak, nonatomic) IBOutlet UIButton *btn_zfb;
@property (weak, nonatomic) IBOutlet UIButton *btn_wx;

@property (weak, nonatomic) IBOutlet UIButton *btn_yue;
@property (weak, nonatomic) IBOutlet UILabel *lab_status;
@property (weak, nonatomic) IBOutlet UIView *view_bottom;

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSString *select_status;
@property (nonatomic, strong) NSString *qid;

@end

@implementation TJKdOrderPayController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self showModel];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseQuan)];
    [self.view_bottom addGestureRecognizer: tap];
    self.selectBtn = self.btn_zfb;
//    self.lab_sjf.text = self.model.qu_fee;
//    self.lab_jjf.text = self.model.is_ji;
//    if ([self.model.is_ji intValue]==6) {
//        self.lab_jjf.text = @"10.00";
//    }
//    int a = [self.lab_jjf.text intValue];
//    int b = [self.lab_sjf.text intValue];
//    int c = [self.lab_dyq.text intValue];
//    self.lab_total.text = [NSString stringWithFormat:@"362%d.00",a+b+c];
    [self showModel];
}

- (void)showModel{
    self.lab_sjf.text = [NSString  stringWithFormat:@"¥ %@.00", self.model.qu_fee];
    self.lab_jjf.text =  [NSString  stringWithFormat:@"¥ %@.00", self.model.is_ji];;
    
    if ([self.model.is_ji intValue]==6) {
        self.lab_jjf.text = @"¥ 10.00";
    }
    int a = [self.model.qu_fee intValue];
    int b = [self.model.is_ji intValue];
    self.lab_total.text = [NSString stringWithFormat:@"%d.00",a+b];
}
- (void)setModel:(TJKdOrderInfoModel *)model{
    _model = model;
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选优惠券
- (void)chooseQuan{
    TJKdMyQuanController *vc = [[TJKdMyQuanController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getQuanInfoValue:(TJKdMyQuanModel *)quanModel{
    self.qid = quanModel.id;
    self.lab_dyq.text = [NSString  stringWithFormat:@"-¥ %@.00", quanModel.coupon];
    self.lab_status.text = [NSString  stringWithFormat:@"- ¥ %@.00", quanModel.coupon];
    self.lab_sjf.text = [NSString  stringWithFormat:@"¥ %@.00", self.model.qu_fee];
    if ([self.model.is_ji intValue]==6) {
        self.lab_jjf.text = @"¥ 10.00";
    }
    self.lab_jjf.text =  [NSString  stringWithFormat:@"¥ %@.00", self.model.is_ji];;

    
    int sjf;
    int jjf;
    int dyq;
    
    sjf = [self.model.qu_fee intValue];
    if ([self.model.is_ji intValue]==6) {jjf = 10;}else{jjf = [self.model.is_ji intValue];}
    dyq = [quanModel.coupon intValue];

    int total = sjf+jjf-dyq;
    if (total>0) {
        self.lab_total.text = [NSString stringWithFormat:@"%d.00",total];
    }else{
        self.lab_total.text = @"0.00";
    }
}
- (IBAction)choosePayType:(UIButton *)sender {
    if (!sender.selected) {
        self.selectBtn.selected = !self.selectBtn.selected;
        sender.selected = !sender.selected;
        self.selectBtn = sender;
    }
    
    if (self.selectBtn==_btn_zfb) {
        self.select_status = @"1";
    }else if(self.selectBtn==_btn_wx){
        self.select_status = @"2";
    }else{
        self.select_status = @"3";
    }
}

- (IBAction)payButtonClick:(UIButton *)sender {
//    判断状态
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
                                @"quan_id":self.qid,
                                @"kuaidi_id":self.model.id,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdOrderYuePay;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{ @"quan_id":self.qid,
                                @"kuaidi_id":self.model.id,};
    } onSuccess:^(id  _Nullable responseObject) {
        DSLog(@"----pay=-success-===%@",responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}


@end
