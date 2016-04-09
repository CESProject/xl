//
//  PlaceTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

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
    self.titleView.frame = CGRectMake(0, 5, self.mj_w, 80);
    self.iconImage.frame = CGRectMake(3, 5, 70, 70);
    self.titleLab.frame = CGRectMake(self.iconImage.mj_w +10, 5, self.contentView.mj_w - 83, 30);
    self.addressIm.frame = CGRectMake(self.iconImage.mj_w +10, self.titleLab.mj_y +self.titleLab.mj_h + 23, 15, 15);
    self.addressLab.frame = CGRectMake(self.addressIm.mj_w +self.addressIm.mj_x,self.titleLab.mj_y +self.titleLab.mj_h+ 20, self.contentView.mj_w - self.addressIm.mj_w - self.addressIm.mj_x - 26, 20);
    
    self.arrowView.frame = CGRectMake(self.addressLab.mj_w +self.addressLab.mj_x, self.titleLab.mj_y +self.titleLab.mj_h , 10, 20);
    
}

- (void)createSubviews
{
    
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *titleView = [[UIView alloc]init];
    self.titleView = titleView;
    
    self.backgroundColor = [UIColor whiteColor];
    // 头像
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 4;
    icon.clipsToBounds = YES;
    self.iconImage = icon;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:17.0];
    titleLab.layer.masksToBounds = YES;
    titleLab.layer.cornerRadius = 4;
    self.titleLab = titleLab;
    
    UIImageView *addressIm = [[UIImageView alloc]init];
    addressIm.image = [UIImage imageNamed:@"needle"];
    self.addressIm = addressIm;
    
    UILabel *addressLab = [[UILabel alloc] init];
    addressLab.font = [UIFont systemFontOfSize:14.0];
    addressLab.textColor = [UIColor grayColor];
    addressLab.layer.masksToBounds = YES;
    addressLab.layer.cornerRadius = 4;
    self.addressLab = addressLab;
    
    UIImageView *arrowView = [[UIImageView alloc]init];
    arrowView.image = [UIImage imageNamed:@"arrow"];
    self.arrowView = arrowView;
    
    
    [titleView addSubview:icon];
    [titleView addSubview:titleLab];
    [titleView addSubview:addressIm];
    [titleView addSubview:addressLab];
    [titleView addSubview:arrowView];
    
    [self.contentView addSubview:titleView];
    //    [self.contentView addSubview:icon];
    //    [self.contentView addSubview:titleLab];
    //    [self.contentView addSubview:addressIm];
    //    [self.contentView addSubview:addressLab];
    //    [self.contentView addSubview:arrowView];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    
    
    
}

+ (PlaceTableViewCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *cellId = @"placeCellID";
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
