//
//  TJGoodsInfoListModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJGoodsInfoListModel : NSObject

@property (nonatomic, strong) NSString *gid;//淘宝商品id
@property (nonatomic, strong) NSString *cate;//分类名称
@property (nonatomic, strong) NSString *site;//所属站点
@property (nonatomic, strong) NSString *title;//商品标题
@property (nonatomic, strong) NSString *price;//券后价
@property (nonatomic, strong) NSString *prime;//正常价格
@property (nonatomic, strong) NSString *thumb;//商品主图
@property (nonatomic, strong) NSString *url;//商品链接
@property (nonatomic, strong) NSString *ratio;//佣金比例
@property (nonatomic, strong) NSString *sub_title;//商品简称
@property (nonatomic, strong) NSString *intro_foot;//推广文案
@property (nonatomic, strong) NSString *long_pic;//
@property (nonatomic, strong) NSString *activity;//活动
@property (nonatomic, strong) NSString *is_brand;//品牌状态
@property (nonatomic, strong) NSString *brand_name;//品牌名称
@property (nonatomic, strong) NSString *freight;//运费险
@property (nonatomic, strong) NSString *ratio_type;//
@property (nonatomic, strong) NSString *video_id;//
@property (nonatomic, strong) NSString *plan_high;//
@property (nonatomic, strong) NSString *final_sales;//最终销量
@property (nonatomic, strong) NSString *coupon_money;//优惠券金额
@property (nonatomic, strong) NSString *coupon_url;//优惠券链接
@property (nonatomic, strong) NSString *coupon_total;//优惠券总量
@property (nonatomic, strong) NSString *coupon_latest;//最终领券
@property (nonatomic, strong) NSString *coupon_expire;//券有效期
@property (nonatomic, strong) NSString *coupon_condition;//券使用条件，满
@property (nonatomic, strong) NSString *timeline;//修改时间
@property (nonatomic, strong) NSString *stoptime;//结束时间
@property (nonatomic, strong) NSArray *detail;//详情图
@property (nonatomic, strong) NSArray *related;//相关产品





@end
