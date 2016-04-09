//
//  ResultsTableViewCell.h
//  Creative
//
//  Created by huahongbo on 16/1/4.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *smalImage; //图片
@property (nonatomic , strong) UIImageView *bubblesImage; //图片框
@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *nameLab; // 姓名
@property (nonatomic , strong) UIImageView *timeImage; // 时间
@property (nonatomic , strong) UILabel *dateLab; // 日期
@property (nonatomic , strong) UIImageView *detaiImage; // 内容图片
@property (nonatomic , strong) UILabel *detailLab; // 详情

@end
