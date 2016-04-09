//
//  ResultsTableViewCell.m
//  Creative
//
//  Created by huahongbo on 16/1/4.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResultsTableViewCell.h"
#import "UIView+MJExtension.h"
#import "UIImage+WF.h"
@implementation ResultsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)layoutSubviews
{
    self.smalImage.frame = CGRectMake(10, 18, 20, 20);
    self.bubblesImage.frame = CGRectMake([self.smalImage right], 0, DEF_SCREEN_WIDTH-self.smalImage.mj_w-30, self.mj_h);
    self.bubblesImage.image = [UIImage stretchedImageWithName:@"a1"];
    
    self.iconImage.frame = CGRectMake(30, 15, 30, 30);
//    self.nameLab.frame = CGRectMake([self.iconImage right]+5, self.iconImage.mj_y, 100, self.iconImage.mj_h/2);
    self.timeImage.frame = CGRectMake([self.iconImage right]+5, self.iconImage.mj_y+10, self.iconImage.mj_h/2, self.iconImage.mj_h/2);
    self.dateLab.frame = CGRectMake([self.timeImage right]+5, self.timeImage.mj_y, DEF_SCREEN_WIDTH-100, self.timeImage.mj_h);
//    self.detaiImage.frame = CGRectMake(self.iconImage.mj_x, [self.iconImage bottom]+20, self.iconImage.mj_w*2+10, self.iconImage.mj_w*2+10);
    self.detailLab.frame = CGRectMake(self.iconImage.mj_x+20, [self.iconImage bottom]+10, self.bubblesImage.mj_w-self.iconImage.mj_x*2-20,self.iconImage.mj_w*2+10);
    
}
- (void)createSubviews
{
    self.backgroundColor =[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIColor *color1 =  COMColor(30, 40, 50, 1.0);
    
    UIImageView *smal = [[UIImageView alloc] init];
    smal.image = [UIImage imageNamed:@"z"];
    self.smalImage = smal;
    UIImageView *bubbles = [[UIImageView alloc] init];
//    bubbles.backgroundColor = [UIColor whiteColor];
    self.bubblesImage = bubbles;
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 4;
    icon.clipsToBounds = YES;
    icon.backgroundColor = color1;
    self.iconImage = icon;
    
//    UILabel *nameLab = [[UILabel alloc] init];
//    nameLab.font = [UIFont systemFontOfSize:14.0];
//    nameLab.text = @"hahaha";
//    self.nameLab = nameLab;
    
    UIImageView *timeImg = [[UIImageView alloc] init];
    timeImg.image = [UIImage imageNamed:@"clock"];
    self.timeImage = timeImg;
    
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.font = [UIFont systemFontOfSize:10.0];
    self.dateLab = dateLab;
    
//    UIImageView *detailImg = [[UIImageView alloc] init];
//    detailImg.backgroundColor = color1;
//    self.detaiImage = detailImg;
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.font = [UIFont systemFontOfSize:10.0];
    detailLab.textColor = [UIColor grayColor];
    detailLab.numberOfLines = 0;
    self.detailLab = detailLab;
    
    [self.contentView addSubview:smal];
    [self.contentView addSubview:bubbles];
    [bubbles addSubview:icon];
//    [bubbles addSubview:nameLab];
    [bubbles addSubview:timeImg];
    [bubbles addSubview:dateLab];
//    [bubbles addSubview:detailImg];
    [bubbles addSubview:detailLab];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
