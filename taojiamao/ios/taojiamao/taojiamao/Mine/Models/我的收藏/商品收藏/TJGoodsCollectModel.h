//
//  TJGoodsCollectModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/16.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJGoodsCollectModel : NSObject


// 这里服务端给的字段
@property (nonatomic, strong) NSString *id;//推荐理由
@property (nonatomic, strong) NSString *itemid;//
@property (nonatomic, strong) NSString *seller_id;//
@property (nonatomic, strong) NSString *itemdesc;//推荐理由
@property (nonatomic, strong) NSString *gid;//商品id
@property (nonatomic, strong) NSString *itemtitle;//商品
@property (nonatomic, strong) NSString *itemshorttitle;//商品
@property (nonatomic, strong) NSString *itemsale;//销量
@property (nonatomic, strong) NSString *todaysale;//当天销量
@property (nonatomic, strong) NSString *itempic;//图
@property (nonatomic, strong) NSString *itemendprice;//券后价
@property (nonatomic, strong) NSString *itemprice;//正常售价
@property (nonatomic, strong) NSString *fqcat;//类目
@property (nonatomic, strong) NSString *shoptype;//b淘宝 c天猫
@property (nonatomic, strong) NSString *taobao_image;//缩略图
@property (nonatomic, strong) NSString *url;//购买链接
@property (nonatomic, strong) NSString *sub_title;//子标题
@property (nonatomic, strong) NSString *itempic_copy;//商品长图
@property (nonatomic, strong) NSString *activity_type;//活动类型
@property (nonatomic, strong) NSString *guide_article;//推广文案
@property (nonatomic, strong) NSString *is_brand;//品牌状态 0未申请 1待审 2已审
//@property (nonatomic, strong) NSString *video;//视频地址
@property (nonatomic, strong) NSString *videoid;//视频id
@property (nonatomic, strong) NSString *tktype;//高佣金计划 隐藏 营销
@property (nonatomic, strong) NSString *tkrates;//比例佣金
@property (nonatomic, strong) NSString *userid;//店主
@property (nonatomic, strong) NSString *sellernick;//掌柜名

@property (nonatomic, strong) NSString *couponmoney;//优惠券金额
@property (nonatomic, strong) NSString *couponurl;//优惠券连接

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


// 最后新增字段
@property (nonatomic, assign) BOOL isChecked;


@end
