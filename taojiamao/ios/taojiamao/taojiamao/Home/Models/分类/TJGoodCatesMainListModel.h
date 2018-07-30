//
//  TJGoodCatesMainListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 "1": {
 "cid": 1,
 "pid": 0,
 "catname": "女装",
 "imgurl": null,
 "isshow": 1,
 "sort": 100,
 "_depth": 0,
 "_parents": 0,
 "_childs": "14,15,16,17,18,19",
 "_allchilds": "1,14,15,16,17,18,19"
 },

 */
#import <Foundation/Foundation.h>

@interface TJGoodCatesMainListModel : NSObject

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *pid;//分类的父分类id
@property (nonatomic, strong) NSString *catname;//分类名称
@property (nonatomic, strong) NSString *imgurl;//分类图片
@property (nonatomic, strong) NSString *isshow;//是否显示
@property (nonatomic, strong) NSString *sort;//分类排序
@property (nonatomic, strong) NSString *_depth;//分类深度
@property (nonatomic, strong) NSString *_parents;//祖先分类id集合
@property (nonatomic, strong) NSString *_childs;//子分类id集合
@property (nonatomic, strong) NSString *_allchilds;//后代分类id集合
@property (nonatomic, strong) NSDictionary *_sons;



@end
