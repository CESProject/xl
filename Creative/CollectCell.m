//
//  CollectCell.m
//  assistant
//
//  Created by Apple on 15/7/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CollectCell.h"
#import "UIImageView+WebCache.h"
#import "common.h"
@interface CollectCell ()
@property(nonatomic,strong)UIImageView *imv;
@end
@implementation CollectCell
- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
    
        UIImageView *im = [[UIImageView alloc] init];
        im.layer.cornerRadius = 4;
        im.clipsToBounds = YES;
        [self addSubview:im];
        self.imv = im;
        
    }
    return self;

}
- (void)layoutSubviews
{

    [super layoutSubviews];
    self.imv.frame  = self.bounds;
}
- (void)setIconURL:(NSString *)iconURL
{

    _iconURL = iconURL;

    [self.imv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_iconURL]] placeholderImage:[UIImage imageNamed:@"picf"]];
    
}
@end
