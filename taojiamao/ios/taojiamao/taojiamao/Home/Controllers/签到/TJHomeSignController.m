
//
//  TJHomeSignController.m
//  taojiamao
//
//  Created by yueyu on 2018/7/9.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHomeSignController.h"
#import "TJSignRuleController.h"
#import "FSCalendar.h"


#define RIGHTBT  568

@interface TJHomeSignController ()<TJButtonDelegate,UIScrollViewDelegate,FSCalendarDelegate,FSCalendarDataSource>

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property(strong,nonatomic)NSMutableArray*dataArr;

//@property (nonatomic, strong) UICollectionView *collectionV;
@end

@implementation TJHomeSignController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    //    you边按钮

    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"签到规则" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    //创建一个数组记录已经签过到的天
    _dataArr=[[NSMutableArray alloc]initWithObjects:@"2017-07-01",@"2017-07-02",@"2017-07-05",@"2017-07-07",nil];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    [self setCalendarCollectionView];
    
    [self setOnClick];
}

- (void)setOnClick
{
    UISwitch *switc = [[UISwitch alloc]initWithFrame:CGRectMake(15, 10+SafeAreaTopHeight, 50, 30 )];
    [self.view addSubview:switc];
    NSLog(@"---switch--frame===%@===%@",NSStringFromCGRect(switc.frame),NSStringFromCGSize(switc.frame.size));
    //缩小或者放大switch的size
    switc.transform = CGAffineTransformMakeScale(0.6, 0.6);
//    switc.layer.anchorPoint = CGPointMake(0, 0.3);
    NSLog(@"---switch--frame222===%@==%@",NSStringFromCGRect(switc.frame),NSStringFromCGSize(switc.frame.size));

    [switc setOn:YES animated:YES];
    
    switc.tintColor = RGB(204, 204, 204);
    switc.onTintColor = KALLRGB;
//    [switc addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25+switc.frame.size.width+6, 13+SafeAreaTopHeight, 100, 25)];
    label.text = @"签到通知开关";
    label.textColor = RGB(153, 153, 153);
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
}

#pragma mark - ButtonClick
- (void)buttonClick:(UIButton *)but{
    TJSignRuleController *ruleVc = [[TJSignRuleController alloc]init];
    ruleVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];

    [self presentViewController:ruleVc animated:NO completion:nil];
}

- (void)setCalendarCollectionView{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(25, 25+30+18+SafeAreaTopHeight, S_W-50, 300)];
    [self.view addSubview:bgView];
    
    FSCalendar *calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 0, S_W-50, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.headerHeight = 0.f;
    calendar.scrollEnabled = NO;

    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    
    calendar.appearance.weekdayTextColor=RGB(51, 51, 51);
    calendar.appearance.headerTitleColor=RGB(153, 153, 153);
    calendar.allowsMultipleSelection = NO;
    [[calendar valueForKeyPath:@"topBorder"] setValue:@YES forKey:@"hidden"];
    [[calendar valueForKeyPath:@"bottomBorder"] setValue:@YES forKey:@"hidden"];
    [bgView addSubview:calendar];
    
    
    
}
- (void)setSelectedTopicScroll{
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25, S_H-150, 100, 50)];
    titleLab.text = @"精选专题";
    titleLab.textColor = RGB(51, 51, 51);
    titleLab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLab];
//    页码
//    UILabel *numLab = [UILabel alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(25, S_H-120, S_W-25, 100)];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    
    scrollV.delegate = self;
    [self.view addSubview:scrollV];
}


#pragma mark - FSCalendardeleagte

-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date{

        return [UIColor blueColor];
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(nonnull FSCalendarAppearance *)appearance subtitleSelectionColorForDate:(nonnull NSDate *)date{
    return [UIColor redColor];
}
// 对有事件的显示一个点,默认是显示三个点
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return 1;}else{
            return 0;
        }
}
//颜色
- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    return @[KALLRGB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
