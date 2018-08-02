//
//  TJHeadLineContentCell.h
//  taojiamao
//
//  Created by yueyu on 2018/8/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJArticlesInfoListModel;
@interface TJHeadLineContentCell : UITableViewCell
@property (nonatomic, strong) TJArticlesInfoListModel *model;

@property (weak, nonatomic) IBOutlet UIWebView *web_content;
@property (nonatomic,   weak) UITableView *baseView;

@end
