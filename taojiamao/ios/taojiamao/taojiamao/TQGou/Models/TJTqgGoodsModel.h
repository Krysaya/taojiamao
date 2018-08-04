//
//  TJTqgGoodsModel.h
//  taojiamao
//
//  Created by yueyu on 2018/7/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//
/*
 "coupon_condition" = "9.00";
 couponexplain = "\U5355\U7b14\U6ee19\U5143\U53ef\U7528";
 couponmoney = 5;
 couponnum = 10000;
 couponreceive = 500;
 couponurl = "https://uland.taobao.com/quan/detail?sellerId=918605774&activityId=4bc0e3b193b84b2d93edbc4ab7fdcdb0";
 fqcat = 10;
 "general_index" = 277;
 itemdesc = "\U3010\U9001\U522e\U677f\U30114.9\U8d85\U9ad8\U8bc4\U5206\Uff01\U94dd\U7b94\U6750\U8d28\Uff0c\U8010\U9ad8\U6e29\U4e0d\U6613\U53d8\U5f62\Uff0c\U9632\U6c34\U9632\U6cb9\Uff0c\U4e00\U64e6\U5373\U51c0\Uff0c\U591a\U79cd\U82b1\U8272\Uff0c\U7ed9\U53a8\U623f\U6dfb\U52a0\U4e00\U62b9\U8272\U5f69\Uff0c\U7b54\U5e94\U6211\Uff0c\U590f\U5b63\U505a\U5c0f\U9f99\U867e\U5e26\U4e0a\U6211\U597d\U4e48\Uff1f\Uff01";
 itemendprice = "4.80";
 itemid = 569592729187;
 itempic = "https://img.alicdn.com/imgextra/i1/3012913363/TB2pwVfBStYBeNjSspkXXbU8VXa_!!3012913363.jpg";
 itemprice = "9.80";
 itemsale = 40983;
 itemsale2 = 83;
 itemshorttitle = "\U3010\U9001\U522e\U677f\U3011\U53a8\U623f\U9632\U6cb9\U8010\U9ad8\U6e29\U58c1\U7eb83";
 itemtitle = "\U53a8\U623f\U9632\U6cb9\U8d34\U7eb8\U8010\U9ad8\U6e29\U7076\U53f0\U7528\U81ea\U7c98\U9632\U6c34\U74f7\U7816\U6a71\U67dc\U53f0\U9762\U6cb9\U70df\U673a\U5899\U8d34\U58c1\U7eb8";
 shoptype = B;
 tkmoney = "1.92";
 tkrates = "40.00";
 tktype = "\U8425\U9500\U8ba1\U5212";
 tkurl = "<null>";
 todaysale = 83;
 */
#import <Foundation/Foundation.h>

@interface TJTqgGoodsModel : NSObject

@property (nonatomic,strong)  NSString *coupon_condition;
@property (nonatomic, strong) NSString *couponexplain;
@property (nonatomic, strong) NSString *couponmoney;
@property (nonatomic, strong) NSString *couponnum;
@property (nonatomic, strong) NSString *couponreceive;
@property (nonatomic, strong) NSString *couponurl;
@property (nonatomic, strong) NSString *fqcat;
@property (nonatomic, strong) NSString *general_index;
@property (nonatomic, strong) NSString *itemdesc;
@property (nonatomic, strong) NSString *itemendprice;
@property (nonatomic, strong) NSString *itemid;
@property (nonatomic, strong) NSString *itempic;
@property (nonatomic, strong) NSString *itemprice;
@property (nonatomic, strong) NSString *itemsale;
@property (nonatomic, strong) NSString *itemsale2;
@property (nonatomic, strong) NSString *itemshorttitle;
@property (nonatomic, strong) NSString *itemtitle;
@property (nonatomic, strong) NSString *shoptype;
@property (nonatomic, strong) NSString *tkmoney;
@property (nonatomic, strong) NSString *tkrates;
@property (nonatomic, strong) NSString *tktype;
@property (nonatomic, strong) NSString *tkurl;
@property (nonatomic, strong) NSString *todaysale;
@end
