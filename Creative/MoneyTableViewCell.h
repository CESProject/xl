//
//  MoneyTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyTableViewCell : UITableViewCell

@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIImageView *dateIm;
@property (nonatomic , strong) UILabel *dateLab;
@property (nonatomic , strong) UILabel *moneyLab;
@property (nonatomic , strong) UILabel *moneyConLab;
@property (nonatomic , strong) UILabel *typeLab;
@property (nonatomic , strong) UILabel *typeConLab;
@property (nonatomic , strong) UILabel *guildLab;
@property (nonatomic , strong) UILabel *guildConLab;
@property (nonatomic , strong) UIView *backView;

+ (MoneyTableViewCell *)cellWithTabelView:(UITableView *)tableView;

@end
