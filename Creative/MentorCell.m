//
//  MentorCell.m
//  Creative
//
//  Created by huahongbo on 16/3/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MentorCell.h"

@implementation MentorCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAddSubviews];
    }
    return self;
}

- (void)createAddSubviews
{
    UIImageView *iconImage = [[UIImageView alloc]init];
    [self addSubview:iconImage];
    self.iconImage = iconImage;
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text = @"姓名:";
    self.nameLab = nameLab;
    
    UILabel *nameText = [[UILabel alloc]init];
    nameText.textColor = [UIColor lightGrayColor];
    [self addSubview:nameText];
    [self addSubview:nameLab];
    self.nameText = nameText;

    UILabel *serLab = [[UILabel alloc]init];
    serLab.text = @"服务领域:";
    self.serLab = serLab;
    
    UILabel *serText = [[UILabel alloc]init];
    serText.textColor = [UIColor lightGrayColor];
    [self addSubview:serLab];
    [self addSubview:serText];
    self.serText = serText;
}

- (void)layoutSubviews
{
    self.iconImage.frame = CGRectMake(15, 15, self.mj_h-30, self.mj_h-30);
    self.iconImage.layer.cornerRadius = (self.mj_h-30)/2;
    self.iconImage.clipsToBounds = YES;
    
    self.nameLab.frame =CGRectMake([self.iconImage right]+30, self.iconImage.mj_y, 50, 25);
    self.nameText.frame = CGRectMake([self.nameLab right], self.nameLab.mj_y, 100, 25);
    
    self.serLab.frame =CGRectMake([self.iconImage right]+30,[self.nameLab bottom]+5, 100, 25);
    self.serText.frame = CGRectMake([self.serLab right], self.serLab.mj_y, 100, 25);
}

+ (MentorCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *PJcell = @"teacherCellID";
    MentorCell *cell = [tableView dequeueReusableCellWithIdentifier:PJcell];
    if (cell == nil) {
        cell = [[MentorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PJcell];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
