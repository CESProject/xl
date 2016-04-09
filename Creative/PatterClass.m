//
//  PatterClass.m
//  assistant
//
//  Created by Mr Wei on 15/9/17.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PatterClass.h"


@implementation PatterClass

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /// 图形验证
        [self addPatterVerification];
    }
    return self;
}



- (void)addPatterVerification
{
    self.backgroundColor = COMColor(222, 222, 222, 1.0);
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame), 60)];
    titleLabel.text = @"随机验证码";
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.textColor = GREENCOLOR;
    [self addSubview:titleLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.frame), 1)];
    lineView.backgroundColor = GREENCOLOR;
    [self  addSubview:lineView];
    
    self.codeView = [[PatternView alloc] initWithFrame:CGRectMake(10, 80, CGRectGetWidth(self.frame)/2-20, 40)];
    [self  addSubview:self.codeView];
    
//    self.input = [[UITextField alloc] initWithFrame:CGRectMake(self.codeView.frame.origin.x, CGRectGetMaxY(self.codeView.frame) + 10, CGRectGetWidth(self.frame)-20, 40)];
    self.input = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.codeView.frame) + 10,self.codeView.frame.origin.y,CGRectGetWidth(self.frame)/2-20, 40)];
    
    
    
    self.input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.input.layer.borderWidth = 1.0;
    self.input.layer.cornerRadius = 5.0;
    self.input.font            = [UIFont systemFontOfSize:15];
    self.input.placeholder     = @"请输入验证码";
    self.input.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.input.backgroundColor = [UIColor clearColor];
    self.input.textAlignment   = NSTextAlignmentCenter;
    self.input.returnKeyType   = UIReturnKeyDone;
    self.input.delegate        = self;
    [self addSubview:self.input];
    
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setFrame:CGRectMake(3*self.codeView.frame.origin.x, CGRectGetMaxY(self.input.frame) + 10, CGRectGetWidth(self.frame)/3-15, 40)];
    _cancelButton.layer.masksToBounds = YES;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderWidth = 1;
    _cancelButton.tintColor = GREENCOLOR;
    _cancelButton.layer.borderColor = GREENCOLOR.CGColor;
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
//    [_cancelButton.layer setBorderWidth:1.0];
    //设置按钮的边界颜色
    
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
//    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,1,0,1});
//    [_cancelButton.layer setBorderColor:color];
   
//    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:_cancelButton];
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [_sureButton setFrame:CGRectMake(self.input.frame.origin.x +3*self.codeView.frame.origin.x, CGRectGetMaxY(self.input.frame) + 10, CGRectGetWidth(self.frame)/3-15, 40)];
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius = 4;
    _sureButton.layer.borderWidth = 1;
    _sureButton.tintColor = GREENCOLOR;
    _sureButton.layer.borderColor = GREENCOLOR.CGColor;
    _sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.cancelButton.backgroundColor = [UIColor colorWithRed:128
//                                                        green:128
//                                                         blue:240
// alpha:1.0];
//    self.cancelButton.backgroundColor = [UIColor lightGrayColor];
//    self.sureButton.backgroundColor = [UIColor lightGrayColor];
    
//    [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:_sureButton];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
