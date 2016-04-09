//
//  SelectCell.m
//  assistant
//
//  Created by Apple on 15/7/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SelectCell.h"
#import "UIView+MJExtension.h"
#import "common.h"
#import "UIImageView+WebCache.h"
@implementation SelectCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
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
    
    self.lblName.frame = CGRectMake(10, 5, self.contentView.mj_w - 90, 20);
    self.btnS.frame = CGRectMake(self.contentView.mj_w - 70, (self.contentView.mj_h - 30) * 0.5, 20, 20);
    
    
}
- (void)setChecked:(BOOL)checked{
    if (checked) {
        self.btnS.image = [UIImage imageNamed:@"selecteds"];
        
    }else
    {
        
        self.btnS.image = [UIImage imageNamed:@"selects"];
    }
    m_checked = checked;
}
- (void)createUI
{
    UILabel *lblName = [[UILabel alloc] init];
    lblName.font = [UIFont systemFontOfSize:16.0];
    lblName.textColor = [UIColor blackColor];
    
    self.lblName = lblName;
    
    UIImageView *btnS = [[UIImageView alloc] init];
    [btnS setImage:[UIImage imageNamed:@"selects"]];
    self.btnS = btnS;
    
    [self.contentView addSubview:btnS];
    [self.contentView addSubview:lblName];
    
    
}
+ (SelectCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *cellId = @"opop";
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}



@end
