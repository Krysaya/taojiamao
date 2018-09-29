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
static NSString * const Bind_TB = @"bind_tb";
static NSString * const Bind_WX = @"bind_wx";
static NSString * const Ali_name = @"ali_true_name";
static NSString * const Ali_account = @"ali_account";
static NSString * const Balance = @"balance";
static NSString * const TB_Pid = @"51786779_16868079_62182259";
static NSString * const UserPhone = @"UserPhone";
//关键字宏
#define ISFIRST      @"isFirst"
#define HADLOGIN     @"HadLogin"
#define SECRET       @"uFxH^dFsVbah1tnxA%LXrwtDIZ4$#XV5"


//1基础接口
#define BASEURL @"http://dev.api.taojiamao.net"
//2启动页
#define LaunchImageRequest              [BASEURL stringByAppendingString:@"/api.php?s=index/qad"]
//3首页
#define HomePages                [BASEURL stringByAppendingString:@"/v1/pages/index"]

//首页-精选表
#define HomePageGoods            [BASEURL stringByAppendingString:@"/v1/goods/jing"]

//6获取验证码
#define GETVerfityCode           [BASEURL stringByAppendingString:@"/v1/members/vcode"]
//注册
#define RegisterApp              [BASEURL stringByAppendingString:@"/v1/members/register"]
//登录
#define LoginWithUserName        [BASEURL stringByAppendingString:@"/v1/members/login"]
//淘宝登录
#define TaoBaoLogin              [BASEURL stringByAppendingString:@"/v1/members/taologin"]

//微信登录
#define WeiXinLogin              [BASEURL stringByAppendingString:@"/v1/members/wxlogin"]

//登录成功后的用户数据==个人中心
#define LoginedUserData          [BASEURL stringByAppendingString:@"/v1/members"]
//会员中心
#define MembersCenter            [BASEURL stringByAppendingString:@"/v1/pages/members"]

//会员中心--我的资产
#define MembersBalance            [BASEURL stringByAppendingString:@"/v1/pages/tixian"]


//绑定淘宝
#define BindTaoBao            [BASEURL stringByAppendingString:@"/v1/members/taobao"]
//取消绑定淘宝
#define CancelBindTaoBao            [BASEURL stringByAppendingString:@"/v1/members/untaobao"]

//上传头像--个人中心
#define UploadHeaderImg          [BASEURL stringByAppendingString:@"/v1/members/head"]
//修改昵称--个人中心
#define UploadMemebersNick       [BASEURL stringByAppendingString:@"/v1/members/nick"]

//各位置广告数据
#define KAllAdPosters            [BASEURL stringByAppendingString:@"/v1/posters/"]

//签到数据
#define MembersSigns             [BASEURL stringByAppendingString:@"/v1/members/signs"]
//消息通知
#define MessageNotice            [BASEURL stringByAppendingString:@"/v1/messages"]
//排行榜
#define RanksList                [BASEURL stringByAppendingString:@"/v1/ranks"]

//我的订单类别
#define MyOrderList                [BASEURL stringByAppendingString:@"/v1/orders/taobao"]

//我的订单--详情
//#define MyOrderListContent                [BASEURL stringByAppendingString:@"/v1/orders/taobao/ID"]


//拆红包
#define RegisterHongBao            [BASEURL stringByAppendingString:@"/v1/hongbaos/hongbao"]

//拆红包记录
#define RegisterHongBaoLog            [BASEURL stringByAppendingString:@"/v1/hongbaos/log"]


//粉丝
#define MemeberFans              [BASEURL stringByAppendingString:@"/v1//members/fans"]
//pl列表
#define CommentsList             [BASEURL stringByAppendingString:@"/v1/comments"]


//发布评论
#define PulishComments           [BASEURL stringByAppendingString:@"/v1/comments/acomment"]

//zan
#define CommentsPraises          [BASEURL stringByAppendingString:@"/v1/praises"]

//商品收藏表
#define GoodsCollection          [BASEURL stringByAppendingString:@"/v1/collections"]

//取消收藏
#define CancelGoodsCollect       [BASEURL stringByAppendingString:@"/v1/collections/ccoll"]

//商品搜索
#define SearchGoods              [BASEURL stringByAppendingString:@"/v1/goods/search"]
//搜索表
#define SearchGoodsList          [BASEURL stringByAppendingString:@"/v1/goods"]

//超级搜索
#define SuperSearchGoodsList     [BASEURL stringByAppendingString:@"/v1/goods/suppersearch"]

//集分明细
#define UserBalanceDetail        [BASEURL stringByAppendingString:@"/v1/members/jifen"]

//提现记录
#define UserBalanceTakeList        [BASEURL stringByAppendingString:@"/v1/tixians"]

//足迹
#define MineFootPrint            [BASEURL stringByAppendingString:@"/v1/foots"]
//客服
#define MineAssistanceHelp       [BASEURL stringByAppendingString:@"/v1/help"]

//fe分享
#define KShareUrl                [BASEURL stringByAppendingString:@"/v1/shares"]
//11修改密码
#define EditPassWord             [BASEURL stringByAppendingString:@"/v1/members/epass"]
//设置体现账户
#define SetAliAccount            [BASEURL stringByAppendingString:@"/v1/members/aliAccount"]

//提现
#define    UserBalanceTiXian            [BASEURL stringByAppendingString:@"/v1/tixians/tixian"]

