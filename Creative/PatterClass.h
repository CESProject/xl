//
//  PatterClass.h
//  assistant
//
//  Created by Mr Wei on 15/9/17.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatternView.h" /// 图形验证



@interface PatterClass : UIView<UITextFieldDelegate>

/// 图形验证属性
@property (nonatomic, strong) UITextField *input;
@property (nonatomic, strong) PatternView *codeView;
@property (nonatomic , strong) UIButton *cancelButton;
@property (nonatomic , strong) UIButton *sureButton;


@end
