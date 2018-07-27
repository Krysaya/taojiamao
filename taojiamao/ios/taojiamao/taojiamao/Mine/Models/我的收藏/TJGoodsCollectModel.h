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
@property (nonatomic, strong) NSString *intro_foot;//推荐理由
@property (nonatomic, strong) NSString *gid;//商品id
@property (nonatomic, strong) NSString *title;//商品id

@property (nonatomic, strong) NSString *brand_name;//
@property (nonatomic, strong) NSString *freight;//运费险
@property (nonatomic, strong) NSString *price;//券后价
@property (nonatomic, strong) NSString *ratio;//佣金比例
@property (nonatomic, strong) NSString *prime;//正常售价
@property (nonatomic, strong) NSString *thumb;//缩略图
@property (nonatomic, strong) NSString *url;//购买链接
@property (nonatomic, strong) NSString *sub_title;//子标题
@property (nonatomic, strong) NSString *long_pic;//商品长图
@property (nonatomic, strong) NSString *activity;//活动类型
@property (nonatomic, strong) NSString *is_brand;//品牌状态 0未申请 1待审 2已审
@property (nonatomic, strong) NSString *video;//视频地址
@property (nonatomic, strong) NSString *video_id;//视频id
@property (nonatomic, strong) NSString *plan_high;//高佣金计划地址
@property (nonatomic, strong) NSString *final_sales;//最终销量
@property (nonatomic, strong) NSString *coupon;//是否有优惠券 0无 1有
@property (nonatomic, strong) NSString *coupon_money;//优惠券金额
@property (nonatomic, strong) NSString *coupon_url;//优惠券连接

@property (nonatomic, strong) NSString *coupon_total;//优惠券总数
@property (nonatomic, strong) NSString *coupon_latest;//当前已领优惠券
@property (nonatomic, strong) NSString *coupon_expire;//券有效期
@property (nonatomic, strong) NSString *coupon_condition;//券使用条件，满20可用
@property (nonatomic, strong) NSString *timeline;//更新时间
@property (nonatomic, strong) NSString *stoptime;//结束时间
@property (nonatomic, strong) NSString *cid;//分类id
@property (nonatomic, strong) NSString *news_url;//二合一链接
@property (nonatomic, strong) NSString *coupon_start_time;//优惠券开始时间
@property (nonatomic, strong) NSString *seller_id;//卖家id
@property (nonatomic, strong) NSString *activity_stime;//活动开始时间
@property (nonatomic, strong) NSString *activity_etime;//活动结束时间
@property (nonatomic, strong) NSString *activity_id;//活动id
@property (nonatomic, strong) NSString *addtime;//添加时间



// 最后新增字段
@property (nonatomic, assign) BOOL isChecked;


@end
