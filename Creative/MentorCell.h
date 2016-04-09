//
//  MentorCell.h
//  Creative
//
//  Created by huahongbo on 16/3/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MentorCell : UITableViewCell
@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UILabel *serLab; //
@property (nonatomic , strong) UILabel *serText;
@property (nonatomic , strong) UILabel *nameLab;
@property (nonatomic , strong) UILabel *nameText; // 
+ (MentorCell *)cellWithTabelView:(UITableView *)tableView;
@end
