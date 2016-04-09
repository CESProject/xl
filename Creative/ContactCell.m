//
//  ContactCell.m
//  Creative
//
//  Created by huahongbo on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

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
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor whiteColor];
    self.titleView = titleView;
    
    UILabel *titleLab = [[UILabel alloc] init];
    [titleView addSubview:titleLab];
    self.titleLab = titleLab;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [titleView addSubview:line];
    self.line = line;
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.textColor = [UIColor orangeColor];
    [titleView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.textColor = [UIColor lightGrayColor];
    [titleView addSubview:phoneLab];
    self.phoneLab = phoneLab;
    
    UIImageView *faxImg = [[UIImageView alloc] init];
    faxImg.image = [UIImage imageNamed:@"email"];
    [titleView addSubview:faxImg];
    self.faxImg = faxImg;
    
    UILabel *faxLab = [[UILabel alloc] init];
    faxLab.textColor = [UIColor lightGrayColor];
    [titleView addSubview:faxLab];
    self.faxLab = faxLab;
    
    UIImageView *QQImg = [[UIImageView alloc] init];
    QQImg.image = [UIImage imageNamed:@"qq"];
    [titleView addSubview:QQImg];
    self.QQImg = QQImg;
    
    UILabel *QQLab = [[UILabel alloc] init];
    QQLab.textColor = [UIColor lightGrayColor];
    [titleView addSubview:QQLab];
    self.QQLab = QQLab;
    [self.contentView addSubview:titleView];
}
- (void)layoutSubviews
{
    self.titleView.frame = CGRectMake(0, 5, self.mj_w, 90);
    
    self.titleLab.frame = CGRectMake(10, 5, 100, 30);
    self.line.frame = CGRectMake(10, [self.titleLab bottom]+2, DEF_SCREEN_WIDTH-20, 1);
    self.nameLab.frame = CGRectMake(10, [self.line bottom]+5, 100, 25);
    self.phoneLab.frame = CGRectMake([self.nameLab right], self.nameLab.mj_y, 200, self.nameLab.mj_h);
    self.faxImg.frame = CGRectMake(self.nameLab.mj_x, [self.nameLab bottom], 25, 20);
    self.faxLab.frame = CGRectMake([self.faxImg right], self.faxImg.mj_y, DEF_SCREEN_WIDTH/2-30, 20);
    self.QQImg.frame = CGRectMake([self.faxLab right], self.faxImg.mj_y, 25, 20);
    self.QQLab.frame = CGRectMake([self.QQImg right], self.QQImg.mj_y, self.faxLab.mj_w, self.faxLab.mj_h);
}

+ (ContactCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *PJcell = @"teacherCellID";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:PJcell];
    if (cell == nil) {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PJcell];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
