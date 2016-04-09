//
//  LabelAndTextField.m
//  Creative
//
//  Created by MacBook on 16/3/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "LabelAndTextField.h"

#define RGBcolor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];


@implementation LabelAndTextField


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 2 - 20)];
        _label.text = @"当前价格";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = RGBcolor(192, 192, 192);
      
        self.priceTextField = [[UITextField alloc]init];
        [self addSubview:self.label];
        [self addSubview:self.priceTextField];
        
    }
    return self;

}

- (void)setPriceTextField:(UITextField *)priceTextField{
    if (_priceTextField != priceTextField) {
        
        _priceTextField = priceTextField;
        _priceTextField.font = [UIFont boldSystemFontOfSize:18];
        _priceTextField.frame = (CGRect){{0,self.label.frame.size.height + 4},{self.frame.size.width,self.label.frame.size.height / 2 + 20}};
        _priceTextField.textAlignment = NSTextAlignmentCenter;
        self.priceTextField.textColor = RGBcolor(237, 145, 33);

    }
}


@end
