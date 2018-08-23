
//
//  TJHomeSignController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomeSignController.h"
#import "TJSignRuleController.h"
#import "TJSignSuccessController.h"
#import "FSCalendar.h"
#import "TJSignCalendarCell.h"
#import "SJAttributeWorker.h"
#import "TJSignListModel.h"
#import "TJSignNumsModel.h"
#define RIGHTBT  568

@interface TJHomeSignController ()<TJButtonDelegate,UIScrollViewDelegate,FSCalendarDelegate,FSCalendarDataSource,iCarouselDelegate,iCarouselDataSource>

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;

@property(strong,nonatomic)NSMutableArray*dataArr;
@property (nonatomic, strong) NSArray *bannerArr;
@property (nonatomic, strong) UILabel *lab_page;//精选1/3
@property (nonatomic, strong) iCarousel *icaroursel;
@property (nonatomic, strong) FSCalendar *calendar;

@property (nonatomic, strong) UIButton *signBtn;

@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UILabel *lab_total;//签到总人数


@property (nonatomic, strong) NSString *signStatus;
@end

@implementation TJHomeSignController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self RequestSignInfoWithType:kXMHTTPMethodGET];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"签到规则" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    self.dateFormatter2.dateFormat = @"yyyy-MM-dd";

    [self setOnClick];
    [self setCalendarCollectionView];
    [self setSignBtn];
    [self setSelectedTopicScroll];
}

- (void)RequestSignInfoWithType:(XMHTTPMethodType )methodtype
{
    KSortingAndMD5 *MD5 = [[KSortingAndMD5 alloc]init];
    NSString *timeStr = [MD5 timeStr];
    NSString *userid = GetUserDefaults(UID);
    
    if (userid) {       
    }else{
        userid = @"";
    }
    NSMutableDictionary *md = @{
                                @"timestamp": timeStr,
                                @"app": @"ios",
                                @"uid":userid,
                                }.mutableCopy;
    NSString *md5Str = [MD5 sortingAndMD5SignWithParam:md withSecert:SECRET];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = MembersSigns;
        request.headers = @{@"timestamp": timeStr,
                            @"app": @"ios",
                            @"sign":md5Str,
                            @"uid":userid,
                            };
        request.httpMethod = methodtype;
    } onSuccess:^(id  _Nullable responseObject) {
   
        NSLog(@"----sign-success-===%@",responseObject);
        if (methodtype==kXMHTTPMethodPOST) {
            

            TJSignSuccessController *successVc = [[TJSignSuccessController alloc]init];
            successVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            
            [self presentViewController:successVc animated:NO completion:^{
                [self RequestSignInfoWithType:kXMHTTPMethodGET];
            }];
        }else{
            self.bannerArr = [NSArray array];
            self.bannerArr = responseObject[@"data"][@"banner"];
            
            NSMutableArray *arr = [TJSignListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            self.dataArr = [[NSMutableArray array]init];

            for (TJSignListModel *model in arr) {
                NSString *time = [self.dateFormatter2 stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.addtime doubleValue]]];
                [self.dataArr addObject:time];
            }
            
            TJSignNumsModel *m = [TJSignNumsModel mj_objectWithKeyValues:responseObject[@"data"]];
//            DSLog(@"--%d--%d",m.num,m.nums);
            NSString *dayStr = [NSString stringWithFormat:@"%d",m.num];
            NSString *totalStr = [NSString stringWithFormat:@"%d",m.nums];
            NSString *day = [NSString stringWithFormat:@"本月连续签到%@天",dayStr];
            
                NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
                    make.font([UIFont systemFontOfSize:14.f]).textColor([UIColor darkTextColor]);
                    make.append(day);
                        make.rangeEdit(NSMakeRange(6, dayStr.length), ^(SJAttributesRangeOperator * _Nonnull make) {
                            make.font([UIFont systemFontOfSize:14.f]).textColor(KALLRGB);
                        });

                    
                });
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lab_total.text = totalStr;//一赋值就崩溃

                    self.lab.attributedText = attrStr;
                    [self.calendar reloadData];
                    [self.icaroursel reloadData];
                    
                });
           
            
            
        }
        
    } onFailure:^(NSError * _Nullable error) {
        if (methodtype==kXMHTTPMethodPOST) {
            [SVProgressHUD showInfoWithStatus:@"签到失败！"];}else{
                
            }
    }];
    
}
- (void)setOnClick
{
    UISwitch *switc = [[UISwitch alloc]initWithFrame:CGRectMake(15, 10+SafeAreaTopHeight, 50, 30 )];
    [self.view addSubview:switc];
    //缩小或者放大switch的size
    switc.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [switc setOn:YES animated:YES];
    
    switc.tintColor = RGB(204, 204, 204);
    switc.onTintColor = KALLRGB;
//    [switc addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25+switc.frame.size.width+6, 13+SafeAreaTopHeight, 100, 25)];
    label.text = @"签到通知开关";
    label.textColor = RGB(153, 153, 153);
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
}

#pragma mark - ButtonClick签到规则
- (void)buttonClick:(UIButton *)but{
    TJSignRuleController *ruleVc = [[TJSignRuleController alloc]init];
    ruleVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self presentViewController:ruleVc animated:NO completion:nil];
}

