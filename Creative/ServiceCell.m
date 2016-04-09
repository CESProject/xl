//
//  ServiceCell.m
//  Creative
//
//  Created by huahongbo on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell

- (void)awakeFromNib {
    // Initialization code
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
    self.backView.frame = CGRectMake(0, 0.5, self.mj_w, self.mj_w/5+20);
    self.iconImage.frame = CGRectMake(10, 10, self.mj_w/3, self.mj_w/5);
    self.titleLab.frame = CGRectMake([self.iconImage right]+13, self.iconImage.mj_y+2, self.contentView.mj_w -self.iconImage.mj_w-30, 20);
    self.detailLab.frame = CGRectMake(self.titleLab.mj_x,self.titleLab.mj_y +self.titleLab.mj_h+ 5, self.contentView.mj_w -self.iconImage.mj_w-30, self.iconImage.mj_h-self.titleLab.mj_h-10);
}

- (void)createSubviews
{
    self.contentView.backgroundColor = GRAYCOLOR;
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    // 头像
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 4;
    icon.clipsToBounds = YES;
    self.iconImage = icon;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:15.0];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = [UIColor grayColor];
    titleLab.layer.masksToBounds = YES;
    titleLab.layer.cornerRadius = 4;
    self.titleLab = titleLab;
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.font = [UIFont systemFontOfSize:13.0];
    detailLab.textColor = UIColorFromHex(0x999999);
    detailLab.numberOfLines = 0;
    detailLab.layer.masksToBounds = YES;
    detailLab.layer.cornerRadius = 4;
    self.detailLab = detailLab;
    
    [backView addSubview:icon];
    [backView addSubview:titleLab];
    [backView addSubview:detailLab];

    [self.contentView addSubview:backView];
    self.backView = backView;
    
}

+ (ServiceCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *cellId = @"celliD";
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
