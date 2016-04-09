//
//  PatternView.h
//  图形验证码CoreGraphics
//
//  Created by Mr Wei on 15/9/17.
//  Copyright (c) 2015年 Mr Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatternView : UIView

@property (nonatomic, strong) NSArray *changeArray;
@property (nonatomic, strong) NSMutableString *changeString;
@property (nonatomic, strong) NSMutableString *getStr;
@property (nonatomic, strong) UILabel *codeLabel;

@end
