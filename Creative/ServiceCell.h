//
//  ServiceCell.h
//  Creative
//
//  Created by huahongbo on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell
@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *titleLab; // 标题
@property (nonatomic , strong) UILabel *detailLab; // 详情
@property (nonatomic , strong) UIView *backView;
+ (ServiceCell *)cellWithTabelView:(UITableView *)tableView;
@end
