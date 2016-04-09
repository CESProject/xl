//
//  ShearchRoadCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/27.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShearchRoadCell : UITableViewCell

@property (nonatomic , strong) UILabel *typeLab;
@property (nonatomic , strong) UILabel *placeLab;
@property (nonatomic , strong) UIView *backView;

+ (ShearchRoadCell *)cellWithTabelView:(UITableView *)tableView;

@end
