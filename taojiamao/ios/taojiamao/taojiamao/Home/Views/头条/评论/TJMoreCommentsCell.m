//
//  TJMoreCommentsCell.m
//  taojiamao
//
//  Created by yueyu on 2018/7/19.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJMoreCommentsCell.h"
#import "TJCommentsListModel.h"
@interface TJMoreCommentsCell()


@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *lab_nick;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_comments;
//@property (weak, nonatomic) IBOutlet UIButton *btn_nums;
@property (weak, nonatomic) IBOutlet UIView *view_bg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraint;

@end

@implementation TJMoreCommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJCommentsListModel *)model{
    _model = model;
    [self.headimg sd_setImageWithURL: [NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    self.lab_nick.text = model.username;
    self.lab_comments.text = model.content;
    if ([model.num intValue]==0) {
        self.view_bg.hidden = YES;
    }else{
        self.view_bg.hidden = NO;
    }
    [self.btn_more setTitle:[NSString stringWithFormat:@"共计%@条评论",model.num] forState:UIControlStateNormal];
    
    double time = [model.addtime doubleValue];
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeS = [formatter stringFromDate:myDate];
    self.lab_time.text = timeS;

    if ([TJOverallJudge judgeBlankString:model.re_content]) {
//        DSLog(@"--空");
        self.view_bg.hidden = YES;
        self.bottomContraint.constant = 10;
    }else{
        self.view_bg.hidden = NO;
        self.bottomContraint.constant = 60;

    }

}

@end
