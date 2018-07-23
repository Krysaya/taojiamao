//
//  TJGetVerifyCode.m
//  taojiamao
//
//  Created by yueyu on 2018/5/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJGetVerifyCode.h"
#import "XMNetworking.h"
@interface TJGetVerifyCode()

@property(nonatomic,assign)dispatch_source_t timer;

@end

@implementation TJGetVerifyCode

+ (instancetype)sharedInstance
{
    static TJGetVerifyCode *client;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        client = [[TJGetVerifyCode alloc] init];
    });
    return client;
}


-(void)getVerityWithURL:(NSString*)url withParams:(NSDictionary*)param withButton:(TJButton*)but withBlock:(ReceiveSMS)sms{

    [self openCountdownWith:but];
//    return;
    NSString * mobile = param[@"telephone"];
    if ([TJOverallJudge judgeMobile:mobile]) {
        but.userInteractionEnabled = NO;
//        NSInteger phoneNum = [mobile integerValue];
        NSDictionary * dict = @{@"telephone":mobile};
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSMutableDictionary *head = @{
            @"timestamp": timeStr,
             @"app": @"ios",
            @"telephone": mobile,
        }.mutableCopy;
                            
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:head withSecert:@"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"];
    
        
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = url;
            request.parameters = dict;
            request.httpMethod = kXMHTTPMethodPOST;
            request.responseSerializerType = kXMResponseSerializerRAW;
            
            request.headers = @{@"app":@"ios",@"timestamp":timeStr,@"sign":md5Str};
        } onSuccess:^(id  _Nullable responseObject) {
            NSLog(@"----code-success==%@",responseObject);

//            NSInteger  code = responseObject[@"code"];
//            int codeNum = [code intValue];
//            if (codeNum==100) {
//                DSLog(@"发送成功");
//                //                [self openCountdown];
//                if (sms) sms(YES);
//            }else{
//                DSLog(@"失败");
//                but.userInteractionEnabled = YES;
//                if (sms) sms(NO);
//            }
        } onFailure:^(NSError * _Nullable error) {
            NSLog(@"------code==error==%@",error);
            if (sms) sms(NO);
            but.userInteractionEnabled = YES;
        }];
    
    }else{
        NSLog(@"手机号格式不正确");
        if (sms) sms(NO);
    }

}
#pragma mark -openCountdown
-(void)openCountdownWith:(TJButton*)but{
    __block NSInteger time = 59;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                but.title = @"重新发送";
                but.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
//            DSLog(@"%d",seconds);1522
            dispatch_async(dispatch_get_main_queue(), ^{
//                DSLog(@"%@",but);
                but.title =[NSString stringWithFormat:@"重新发送(%.2d)", seconds];
                but.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
-(void)cancelTimer{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer=nil;
    }
}
@end
