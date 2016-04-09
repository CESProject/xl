//
//  ProjectTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ProjectTableViewCell.h"
#import "UIView+MJExtension.h"
#import "UIImageView+WebCache.h"

@implementation ProjectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, 0, self.mj_w, 90);
    self.line.frame = CGRectMake(0, self.backView.mj_h + self.backView.mj_y, self.mj_w, 0.5);
    self.iconImage.frame = CGRectMake(10, 5, 80 / 3 *5, 80);
    self.titleLab.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x  +10, 10, self.contentView.mj_w - 120, 30);

    self.classLab.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x +10,self.titleLab.mj_y +self.titleLab.mj_h + 12, self.mj_w - 250, 25);
    
  
    self.domainLab.frame = CGRectMake(DEF_SCREEN_WIDTH-137,self.classLab.mj_y ,120 , 25);
}

- (void)createSubviews
{
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    self.backView = backView;
    
    // 头像
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 4;
    icon.clipsToBounds = YES;
    self.iconImage = icon;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:17.0];
    titleLab.font = [UIFont boldSystemFontOfSize:18.0];
    titleLab.textColor = [UIColor grayColor];
    titleLab.layer.masksToBounds = YES;
    titleLab.layer.cornerRadius = 4;
    self.titleLab = titleLab;
    
    
    UILabel *classLab = [[UILabel alloc] init];
    classLab.font = [UIFont systemFontOfSize:14.0];
    classLab.textColor = [UIColor grayColor];
    classLab.layer.masksToBounds = YES;
    classLab.layer.cornerRadius = 4;
    self.classLab = classLab;
    
    
    UILabel *domainLab = [[UILabel alloc] init];
    domainLab.font = [UIFont systemFontOfSize:13.0];
    domainLab.font = [UIFont boldSystemFontOfSize:14.0];
    domainLab.textAlignment = NSTextAlignmentRight;
    domainLab.textColor = [UIColor grayColor];
    domainLab.layer.masksToBounds = YES;
    domainLab.layer.cornerRadius = 4;
    self.domainLab = domainLab;
    
    [backView addSubview:icon];
    [backView addSubview:titleLab];
    [backView addSubview:classLab];
    [backView addSubview:domainLab];
    
    [self.contentView addSubview:backView];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    line.alpha = 0.5;
    self.line = line;
    [self.contentView addSubview:line];
    
    
}

+ (ProjectTableViewCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *PJcell = @"PJcelliD";
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PJcell];
    if (cell == nil) {
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PJcell];
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
