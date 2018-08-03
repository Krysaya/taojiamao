//
//  NetRequest.h
//  taojiamao
//
//  Created by yueyu on 2018/4/25.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#ifndef NetRequest_h
#define NetRequest_h


#endif /* NetRequest_h */

//static NSString * const CompanyID = @"80179";
static NSString * const Auth_code = @"auth_code";
static NSString * const UID = @"id";
static NSString * const TOKEN = @"token";
static NSString * const UserPhone = @"UserPhone";
//关键字宏
#define ISFIRST      @"isFirst"
#define HADLOGIN     @"HadLogin"
#define SECRET       @"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"


//1基础接口
#define BASEURL @"http://dev.api.taojiamao.net"
//2启动页
#define LaunchImage              [BASEURL stringByAppendingString:@"/api.php?s=index/qad"]
//3首页
#define HomePages            [BASEURL stringByAppendingString:@"/v1/pages/index"]

//首页-精选表
#define HomePageGoods            [BASEURL stringByAppendingString:@"/v1/goods/jing"]

//6获取验证码
#define GETVerfityCode           [BASEURL stringByAppendingString:@"/v1/members/vcode"]
//注册
#define RegisterApp              [BASEURL stringByAppendingString:@"/v1/members/register"]
//登录
#define LoginWithUserName        [BASEURL stringByAppendingString:@"/v1/members/login"]
//登录成功后的用户数据==个人中心
#define LoginedUserData          [BASEURL stringByAppendingString:@"/v1/members"]
//会员中心
#define MembersCenter          [BASEURL stringByAppendingString:@"/v1/pages/members"]

//上传头像--个人中心
#define UploadHeaderImg          [BASEURL stringByAppendingString:@"/v1/members/head"]
//签到数据
#define MembersSigns          [BASEURL stringByAppendingString:@"/v1/members/signs"]
//消息通知
#define MessageNotice          [BASEURL stringByAppendingString:@"/v1/messages"]


//pl列表
#define CommentsList          [BASEURL stringByAppendingString:@"/v1/comments"]

//商品收藏表
#define GoodsCollection          [BASEURL stringByAppendingString:@"/v1/collections"]

//取消收藏
#define CancelGoodsCollect          [BASEURL stringByAppendingString:@"/v1/goods/ccoll"]

//商品搜索
#define SearchGoods          [BASEURL stringByAppendingString:@"/v1/goods/search"]
//搜索表
#define SearchGoodsList          [BASEURL stringByAppendingString:@"/v1/goods"]

//超级搜索
#define SuperSearchGoodsList          [BASEURL stringByAppendingString:@"/v1/goods/suppersearch"]

//明细
#define UserBalanceDetail        [BASEURL stringByAppendingString:@"/v1/members/jifen"]

//足迹
#define MineFootPrint        [BASEURL stringByAppendingString:@"/v1/foots"]

//11修改密码
#define EditPassWord             [BASEURL stringByAppendingString:@"/v1/members/epass"]
//设置体现账户
#define SetAliAccount             [BASEURL stringByAppendingString:@"/v1/members/aliAccount"]

//修改手机号
#define EditTelePhoneNum         [BASEURL stringByAppendingString:@"/v1/members/etele"]
//12忘记 找回密码
#define SubmitNewPass            [BASEURL stringByAppendingString:@"/v1/members/fpass"]

// 头条
#define NewsArticles            [BASEURL stringByAppendingString:@"/v1/articles"]

//tqg
#define TQGTimeChoose        [BASEURL stringByAppendingString:@"/v1/pages/tqg"]

//tqg--goods
#define TQGGoodsList        [BASEURL stringByAppendingString:@"/v1/tb/tqg"]


//jhs
#define JHSGoodsList        [BASEURL stringByAppendingString:@"/v1/tb/jhs"]

//商品详情页
#define GoodsInfoList        [BASEURL stringByAppendingString:@"/v1/tb"]
//商品分类
#define GoodsClassicList        [BASEURL stringByAppendingString:@"/v1/cates/goods"]

//添加收藏
#define AddCollect        [BASEURL stringByAppendingString:@"/v1/collections/coll"]







//
