//
//  PlaceTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *titleLab; // 标题
@property (nonatomic , strong) UIImageView *addressIm;
@property (nonatomic , strong) UILabel *addressLab; // 地址
@property (nonatomic , strong) UIImageView *arrowView;
@property (nonatomic , strong) UIView *titleView;


+ (PlaceTableViewCell *)cellWithTabelView:(UITableView *)tableView;

@end
