//
//  TJGoodsListCell.h
//  taojiamao
//
//  Created by yueyu on 2018/7/12.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJGoodsListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


- (void)cellWithArr:(NSArray *)arr forIndexPath:(NSIndexPath *)indexPath isEditing:(BOOL)editing;

@end
