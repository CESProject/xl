//
//  ActiveTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *titleLab; // 标题
@property (nonatomic , strong) UIImageView *clockIm;
@property (nonatomic , strong) UILabel *dateLab; // 时间
@property (nonatomic , strong) UIImageView *addressIm;
@property (nonatomic , strong) UILabel *addressLab; // 地址
@property (nonatomic , strong) UILabel *unitLab;
@property (nonatomic , strong) UIView *backView;
//@property (nonatomic , strong) UIButton *praiseBtn; // 赞
//@property (nonatomic , strong) UILabel *praiseNumLab; // 点赞数


+ (ActiveTableViewCell *)cellWithTabelView:(UITableView *)tableView;

@end
