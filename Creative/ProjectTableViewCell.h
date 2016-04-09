//
//  ProjectTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *titleLab; // 标题
@property (nonatomic , strong) UILabel *classLab; // 分类
@property (nonatomic , strong) UILabel *domainLab; // 领域
@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UIView *line;

+ (ProjectTableViewCell *)cellWithTabelView:(UITableView *)tableView;

@end