- (void)setCalendarCollectionView{
    NSDate *date =[NSDate date];//简书 FlyElephant
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    self.dateFormatter = formatter;
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"M"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];

    NSString *currentStr = [NSString stringWithFormat:@"%ld.%ld",currentYear,currentMonth];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 30+18+SafeAreaTopHeight, 100, 50)];
    titleLab.text = currentStr;
    titleLab.textColor = RGB(51, 51, 51);
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titleLab];
    
    UILabel *title_right = [[UILabel alloc]initWithFrame:CGRectMake(S_W-145, 30+18+SafeAreaTopHeight, 130, 50)];
    title_right.textColor = RGB(51, 51, 51);
    title_right.textAlignment = NSTextAlignmentRight;
    title_right.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:title_right];
    self.lab = title_right;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(25, 30+18+50+SafeAreaTopHeight, S_W-50, 300)];
    [self.view addSubview:bgView];
    
    FSCalendar *calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 0, S_W-50, 260)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.headerHeight = 0.f;
    calendar.scrollEnabled = NO;
    calendar.allowsSelection = NO;//
    [calendar registerClass:[TJSignCalendarCell class] forCellReuseIdentifier:@"cell"];

    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    
    calendar.appearance.weekdayTextColor=RGB(51, 51, 51);
    calendar.appearance.headerTitleColor=RGB(153, 153, 153);
    calendar.allowsMultipleSelection = NO;
    [[calendar valueForKeyPath:@"topBorder"] setValue:@YES forKey:@"hidden"];
    [[calendar valueForKeyPath:@"bottomBorder"] setValue:@YES forKey:@"hidden"];
    [bgView addSubview:calendar];
    self.calendar = calendar;
    
    
}
- (void)setSignBtn{
    UIButton *signBtn = [[UIButton alloc]init];
    signBtn.frame =CGRectMake(0, 30+18+50+SafeAreaTopHeight+300, 220, 40);
    signBtn.center = CGPointMake(self.view.center.x, 30+18+50+SafeAreaTopHeight+300);
    [signBtn setBackgroundColor:KALLRGB];
    signBtn.layer.cornerRadius = 20;
    signBtn.layer.masksToBounds = YES;
    [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    signBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [signBtn setTitle:@"签到" forState:UIControlStateNormal];
    [self.view addSubview:signBtn];
    self.signBtn = signBtn;
    UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(signBtn.frame.origin.x+10, signBtn.frame.origin.y+40+6, 100, 25)];
    allLab.text = @"今日签到总人数：";
    allLab.textAlignment = NSTextAlignmentRight;
    allLab.textColor = RGB(153, 153, 153);
    allLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:allLab];
    
    UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(allLab.frame.origin.x+100, signBtn.frame.origin.y+40+6, 70, 25)];
    numLab.text = @"74,546,545";
    numLab.textAlignment = NSTextAlignmentLeft;
    numLab.textColor = KALLRGB;
    numLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:numLab];
    self.lab_total = numLab;
}
- (void)setSelectedTopicScroll{
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25, S_H-150, 100, 30)];
    titleLab.text = @"精选专题";
    titleLab.textColor = RGB(51, 51, 51);
    titleLab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLab];
//    页码
    
    UILabel *numLab = [[UILabel alloc]init];
    numLab.frame = CGRectMake(S_W-25-20, S_H-150, 30, 30);
//    numLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:numLab];
    self.lab_page = numLab;
    NSString *str = @"1 /3";
    NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.font([UIFont systemFontOfSize:18.f]).textColor([UIColor darkTextColor]);
        make.append(str);
        make.rangeEdit(NSMakeRange(str.length - 1, 1), ^(SJAttributesRangeOperator * _Nonnull make) {
            make.font([UIFont systemFontOfSize:13.f]).textColor([UIColor orangeColor]);
        });
    });
    numLab.attributedText = attrStr;
    iCarousel *icarou = [[iCarousel alloc]initWithFrame:CGRectMake(0, S_H-120, S_W, 120)];
    icarou.type = iCarouselTypeLinear;
    icarou.pagingEnabled = YES;
    icarou.delegate = self;
    icarou.dataSource = self;
    [self.view addSubview:icarou];
    self.icaroursel = icarou;
}
#pragma mark - icarouseldelegte
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.bannerArr.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view==nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W-50, 100)];
//        view.backgroundColor = RandomColor;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W-50, 100)];
        [img sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.bannerArr[index]]]];
        [view addSubview:img];
        
    }
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    return value*1.04;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
//    切换index
    NSString*  str = [NSString stringWithFormat:@"%ld /3",(long)carousel.currentItemIndex+1];
    NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.font([UIFont systemFontOfSize:18.f]).textColor([UIColor darkTextColor]);
        make.append(str);
        make.rangeEdit(NSMakeRange(str.length - 1, 1), ^(SJAttributesRangeOperator * _Nonnull make) {
            make.font([UIFont systemFontOfSize:13.f]).textColor([UIColor orangeColor]);
        });
    });
    self.lab_page.attributedText = attrStr;
}
#pragma mark - signBtnClick
- (void)signBtnClick:(UIButton *)sender
{
    NSLog(@"签到了");
    [self RequestSignInfoWithType:kXMHTTPMethodPOST];
    
}

#pragma mark - FSCalendardeleagte
- (__kindof FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position{
    
    TJSignCalendarCell *cell  = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:position];
    return cell;
}
- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

// 对有事件的显示一个点,默认是显示三个点
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if ([self.dataArr containsObject:[self.dateFormatter2 stringFromDate:date]]) {
        return 1;}else{
            return 0;
        }
}

- (nullable NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date{
    if ([self.dataArr containsObject:[self.dateFormatter2 stringFromDate:date]]) {
        return @[KALLRGB];
    }
    return nil;
}
- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    TJSignCalendarCell *diyCell = (TJSignCalendarCell *)cell;
    
    // Custom today circle
    diyCell.circleImageView.hidden = ![self.gregorian isDateInToday:date];
    
    diyCell.shapeLayer.fillColor = [UIColor clearColor].CGColor;
}


@end
