//
//  TJContetenCollectListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/30.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJContetenCollectListModel : NSObject


@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *gid;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
//@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *view_num;
@property (nonatomic, strong) NSString *like_num;
@property (nonatomic, strong) NSString *show_type;
@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *comment_num;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *status;


@property (nonatomic, assign) BOOL isChecked;

@end
