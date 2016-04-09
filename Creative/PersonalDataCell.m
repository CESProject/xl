//
//  PersonalDataCell.m
//  Creative
//
//  Created by huahongbo on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PersonalDataCell.h"

@implementation PersonalDataCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        _bacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bacBtn.userInteractionEnabled = NO;
        _bacBtn.frame = CGRectMake(15, 0,self.frame.size.width-30,self.frame.size.width-30);
        _bacBtn.layer.cornerRadius = (self.frame.size.width-30)/2;
        _bacBtn.clipsToBounds = YES;
        [self addSubview:_bacBtn];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = CGRectMake(5, [_bacBtn bottom], self.frame.size.width-10, self.frame.size.height*0.2);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor lightGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLab];
    }
    return self;
}

@end
