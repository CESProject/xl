//
//  TeacherTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherTableViewCell;
@protocol TeacherTableViewCellDelegate <NSObject>
- (void)deliverSiXin:(TeacherTableViewCell *)teachCell;
- (void)deliverdDelier:(TeacherTableViewCell *)teachCell;
@end
@interface TeacherTableViewCell : UITableViewCell
@property (nonatomic , strong) UIView *backGround;
@property (nonatomic , strong) UIView *titleView; // 头部
@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UIView *line; // 灰线
//@property (nonatomic , strong) UILabel *nameLab; // 发起人
@property (nonatomic , strong) UILabel *nameText; // 发起人姓名
@property (nonatomic , strong) UIButton *addBtn; // 添加关注
@property (nonatomic , strong) UILabel *focusLab; // 关注
@property (nonatomic , strong) UIButton *msgBtn;// 发私信
@property (nonatomic , strong) UILabel *msgLab;
@property(nonatomic,weak)id<TeacherTableViewCellDelegate>delegate;

+ (TeacherTableViewCell *)cellWithTabelView:(UITableView *)tableView;

@end
