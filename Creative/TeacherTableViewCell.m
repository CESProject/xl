//
//  TeacherTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "TeacherTableViewCell.h"
#import "NewsViewController.h"

@implementation TeacherTableViewCell

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
    self.titleView = titleView;
    UIImageView *iconImage = [[UIImageView alloc]init];
    
    [titleView addSubview:iconImage];
    self.iconImage = iconImage;

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line];
    self.line = line;

    
//    UILabel *nameLab = [[UILabel alloc]init];
//    nameLab.text = @"发起人:";
//    self.nameLab = nameLab;
    
    UILabel *nameText = [[UILabel alloc]init];
    nameText.font = [UIFont systemFontOfSize:14];
    nameText.font = [UIFont boldSystemFontOfSize:14];
    [titleView addSubview:nameText];
//    [titleView addSubview:nameLab];
    self.nameText = nameText;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(focusClick) forControlEvents:UIControlEventTouchUpInside];
//    [addBtn setImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:0];
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, -3, 40);
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [titleView addSubview:addBtn];
    self.addBtn = addBtn;
    
    
//    UILabel *focusLab = [[UILabel alloc]init];
//    focusLab.text = @"关注";
//    [titleView addSubview:focusLab];
//    self.focusLab = focusLab;
    
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [msgBtn addTarget:self action:@selector(msgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [msgBtn setTitleColor:[UIColor blackColor] forState:0];
    msgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 55);
    msgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    msgBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [msgBtn setTitle:@"私信" forState:0];
    [msgBtn setImage:[UIImage imageNamed:@"sixin"] forState:0];
    [titleView addSubview:msgBtn];
    self.msgBtn = msgBtn;
    
    [self.contentView addSubview:titleView];
    titleView.backgroundColor = [UIColor whiteColor];
//    iconImage.backgroundColor = [UIColor grayColor];
}

- (void)focusClick
{
    if ([self.delegate respondsToSelector:@selector(deliverdDelier:)]) {
        [self.delegate deliverdDelier:self];
    }
}
- (void)msgBtnAction
{
    if ([self.delegate respondsToSelector:@selector(deliverSiXin:)]) {
        [self.delegate deliverSiXin:self];
    }
}


- (void)layoutSubviews
{

    self.titleView.frame = CGRectMake(0, 5, self.mj_w, 90);
    self.iconImage.frame = CGRectMake(10, 10, 70, 70);
//    self.iconImage.bounds = CGRectMake(0, 0, self.iconImage.frame.size.height/2, self.iconImage.frame.size.height/2);
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.height/2;
    self.iconImage.clipsToBounds = YES;

    self.line.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x + 10, self.iconImage.center.y, self.mj_w  - self.iconImage.mj_w - self.iconImage.mj_x - 30, 1);
//    self.nameLab.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x + 5, self.iconImage.mj_y + 5, 60, 25);
    self.nameText.frame = CGRectMake([self.iconImage right]+20, self.iconImage.mj_y + 5, self.mj_w  - self.iconImage.mj_w - self.iconImage.mj_x - 50, 25);
    self.addBtn.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x + 5, self.line.mj_h + self.line.mj_y + 10, 100, 30);
    self.msgBtn.frame = CGRectMake(self.mj_w  - 100, self.line.mj_h + self.line.mj_y + 8, 80, 25);
   
}

+ (TeacherTableViewCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *PJcell = @"teacherCellID";
    TeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PJcell];
    if (cell == nil) {
        cell = [[TeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PJcell];
    }
    return cell;
}

@end
