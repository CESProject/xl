//
//  ShearchRoadCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/27.
//  Copyright © 2016年 王文静. All rights reserved.
// *************  路演筛选 cell ****************

#import "ShearchRoadCell.h"

@implementation ShearchRoadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAddSubviews];
    }
    return self;
}

- (void)createAddSubviews
{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView *backView = [[UIView alloc]init];
//    backView.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    
    UILabel *typeLab = [[UILabel alloc]init];
    typeLab.textColor = [UIColor grayColor];
    //    UILabel *placeLab = [[UILabel alloc]init];
    //    placeLab.textColor = [UIColor grayColor];
    
    self.typeLab = typeLab;
    //    self.placeLab = placeLab;
    
    [backView addSubview:typeLab];
    //    [backView addSubview:placeLab];
    [self.contentView addSubview:backView];
    self.backView = backView;
    
}

- (void)layoutSubviews
{
    self.backView.frame = CGRectMake(10, 10, self.mj_w - 20, 25);
    self.typeLab.frame = CGRectMake(0, 0, self.backView.mj_w, 25);
    //    self.placeLab.frame = CGRectMake(self.typeLab.mj_w + self.typeLab.mj_x, 0, (self.mj_w - 20) / 2, 25);
    
}

+ (ShearchRoadCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *shearCellID = @"shearCellID";
    ShearchRoadCell *cell = [tableView dequeueReusableCellWithIdentifier:shearCellID];
    if (cell == nil) {
        cell = [[ShearchRoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shearCellID];
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
