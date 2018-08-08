//
//  StringMacros.h
//  taojiamao
//
//  Created by yueyu on 2018/4/26.
//  Copyright © 2018年 yueyu. All rights reserved.
//


#ifndef StringMacros_h
#define StringMacros_h

#import "FuctionTools.h"


//RGB
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
//主色
#define KALLRGB [UIColor colorWithRed:255/255.0 green:71/255.0 blue:119/255.0 alpha:1.0]
//背景
#define KBGRGB [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
//快递背景
#define KKDRGB [UIColor colorWithRed:81/255.0 green:162/255.0 blue:249/255.0 alpha:1.0]

//随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//输出
//#ifdef DEBUG
//#define DSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#define DSLog(...)
//#endif

#ifdef DEBUG
#define NSLog(...) printf("%s[%s line:%d] %s\n", formattedLogDate(), __FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
#ifdef DEBUG
#define DSLog(...) printf("%s[%s line:%d] %s\n", formattedLogDate(), __FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define DSLog(FORMAT, ...) nil
#endif



//布局
#define S_F   [UIScreen mainScreen].bounds
#define S_S   [UIScreen mainScreen].bounds.size
#define S_W   [UIScreen mainScreen].bounds.size.width
#define S_H   [UIScreen mainScreen].bounds.size.height
#define W_Scale S_W/375
#define H_Scale (S_H == 812.0 ? 667.0/667.0 : S_H/667.0)//iPhone X的高宽比和iPhone 8的一样

#define SafeAreaTopHeight (S_H == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (S_H == 812.0 ? 34 : 0)

//检测程序是在真机上还是在模拟器上
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//weakSelf
#define WeakSelf __weak typeof(self) weakSelf = self;


//用户中心数据
#define GetUserDefaults(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]

#define SetUserDefaults(a,b) {\
NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];\
[defa setObject:a forKey:b];\
[defa synchronize];\
};\

#define RemoveUserDefaults(a){\
NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];\
[defa removeObjectForKey:a];\
[defa synchronize];\
};\

#define MAX_V(X,Y) ((X) > (Y) ? (X) : (Y))// 求两个数中的最大值

//常用对象
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

//打开设置
#define OpenSystemSetting {\
NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];\
if([[UIApplication sharedApplication] canOpenURL:url]) {\
[[UIApplication sharedApplication] openURL:url];\
}\
}
//粪叉
#define IsX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 懒加载
#define HT_LAZY(object, assignment) (object = object ?: assignment)














#endif /* StringMacros_h */
















