//
//  TJJHSGoodsListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

/*
 {
 activity = "\U805a\U5212\U7b97";
 "activity_etime" = "<null>";
 "activity_id" = 0;
 "activity_stime" = "<null>";
 addtime = 1532645122;
 "brand_name" = "\U6021\U6069\U8d1d";
 cate = "\U6bcd\U5a74\U513f\U7ae5";
 cid = 4;
 coupon = 1;
 "coupon_condition" = 19;
 "coupon_expire" = 20180728;
 "coupon_latest" = 0;
 "coupon_money" = 5;
 "coupon_start_time" = "<null>";
 "coupon_total" = 100000;
 "coupon_url" = "https://uland.taobao.com/quan/detail?sellerId=2454549209&activityId=c7915e1b1f0942dc962632da4055ae68";
 "final_sales" = 403793;
 freight = 0;
 gid = 528731068410;
 id = 18832;
 "intro_foot" = "\U6021\U6069\U8d1d\U65b0\U751f\U513f\U6e7f\U7eb8\U5dfe\Uff0c\U6298\U7b97\U6bcf\U5305\U4ec52.9\U5143\Uff0c\U6e29\U6da6\U4eb2\U80a4\Uff0c\U7ef5\U67d4\U6d01\U51c0\Uff0c5\U5305*80\U62bd\Uff0c\U6708\U9500\U91cf30\U591a\U4e07\Uff0c\U7d2f\U8ba1200\U591a\U4e07\U597d\U8bc4\Uff01\U6bd4\U6279\U53d1\U8fd8\U5212\U7b97\Uff0c\U5168\U7f51\U75af\U62a2\U4e2d\Uff01";
 "is_brand" = 1;
 "long_pic" = "//s5.wgzapp.com/image/2018/0725/5b58910323514.jpg";
 "new_url" = "http://uland.taobao.com/coupon/edetail?activityId=c7915e1b1f0942dc962632da4055ae68&pid=mm_51786779_16868079_62182259&itemId=528731068410&src=shz_shz";
 "plan_high" = "<null>";
 price = "14.99";
 prime = "19.99";
 ratio = "20.00";
 "ratio_type" = "\U8425\U9500\U8ba1\U5212";
 "seller_id" = 2147483647;
 site = tmall;
 stoptime = 1532793599;
 "sub_title" = "\U3010\U6021\U6069\U8d1d\U3011\U5a74\U513f\U65b0\U751f\U513f\U6e7f\U5dfe5\U5305*80\U62bd";
 thumb = "//img.alicdn.com/imgextra/i1/1024006928/TB2I5PzGN1YBuNjy1zcXXbNcXXa_!!1024006928.png";
 timeline = 1532566888;
 title = "einb\U5a74\U513f\U6e7f\U5dfe\U65b0\U751f\U513f\U5b9d\U5b9d\U6e7f\U7eb8\U5dfe\U624b\U53e3\U5c41\U4e13\U752880\U62bd5\U5305100\U6210\U4eba\U6279\U53d1\U5e26\U76d6";
 url = "https://detail.tmall.com/item.htm?id=528731068410";
 video = "/50160972688";
 "video_id" = "<null>";
 },
 */
#import <Foundation/Foundation.h>

@interface TJJHSGoodsListModel : NSObject
@property (nonatomic, strong) NSString *product_id;
@property (nonatomic, strong) NSString *itemid;//
@property (nonatomic, strong) NSString *seller_id;//
@property (nonatomic, strong) NSString *itemdesc;//推荐理由
@property (nonatomic, strong) NSString *gid;//商品id
@property (nonatomic, strong) NSString *itemtitle;//商品
@property (nonatomic, strong) NSString *itemshorttitle;//商品
@property (nonatomic, strong) NSString *tbk_pwd;
@property (nonatomic, strong) NSString *itemsale;//销量
@property (nonatomic, strong) NSString *todaysale;//当天销量
@property (nonatomic, strong) NSString *itempic;//图
@property (nonatomic, strong) NSString *itemendprice;//券后价
@property (nonatomic, strong) NSString *itemprice;//正常售价
@property (nonatomic, strong) NSString *fqcat;//类目
@property (nonatomic, strong) NSString *shoptype;//店铺类型
@property (nonatomic, strong) NSString *taobao_image;//头图
@property (nonatomic, strong) NSArray *content_images;//详情图
@property (nonatomic, strong) NSString *url;//购买链接
@property (nonatomic, strong) NSString *sub_title;//子标题
@property (nonatomic, strong) NSString *itempic_copy;//商品长图
@property (nonatomic, strong) NSString *activity_type;//活动类型
@property (nonatomic, strong) NSString *guide_article;//推广文案
@property (nonatomic, strong) NSString *is_brand;//品牌状态 0未申请 1待审 2已审
//@property (nonatomic, strong) NSString *video;//视频地址
@property (nonatomic, strong) NSString *videoid;//视频id
@property (nonatomic, strong) NSString *tktype;//高佣金计划 隐藏 营销
@property (nonatomic, strong) NSString *tkmoney;//
@property (nonatomic, strong) NSString *tkurl;
@property (nonatomic, strong) NSString *tkrates;//比例佣金
@property (nonatomic, strong) NSString *userid;//店主
@property (nonatomic, strong) NSString *sellernick;//dian名
@property (nonatomic, strong) NSString *is_collect;//收藏
@property (nonatomic, strong) NSString *couponmoney;//优惠券金额
@property (nonatomic, strong) NSString *couponurl;//优惠券连接
@property (nonatomic, strong) NSString *coupon_short_url;//优惠券daun连接

@property (nonatomic, strong) NSString *couponsurplus;//优惠券总数
@property (nonatomic, strong) NSString *couponreceive;//当前已领优惠券
@property (nonatomic, strong) NSString *couponreceive2;//近两小时优惠券领取量
@property (nonatomic, strong) NSString *coupon_expire;//券有效期
@property (nonatomic, strong) NSString *coupon_condition;//券使用条件，满20可用
@property (nonatomic, strong) NSString *start_time;//开始时间
@property (nonatomic, strong) NSString *end_time;//结束时间
@property (nonatomic, strong) NSString *starttime;//发布时间

@property (nonatomic, strong) NSString *cid;//分类id
@property (nonatomic, strong) NSString *news_url;//二合一链接
@property (nonatomic, strong) NSString *coupon_start_time;//优惠券开始时间
@property (nonatomic, strong) NSString *activity_stime;//活动开始时间
@property (nonatomic, strong) NSString *activity_etime;//活动结束时间
@property (nonatomic, strong) NSString *activityid;//活动id
@property (nonatomic, strong) NSString *addtime;//添加时间
@property (nonatomic, strong) NSString *rebate;


@end
