//
//  CommentsTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "CommentsTableViewCell.h"
#import "UIView+MJExtension.h"

@implementation CommentsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    //    self.backgroundColor = COMColor(30, 40, 50, 1.0);
    UIColor *color1 =  COMColor(30, 40, 50, 1.0);
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"common"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn = sendBtn;
    [self.contentView addSubview:sendBtn];
    
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    iconImage.layer.cornerRadius = 4;
    iconImage.clipsToBounds = YES;
    iconImage.backgroundColor = color1;
    [self.contentView addSubview:iconImage];
    self.iconImage = iconImage;
    
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *contLab = [[UILabel alloc]init];
    contLab.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:contLab];
    self.contLab = contLab;
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.font = [UIFont systemFontOfSize:14.0];
    dateLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:dateLab];
    self.dateLab = dateLab;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    self.line = line;
    
    
}

- (void)layoutSubviews
{
    self.sendBtn.frame = CGRectMake(5, 10, 20, 20);
    self.iconImage.frame = CGRectMake(self.sendBtn.mj_w + self.sendBtn.mj_x, 5, 50, 50);
    self.nameLab.frame = CGRectMake(self.iconImage.mj_x + self.iconImage.mj_w + 10, 5, (self.mj_w - self.iconImage.mj_x - self.iconImage.mj_w - 20) / 2, 20) ;
    self.dateLab.frame = CGRectMake(self.nameLab.mj_w + self.nameLab.mj_x + 5,  self.nameLab.mj_y, (self.mj_w - self.iconImage.mj_x - self.iconImage.mj_w - 20) / 2, 20);
    self.contLab.frame = CGRectMake(self.iconImage.mj_x + self.iconImage.mj_w + 10, self.dateLab.mj_y + self.dateLab.mj_h + 5, self.mj_w - self.iconImage.mj_x + self.iconImage.mj_w + 20, 25);
    self.iconImage.backgroundColor = [UIColor blueColor];
    
    self.line.frame = CGRectMake(0, self.mj_h - 1, self.mj_w, 0.5);
    
}

- (void)sendBtnAction:(UIButton *)sender
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
