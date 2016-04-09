//
//  MainTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIView+MJExtension.h"
#import "UIImageView+WebCache.h"

@implementation MainTableViewCell

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
    self.backView.frame = CGRectMake(0, 0.5, self.mj_w, self.mj_w/5+20);
    self.iconImage.frame = CGRectMake(10, 10, self.mj_w/3, self.mj_w/5);
    self.titleLab.frame = CGRectMake([self.iconImage right]+13, self.iconImage.mj_y+2, self.contentView.mj_w -self.iconImage.mj_w-30, 20);
    self.detailLab.frame = CGRectMake(self.titleLab.mj_x,self.titleLab.mj_y +self.titleLab.mj_h+ 5, self.contentView.mj_w -self.iconImage.mj_w-30, 20);
    self.classLab.frame = CGRectMake(self.titleLab.mj_x,self.detailLab.mj_y +self.detailLab.mj_h + 3, self.contentView.mj_w - 200, 20);
    
//    self.praiseBtn.frame = CGRectMake(self.mj_w-60,self.detailLab.mj_y +self.detailLab.mj_h + 5, 20, 20);
//    
//    self.praiseNumLab.frame = CGRectMake([self.praiseBtn right]+1,self.detailLab.mj_y +self.detailLab.mj_h + 5, self.contentView.mj_w - self.praiseBtn.mj_x - self.praiseBtn.mj_w - 4 , 20);
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
    
    UILabel *classLab = [[UILabel alloc] init];
    classLab.font = [UIFont systemFontOfSize:11.0];
    classLab.textColor = UIColorFromHex(0xcccccc);
    classLab.layer.masksToBounds = YES;
    classLab.layer.cornerRadius = 4;
    self.classLab = classLab;
    
//    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////    [praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
//    self.praiseBtn = praiseBtn;
//    
//    UILabel *praiseNumLab = [[UILabel alloc] init];
//    praiseNumLab.font = [UIFont systemFontOfSize:14.0];
//    praiseNumLab.textColor = [UIColor grayColor];
//    praiseNumLab.layer.masksToBounds = YES;
//    praiseNumLab.layer.cornerRadius = 4;
//    self.praiseNumLab = praiseNumLab;
    
    [backView addSubview:icon];
    [backView addSubview:titleLab];
    [backView addSubview:detailLab];
    [backView addSubview:classLab];
//    [backView addSubview:praiseBtn];
//    [backView addSubview:praiseNumLab];
   
    
    [self.contentView addSubview:backView];
    self.backView = backView;
    
}

+ (MainTableViewCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *cellId = @"celliD";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}



@end
