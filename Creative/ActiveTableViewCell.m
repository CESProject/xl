//
//  ActiveTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ActiveTableViewCell.h"
#import "UIView+MJExtension.h"
#import "UIImageView+WebCache.h"

@implementation ActiveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
    self.backView.frame = CGRectMake(0, 0.5, self.mj_w, 120);
    self.iconImage.frame = CGRectMake(5, 5, 110 / 4*3, 110);
    self.titleLab.frame = CGRectMake(self.iconImage.mj_w +10, self.iconImage.mj_y , self.contentView.mj_w - 83, 20);
    self.clockIm.frame = CGRectMake(self.iconImage.mj_w +10, self.titleLab.mj_y +self.titleLab.mj_h + 5, 15, 15);
    self.dateLab.frame = CGRectMake(self.clockIm.mj_w +self.clockIm.mj_x,self.titleLab.mj_y +self.titleLab.mj_h+ 5, self.contentView.mj_w - self.clockIm.mj_w - self.clockIm.mj_x - 3, 20);
    
    self.addressIm.frame = CGRectMake(self.iconImage.mj_w +10, self.dateLab.mj_y +self.dateLab.mj_h + 5, 15, 15);
    self.addressLab.frame = CGRectMake(self.addressIm.mj_w +self.addressIm.mj_x,self.dateLab.mj_y +self.dateLab.mj_h+ 5, self.contentView.mj_w - self.addressIm.mj_w - self.addressIm.mj_x - 3, 20);
    
    self.unitLab.frame = CGRectMake(self.iconImage.mj_w +10, self.addressLab.mj_y + self.addressLab.mj_h+ 5, self.contentView.mj_w - 83, 20);
    

}

- (void)createSubviews
{
//    self.backgroundColor = [UIColor whiteColor];
     self.contentView.backgroundColor = GRAYCOLOR;
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    self.backView = backView;
    // 头像
    UIImageView *icon = [[UIImageView alloc] init];
//    icon.layer.cornerRadius = 4;
//    icon.backgroundColor = [UIColor grayColor];
    icon.clipsToBounds = YES;
    self.iconImage = icon;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:14.0];
    titleLab.textColor = [UIColor grayColor];
    titleLab.layer.masksToBounds = YES;
    titleLab.layer.cornerRadius = 4;
    self.titleLab = titleLab;
    
    
    UIImageView *clockIm = [[UIImageView alloc]init];
    clockIm.image = [UIImage imageNamed:@"clock"];
    self.clockIm = clockIm;
    
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.font = [UIFont systemFontOfSize:14.0];
    dateLab.textColor = [UIColor grayColor];
    dateLab.layer.masksToBounds = YES;
    dateLab.layer.cornerRadius = 4;
    self.dateLab = dateLab;
    
    UIImageView *addressIm = [[UIImageView alloc]init];
    addressIm.image = [UIImage imageNamed:@"needle"];
    self.addressIm = addressIm;
    
    UILabel *addressLab = [[UILabel alloc] init];
    addressLab.font = [UIFont systemFontOfSize:14.0];
    addressLab.textColor = [UIColor grayColor];
    addressLab.layer.masksToBounds = YES;
    addressLab.layer.cornerRadius = 4;
    self.addressLab = addressLab;
    
    
    UILabel *unitLab = [[UILabel alloc]init];
    unitLab.font = [UIFont systemFontOfSize:14.0];
    unitLab.textColor = [UIColor grayColor];
    unitLab.layer.masksToBounds = YES;
    unitLab.layer.cornerRadius = 4;
    self.unitLab = unitLab;
    
    
    [backView addSubview:clockIm ];
    [backView addSubview:addressIm];
    [backView addSubview:unitLab];
    [backView addSubview:icon];
    [backView addSubview:titleLab];
    [backView addSubview:dateLab];
    [backView addSubview:addressLab];
    [self.contentView addSubview:backView];

    
    
}

+ (ActiveTableViewCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *ActiveCell = @"ActiveCell";
    ActiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActiveCell];
    if (cell == nil) {
        cell = [[ActiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveCell];
    }
    return cell;
}

@end
