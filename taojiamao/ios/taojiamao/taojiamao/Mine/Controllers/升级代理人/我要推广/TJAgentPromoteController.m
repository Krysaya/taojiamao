//
//  TJAgentPromoteController.m
//  taojiamao
//
//  Created by yueyu on 2018/9/27.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJAgentPromoteController.h"

@interface TJAgentPromoteController ()<iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageC;

@end

@implementation TJAgentPromoteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要推广";
    self.carousel.type  = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
    self.pageC.currentPage = 0;

}
- (void)loadAgentPic{
    [KConnectWorking requestNormalDataParam:@{} withRequestURL:MyAgentLevel withMethodType:kXMHTTPMethodPOST withSuccessBlock:^(id  _Nullable responseObject) {
        
    } withFailure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - icarouseldelegte
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 5;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view==nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W-50, 100)];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
//        TJKallAdImgModel *model = self.bannerArr[index];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W-50, 100)];
//        [img sd_setImageWithURL: [NSURL URLWithString:model.imgurl]];
        img.backgroundColor = RandomColor;
        [view addSubview:img];
        
    }
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    return value*1.04;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    //    切换index
    self.pageC.currentPage = carousel.currentItemIndex;
//    NSString*  str = [NSString stringWithFormat:@"%ld/%ld",(long)carousel.currentItemIndex+1,self.bannerArr.count];
//    NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
//        make.font([UIFont systemFontOfSize:18.f]).textColor([UIColor darkTextColor]);
//        make.append(str);
//        make.rangeEdit(NSMakeRange(0, 1), ^(SJAttributesRangeOperator * _Nonnull make) {
//            make.font([UIFont systemFontOfSize:17.f]).textColor([UIColor orangeColor]);
//        });
//    });
//    self.lab_page.attributedText = attrStr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
