//
//  CommentsTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconImage;
@property (nonatomic , strong) UIButton *sendBtn; // 评论
@property (nonatomic , strong) UILabel  *nameLab; // 名称
@property (nonatomic , strong) UILabel  *contLab; // 内容
@property (nonatomic , strong) UILabel  *dateLab ;// 时间
@property (nonatomic , strong) UIView *line;
@end
