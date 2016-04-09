//
//  ListCell.m
//  Creative
//
//  Created by Mr Wei on 16/2/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.btnS.frame = CGRectMake(10, 20, 10, 10);
    self.lblName.frame = CGRectMake(self.btnS.mj_w + self.btnS.mj_x, 10, self.mj_w - 30, 30);
    
    
}
- (void)setChecked:(BOOL)checked{
    if (checked) {
//        self.lblName.textColor = [UIColor orangeColor];
        self.btnS.alpha = 1.0;
        
    }
    else
    {
//        self.lblName.textColor = [UIColor blueColor];
         self.btnS.alpha = 0;
    }
    m_checked = checked;
}



- (void)createUI
{
    UILabel *lblName = [[UILabel alloc] init];
    lblName.textColor = [UIColor blackColor];
    lblName.textAlignment = NSTextAlignmentCenter;
    self.lblName = lblName;
    
    UIView *btnS = [[UIView alloc] init];
    btnS.backgroundColor = [UIColor orangeColor];
    btnS.layer.masksToBounds = YES;
    btnS.layer.cornerRadius = 12;
    btnS.alpha = 0;
    self.btnS = btnS;
    
    [self.contentView addSubview:btnS];
    [self.contentView addSubview:lblName];
    
    
}
+ (ListCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *listcell = @"listcell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:listcell];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listcell];
    }
    return cell;
}

@end
