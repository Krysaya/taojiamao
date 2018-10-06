
//
//  TJHeadLineCustomCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineCustomCell.h"
#import "TJHeadLineScrollModel.h"
@interface TJHeadLineCustomCell()
@property (weak, nonatomic) IBOutlet UILabel *lab_tag0;
//@property (weak, nonatomic) IBOutlet UILabel *lab_tag2;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
//@property (weak, nonatomic) IBOutlet UILabel *lab2;

@end

@implementation TJHeadLineCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lab_tag0.layer.borderColor = KALLRGB.CGColor;
    _lab_tag0.layer.borderWidth = 0.5;
    _lab_tag0.layer.cornerRadius = 3;
    
//    _lab_tag2.layer.borderColor = KALLRGB.CGColor;
//    _lab_tag2.layer.borderWidth = 0.5;
//    _lab_tag2.layer.cornerRadius = 3;
    
}
- (void)noticeCellWithArr:(NSArray *)arr forIndex:(NSUInteger)index{

        TJHeadLineScrollModel *model  = arr[index];
        self.lab1.text = model.title;
        if ([model.rec_type intValue]==1) {
            self.lab_tag0.text = @"最新";
        }else{
            self.lab_tag0.text = @"最热";
            
        }

 
//    if (index*2+1<arr.count) {
//        TJHeadLineScrollModel *model  = arr[index*2+1];
//        self.lab2.text = model.title;
//        
//        if ([model.rec_type intValue]==1) {
//            self.lab_tag2.text = @"最新";
//        }else{
//            self.lab_tag2.text = @"最热";
//
//        }
//    }
    
}

@end
