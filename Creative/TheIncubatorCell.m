//
//  TheIncubatorCell.m
//  Creative
//
//  Created by huahongbo on 16/3/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "TheIncubatorCell.h"
#import "Incubat.h"
@implementation TheIncubatorCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        img = [[UIImageView alloc] init];
        img.frame = CGRectMake(5, 5,self.frame.size.width-10, self.frame.size.height*0.7);
        [self addSubview:img];
        
        nameLab = [[UILabel alloc] init];
//        nameLab.frame = CGRectMake(5, [img bottom], self.frame.size.width-10, self.frame.size.height*0.2);
        nameLab.center = CGPointMake(img.mj_w/2, img.bottom+(self.mj_h-img.mj_h-5)/2);
        nameLab.bounds = CGRectMake(0, 0, img.mj_w, self.mj_h*0.3);
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.font = [UIFont systemFontOfSize:12];
        nameLab.numberOfLines = 0;
        [self addSubview:nameLab];
    }
    return self;
}
- (void)setCellWithArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath
{
    Incubat *incub =array[indexPath.item];
    [img sd_setImageWithURL:[NSURL URLWithString:incub.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    nameLab.text = incub.companyName;
}

@end
