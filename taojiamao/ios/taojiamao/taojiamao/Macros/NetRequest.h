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
//3首页商品分类
#define GOODSCATEGORY            [BASEURL stringByAppendingString:@"/api.php?s=index/index"]
//4首页banner
#define HOMEBANNER               [BASEURL stringByAppendingString:@"/api.php?s=index/flash"]
//5首页中部分类模块
#define HOMEMiddleModule         [BASEURL stringByAppendingString:@"/api.php?s=index/modle"]
//6获取验证码
#define GETVerfityCode           [BASEURL stringByAppendingString:@"/v1/members/vcode"]
//注册
#define RegisterApp              [BASEURL stringByAppendingString:@"/v1/members/register"]
//登录
#define LoginWithUserName        [BASEURL stringByAppendingString:@"/v1/members/login"]
//登录成功后的用户数据==个人中心
#define LoginedUserData          [BASEURL stringByAppendingString:@"/v1/members"]
//上传头像--个人中心
#define UploadHeaderImg          [BASEURL stringByAppendingString:@"/v1/members/head"]
//签到数据
#define MembersSigns          [BASEURL stringByAppendingString:@"/v1/members/signs"]
//消息通知
#define MessageNotice          [BASEURL stringByAppendingString:@"/v1/messages"]

//10余额明细
#define UserBalanceDetail        [BASEURL stringByAppendingString:@"/api.php?s=My/Accountbalance"]
//11修改密码
#define EditPassWord             [BASEURL stringByAppendingString:@"/v1/members/epass"]

//修改手机号
#define EditTelePhoneNum         [BASEURL stringByAppendingString:@"/v1/members/etele"]
//12忘记 找回密码
#define SubmitNewPass            [BASEURL stringByAppendingString:@"/v1/members/fpass"]
//13客户帮助
#define UserAssistance           [BASEURL stringByAppendingString:@"/api.php?s=My/kefu"]
//14客户帮助详情
#define UserAssistanceDetails    [BASEURL stringByAppendingString:@"/api.php?s=My/kefuinfo"]
//15获取代理的所属区域
#define UserAgencyArea           [BASEURL stringByAppendingString:@"/api.php?s=My/address"]
//16我的收货地址
#define UserAddress              [BASEURL stringByAppendingString:@"/api.php?s=My/myaddress"]
//17增加收货地址
#define UserAddAddress           [BASEURL stringByAppendingString:@"/api.php?s=My/myaddressadd"]
//18修改收货地址
#define UserUpdateAddress        [BASEURL stringByAppendingString:@"/api.php?s=My/updatemyaddress"]
//19我的集分宝
#define UserMineJFB              [BASEURL stringByAppendingString:@"/api.php?s=My/MyCollectionreasure"]
//20兑换集分
#define UserExchangeJF           [BASEURL stringByAppendingString:@"/api.php?s=my/Convertibility"]
//21集分详细
#define UserJFBDetails           [BASEURL stringByAppendingString:@"/api.php?s=my/Collectionoftreasures"]
//22首页底部cells数据 首页推介
#define HomeFootRecommend        [BASEURL stringByAppendingString:@"/api.php?s=index/fh_items"]

//tqg
#define TQGTimeChoose        [BASEURL stringByAppendingString:@"/v1/pages/tqg"]

//tqg--goods
#define TQGGoodsList        [BASEURL stringByAppendingString:@"/v1/tb/tqg"]













//
