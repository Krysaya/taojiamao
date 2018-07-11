//
//  TJGetVerifyCode.h
//  taojiamao
//
//  Created by yueyu on 2018/5/5.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReceiveSMS)(BOOL isGood);

@interface TJGetVerifyCode : NSObject

+ (instancetype)sharedInstance;

-(void)getVerityWithURL:(NSString*)url withParams:(NSDictionary*)param withButton:(TJButton*)but withBlock:(ReceiveSMS)sms;
-(void)cancelTimer;
@end
