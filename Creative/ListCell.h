//
//  ListCell.h
//  Creative
//
//  Created by Mr Wei on 16/2/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell


{
    
    BOOL			m_checked;
}

@property(nonatomic,weak)UILabel *lblName;
@property(nonatomic,weak)UILabel *lblNum;
@property(nonatomic,weak)UIView *btnS;
//@property(nonatomic,assign)BOOL isSelect;

+ (ListCell *)cellWithTabelView:(UITableView *)tableView;
- (void)setChecked:(BOOL)checked;


@end
