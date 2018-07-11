//
//  TJTextFieldView.m
//  taojiamao
//
//  Created by yueyu on 2018/5/3.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import "TJTextFieldView.h"

@interface TJTextFieldView()<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UITextField * textfield;
@property(nonatomic,strong)UIView * line;

//@property(nonatomic,copy)textFieldText block;

@property(nonatomic,copy)NSString * normalImage;
@property(nonatomic,copy)NSString * highlightImage;

@end

@implementation TJTextFieldView
-(instancetype)initWithPlaceholder:(NSString*)plac image:(NSString*)image highlightImage:(NSString*)himage{
    self = [super init];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        self.normalImage = image;
        self.highlightImage = himage;
        [self setSubviewsWith:plac with:image];
//        self.block = block;
    }
    return self;
}
-(void)setSubviewsWith:(NSString*)plac with:(NSString*)image{
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
    [self addSubview:self.icon];
    WeakSelf
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(5);
        make.width.height.mas_equalTo(18*W_Scale);
    }];
    
    self.textfield = [[UITextField alloc]init];
    self.textfield.delegate =self;
    self.textfield.font = [UIFont systemFontOfSize:13*W_Scale];
    self.textfield.placeholder = plac;
    [self addSubview:self.textfield];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.icon);
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(12);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(21*W_Scale);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = RGB(204, 204, 204);
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark -UITextFieldDelegate
// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.line.backgroundColor = [UIColor redColor];
    [self.icon setImage:[UIImage imageNamed:self.highlightImage]];
    return YES;
}
// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.line.backgroundColor = [UIColor grayColor];
    [self.icon setImage:[UIImage imageNamed:self.normalImage]];
    return YES;
}
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (self.block) {
//        self.block(textField.text);
//    }
    
    self.text = textField.text;
    
}
// // if implemented, called in place of textFieldDidEndEditing:
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0){
//
//}
// // return NO to not change text
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    DSLog(@"%@",string);
//    return YES;
//}
//// called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    return YES;
//}
//// called when 'return' key pressed. return NO to ignore.
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    return YES;
//}








@end
