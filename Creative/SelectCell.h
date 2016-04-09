//
//  SelectCell.h
//  assistant
//
//  Created by Apple on 15/7/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCell : UITableViewCell
{

    BOOL			m_checked;
}

@property(nonatomic,weak)UILabel *lblName;
@property(nonatomic,weak)UILabel *lblNum;
@property(nonatomic,weak)UIImageView *btnS;
//@property(nonatomic,assign)BOOL isSelect;

+ (SelectCell *)cellWithTabelView:(UITableView *)tableView;
- (void)setChecked:(BOOL)checked;
@end
