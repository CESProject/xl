//
//  ContactCell.h
//  Creative
//
//  Created by huahongbo on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (nonatomic , strong) UIView *backGround;
@property (nonatomic , strong) UIView *titleView; // 头部
@property (nonatomic , strong) UIView *line; // 灰线
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *nameLab;
@property (nonatomic , strong) UILabel *phoneLab;
@property (nonatomic , strong) UIImageView *faxImg;
@property (nonatomic , strong) UILabel *faxLab;
@property (nonatomic , strong) UIImageView *QQImg;
@property (nonatomic , strong) UILabel *QQLab;

+ (ContactCell *)cellWithTabelView:(UITableView *)tableView;
@end
