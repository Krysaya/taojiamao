//
//  TJArticlesListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/8/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

/*
 {
 "id": 9,    //文章ID
 "cate_id": 0,    //栏目ID
 "title": "我是一个程序员，我在改变世界",    //文章标题
 "subtitle": "程序员改变世界",    //文章副标题
 "description": "描述不能为空",    //文章描述
 "thumb": "http://pcmseq6……2425.jpeg",    //文章缩略图片
 "images": "[{"url":"h……:""}]",    //文章多图json后的数据
 "create_time": 0,    //文章创建时间
 "view_num": 0,    //文章查看数
 "comment_num": 0,    //评论数
 "like_num": 0,    //喜欢数
 "sort": 100,    //排序值
 "status": 0    //状态，0正常
 }
 */
#import <Foundation/Foundation.h>

@interface TJArticlesListModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *view_num;
@property (nonatomic, strong) NSString *like_num;
@property (nonatomic, strong) NSString *show_type;

@property (nonatomic, strong) NSString *comment_num;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *status;






@end
