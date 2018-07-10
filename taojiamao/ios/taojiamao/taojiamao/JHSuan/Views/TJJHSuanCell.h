//
//  TJJHSuanCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/6.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJJHSuanCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *tb_img;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *yimai_lab;
@property (weak, nonatomic) IBOutlet UILabel *quanhou_lab;
@property (weak, nonatomic) IBOutlet UIButton *btn_quan;

@end
