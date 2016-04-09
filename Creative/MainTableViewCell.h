//
//  MainTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *titleLab; // 标题
@property (nonatomic , strong) UILabel *detailLab; // 详情
@property (nonatomic , strong) UILabel *classLab; // 分类
@property (nonatomic , strong) UIButton *praiseBtn; // 赞
@property (nonatomic , strong) UILabel *praiseNumLab; // 点赞数
@property (nonatomic , strong) UIView *backView;


+ (MainTableViewCell *)cellWithTabelView:(UITableView *)tableView;

@end
