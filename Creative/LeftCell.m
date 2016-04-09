//
//  LeftCell.m
//  Creative
//
//  Created by huahongbo on 15/12/30.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "LeftCell.h"

@implementation LeftCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _img = [[UIImageView alloc] init];
        _img.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/3+10);
        _img.bounds = CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height/4);
        [self addSubview:_img];
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.center = CGPointMake(self.frame.size.width/2, [_img bottom]+_img.frame.size.height/2);
        self.nameLab.bounds = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/4);
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        self.nameLab.textColor = [UIColor whiteColor];
        self.nameLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.nameLab];
    }
    return self;
}


@end
