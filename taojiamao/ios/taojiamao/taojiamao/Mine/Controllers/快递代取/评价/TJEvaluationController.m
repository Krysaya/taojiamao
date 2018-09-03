
//
//  TJEvaluationController.m
//  taojiamao
//
//  Created by yueyu on 2018/8/8.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJEvaluationController.h"
#import "HYBStarEvaluationView.h"
#import "SQButtonTagView.h"
@interface TJEvaluationController ()<DidChangedStarDelegate>
@property (nonatomic, strong) SQButtonTagView *tagV;
@property (nonatomic, strong) NSMutableArray *tagsArr;
@property (nonatomic, strong) NSMutableArray *tagstrArr;
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) NSString *scoreStr;
@end

@implementation TJEvaluationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestCommentsTags];
    self.title = @"评价";self.scoreStr = @"1";
    [self setGiveStar];
}
- (void)setGiveStar{
//    评价
    HYBStarEvaluationView *starView = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(80, 109, S_W-160, 30) numberOfStars:5 isVariable:YES];
    starView.actualScore = 1;
    starView.fullScore = 5;
    starView.delegate = self;
    [self.view addSubview:starView];
    
    UILabel *lab  = [[UILabel alloc]initWithFrame:CGRectMake(0, 159, S_W, 25)];
    lab.text = @"觉得怎么样，打个分吧~";
    lab.textColor = RGB(225, 225, 225);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
}

- (void)setPingJiaTag{
    
    NSInteger i = ceilf(self.tagsArr.count/4.0);

    UIView *view_bg = [[UIView alloc]initWithFrame:CGRectMake(10, 190, S_W-20, 125+40*i)];
    view_bg.layer.masksToBounds = YES;
    view_bg.layer.cornerRadius = 6 ;
    view_bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_bg];
    
//    tag
    SQButtonTagView *tagView = [[SQButtonTagView alloc]initWithTotalTagsNum: self.tagsArr.count viewWidth:S_W-40 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor grayColor] colorWithAlphaComponent:1] selectedTagTextColor:KKDRGB selectedBackgroundColor:[KKDRGB colorWithAlphaComponent:0.5]];
//    tagView.tagTexts = @[@"态度很好",@"人很nice",@"服务态度好",@"人长得帅",@"人长得漂亮",@"有礼貌",@"有耐心",@"很准时"];
    tagView.tagTexts = self.tagsArr;
    tagView.selectBlock = ^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray) {
        DSLog(@"--select--%ld--%@",selectArray.count,selectArray[0]);
        for (int i=0; i<selectArray.count; i++) {
            NSString * index = [selectArray objectAtIndex:i];
            NSString *str  = [self.tagsArr objectAtIndex:[index intValue]];
            DSLog(@"---%d--%@",i,str);
            [self.tagstrArr addObject:str];
        }
        
        DSLog(@"-cccc--%ld",self.tagstrArr.count);
    };
    tagView.frame = CGRectMake(15, 30, S_W-30-20, 40*i);
    [view_bg addSubview:tagView];self.tagV = tagView;
//    line
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, tagView.frame.size.height+tagView.frame.origin.y+15, S_W-30-20, 1)];
    img.backgroundColor = KBGRGB;
    [view_bg addSubview:img];
//    textview
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, img.frame.origin.y+15, S_W-40, 80)];
    tv.scrollEnabled = NO;
    [view_bg addSubview:tv];self.textV = tv;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 190+125+40*i+25, S_W-20, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTickClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = KKDRGB;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
    
    
}

- (void)requestCommentsTags{
    self.tagsArr = [NSMutableArray array];
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = KdUserCommentsTags;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        self.tagsArr = responseObject[@"data"][@"tag"];
        [self setPingJiaTag];

    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
- (void)btnTickClick:(UIButton *)sender{
    NSString *userid = GetUserDefaults(UID);
    if (userid) {
    }else{
        userid = @"";
    }
    
    if ([TJOverallJudge judgeBlankString:self.textV.text]) {
        [SVProgressHUD showInfoWithStatus:@"输入不能为空！"];
    }else{
        KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
        NSString *timeStr = [MD5 timeStr];
        NSString *cont = [self.textV.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        DSLog(@"---%ld",self.tagstrArr.count);
        NSString *jsonStr = [self.tagstrArr mj_JSONString];
        NSMutableDictionary *md = @{
                                    @"timestamp": timeStr,
                                    @"app": @"ios",
                                    @"uid":userid,
                                    @"kuaidi_id":self.kdid,
                                    @"daili_id":self.dali_id,
                                    @"score":self.scoreStr,
                                    @"content":cont,
                                    @"tags":[jsonStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                    
                                    }.mutableCopy;
        NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.url = KdUserReleaseComments;
            request.headers = @{@"timestamp": timeStr,
                                @"app": @"ios",
                                @"sign":md5Str,
                                @"uid":userid,
                                };
            request.parameters = @{   @"kuaidi_id":self.kdid,
                                      @"daili_id":self.dali_id,
                                      @"score":self.scoreStr,
                                      @"content":self.textV.text,
                                      @"tags":jsonStr,};
            request.httpMethod = kXMHTTPMethodPOST;
        } onSuccess:^(id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"评论成功！"];[self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(NSError * _Nullable error) {
            DSLog(@"--error%@",error);

            [SVProgressHUD showInfoWithStatus:@"评论失败，请重试！"];
            NSData * errdata = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSDictionary *dic_err=[NSJSONSerialization JSONObjectWithData:errdata options:NSJSONReadingMutableContainers error:nil];
            DSLog(@"-delete-≈≈error-msg=======dict%@",dic_err);
//            [SVProgressHUD showInfoWithStatus:dic_err[@"msg"]];
        }];
    }
   
}
#pragma mark - star--deleagte

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)didChangeStar:(CGFloat)score {

//    NSInteger i = [score flo]
    DSLog(@"---score--%d",(int)score);
    self.scoreStr = [NSString stringWithFormat:@"%d",(int)score];
}
#pragma mark - tag
//- (void)selectAction:(void(^)(SQButtonTagView *tagView, NSArray *selectArray))block{
//    DSLog(@"---select--%ld");
//
//}
- (NSMutableArray *)tagstrArr{
    if (!_tagstrArr) {
        _tagstrArr = [NSMutableArray array];
    }
    return _tagstrArr;
}
@end
