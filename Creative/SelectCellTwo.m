//
//  SelectCellTwo.m
//  Creative
//
//  Created by Mr Wei on 16/2/23.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "SelectCellTwo.h"

@implementation SelectCellTwo

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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
    
    self.lblName.frame = CGRectMake(10, 10, self.contentView.mj_w - 60, 30);
    self.btnS.frame = CGRectMake(self.contentView.mj_w - 30, (self.contentView.mj_h - 30) * 0.5, 20, 20);
    
    
}
- (void)setChecked:(BOOL)checked{
    if (checked) {
        self.btnS.image = [UIImage imageNamed:@"selecteds"];
        self.lblName.textColor = [UIColor orangeColor];
        
    }
    else
    {
        self.btnS.image = [UIImage imageNamed:@"selects"];
        self.lblName.textColor =UIColorFromHex(0x87ceeb);
    }
    m_checked = checked;
}
- (void)createUI
{
    UILabel *lblName = [[UILabel alloc] init];
//    lblName.font = [UIFont systemFontOfSize:16.0];
    lblName.textColor = [UIColor blackColor];
    lblName.textAlignment = NSTextAlignmentCenter;
    self.lblName = lblName;
    
    UIImageView *btnS = [[UIImageView alloc] init];
    [btnS setImage:[UIImage imageNamed:@"selects"]];
    btnS.alpha = 0;
    self.btnS = btnS;
    
    [self.contentView addSubview:btnS];
    [self.contentView addSubview:lblName];
    
    
}
+ (SelectCellTwo *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *celltwoId = @"celltwoId";
    SelectCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:celltwoId];
    if (cell == nil) {
        cell = [[SelectCellTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celltwoId];
    }
    return cell;
}



@end