//修改手机号
#define EditTelePhoneNum         [BASEURL stringByAppendingString:@"/v1/members/etele"]
//12忘记 找回密码
#define SubmitNewPass            [BASEURL stringByAppendingString:@"/v1/members/fpass"]

// 头条
#define NewsArticles             [BASEURL stringByAppendingString:@"/v1/articles"]

// 头条详情
#define NewsArticlesInfo             [BASEURL stringByAppendingString:@"/v1/topgood/tgdetail"]

//发现-*----
#define HPFindGoods            [BASEURL stringByAppendingString:@"/v1/findgood/fglist"]

//tqg
#define TQGTimeChoose            [BASEURL stringByAppendingString:@"/v1/pages/tqg"]

//tqg--goods
#define TQGGoodsList             [BASEURL stringByAppendingString:@"/v1/tb/tqg"]


//jhs
#define JHSGoodsList             [BASEURL stringByAppendingString:@"/v1/tb/jhs"]

//商品详情页
#define GoodsInfoList            [BASEURL stringByAppendingString:@"/v1/tb"]
//商品详情页--购买追踪
#define GoodsInfoTBK            [BASEURL stringByAppendingString:@"/v1/tbs/view"]

//商品详情页
#define GoodsInfoFoot            [BASEURL stringByAppendingString:@"/v1/foots/foot"]

//商品分类
#define GoodsClassicList         [BASEURL stringByAppendingString:@"/v1/cates/goods"]

//商9.9
#define GoodsJiuJiuList          [BASEURL stringByAppendingString:@"/v1/goods/jiu"]

//添加收藏
#define AddCollect               [BASEURL stringByAppendingString:@"/v1/collections/coll"]

//------------------k快递
//收货地址列表
#define AddressList              [BASEURL stringByAppendingString:@"/v1/addresses"]

//添加地址
#define AddAddress              [BASEURL stringByAppendingString:@"/v1/addresses/address"]

//修改地址
#define EditAddress             [BASEURL stringByAppendingString:@"/v1/addresses/eaddress"]

//删除地址
#define DeleteAddress           [BASEURL stringByAppendingString:@"/v1/addresses/daddress"]


//设置地址
#define SettingAddress          [BASEURL stringByAppendingString:@"/v1/addresses/default"]

//所有地区
#define AllAreasList            [BASEURL stringByAppendingString:@"/v1/areas"]

//学校列表
#define SchoolList              [BASEURL stringByAppendingString:@"/v1/schools"]

//添加学校
#define KdAddSchool             [BASEURL stringByAppendingString:@"/v1/schools/school"]

//会员中心--升级代理人
#define UpgradeAgent        [BASEURL stringByAppendingString:@"/v1/levels/goods"]

//会员中心--代理人--等级列表
#define AgenterLevel        [BASEURL stringByAppendingString:@"/v1/levels"]

//会员中心--购买代理--q创建订单
#define BuyAgentsCreatList        [BASEURL stringByAppendingString:@"/v1/levels/cgoods"]

//会员中心--购买--余额支付
#define BuyAgentsPay        [BASEURL stringByAppendingString:@"/v1/levels/pay"]

//我是代理 - -v1/levels/qrcode
#define MyAgentLevel       [BASEURL stringByAppendingString:@"/v1/levels/materiel"]

//用户-快递-订单详情
#define KdUserOrderDetail       [BASEURL stringByAppendingString:@"/v1/kuaidis/detail"]

//用户-快递-取消订单
#define KdUserOrderCancel       [BASEURL stringByAppendingString:@"/v1/kuaidis/ckuaidi"]

//用户-快递-修改订单
#define KdUserEditOrder         [BASEURL stringByAppendingString:@"/v1/kuaidis/ekuaidi"]

//用户-快递-发布订单
#define KdUserReleaseOrder      [BASEURL stringByAppendingString:@"/v1/kuaidis/kuaidi"]
//用户-快递-发布评论
#define KdUserReleaseComments      [BASEURL stringByAppendingString:@"/v1/comments/kuaidi"]

//用户-快递-评论标签
#define KdUserCommentsTags      [BASEURL stringByAppendingString:@"/v1/kuaidis/tag"]
//用户/商户-快递-订单列表
#define KdOrderList        [BASEURL stringByAppendingString:@"/v1/kuaidis"]
//用户/商户-快递-取件地址
#define KdQuAddress        [BASEURL stringByAppendingString:@"/v1/addresses/qujian"]

//商户-快递-个人信息
#define KdAgentsInfo        [BASEURL stringByAppendingString:@"/v1/agents/gagent"]


//商户-快递-意见反馈
#define FeedBack        [BASEURL stringByAppendingString:@"/v1/feedbacks/feedback"]
//商户-快递-我的团队
#define KdMyTeam        [BASEURL stringByAppendingString:@"/v1/agents/team"]

//商户-快递-申请代理
#define KdApplyAgent        [BASEURL stringByAppendingString:@"/v1/agents/agent"]
//
//商户-快递-抢单
#define KdQiangOrder        [BASEURL stringByAppendingString:@"/v1/kuaidis/qiang"]

//kd--我的券
#define KdMyQuan        [BASEURL stringByAppendingString:@"/v1/coupons"]

//kd--支付
#define KdOrderYuePay        [BASEURL stringByAppendingString:@"/v1/kuaidis/pay"]
//kd--支付宝支付加签
#define KdOrderAliPaySign        [BASEURL stringByAppendingString:@"/v1/alipays/signstring"]






