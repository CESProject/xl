//
//  IncubatCell.m
//  Creative
//
//  Created by huahongbo on 16/3/8.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "IncubatCell.h"

@implementation IncubatCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleImg = [[UIImageView alloc] init];
        self.titleImg.frame = CGRectMake(30, self.frame.size.height/2, self.frame.size.height-10, self.frame.size.height-10);
        [self addSubview:self.titleImg];
        
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.frame = CGRectMake([self.titleImg right]+20, self.titleImg.frame.origin.y+10, self.frame.size.width-150, self.frame.size.height/2);
        self.titleLable.textColor = DEF_RGB_COLOR(200, 200, 200);
        self.titleLable.font = [UIFont systemFontOfSize:20];
        self.titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [self addSubview:self.titleLable];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
