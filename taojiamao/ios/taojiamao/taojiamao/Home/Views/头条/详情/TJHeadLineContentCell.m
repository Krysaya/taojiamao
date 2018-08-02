
//
//  TJHeadLineContentCell.m
//  taojiamao
//
//  Created by yueyu on 2018/8/1.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJHeadLineContentCell.h"
#import "TJArticlesInfoListModel.h"
@interface TJHeadLineContentCell() <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewH;


@end

@implementation TJHeadLineContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _web_content.scrollView.scrollEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TJArticlesInfoListModel *)model{
    _model = model;
    self.lab_title.text = model.title;
    self.lab_from.text = model.source;
    self.lab_pinglun.text = [NSString stringWithFormat:@"%@人评论",model.comment_num];
    self.lab_zan.text = [NSString stringWithFormat:@"%@赞",model.like_num];
    [self.web_content loadHTMLString:model.content baseURL:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (self.model.contentH) {
        _webViewH.constant = self.model.contentH;
    }else
    {
        CGFloat webViewHeight=[webView.scrollView contentSize].height;
        //    CGRect newFrame = webView.frame;
        //    newFrame.size.height = webViewHeight;
        //    webView.frame = newFrame;
        _webViewH.constant = webViewHeight;
        self.model.contentH = webViewHeight;
        [self.baseView reloadData];
    }
    
}
@end
