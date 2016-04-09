//
//  SelectCellTwo.h
//  Creative
//
//  Created by Mr Wei on 16/2/23.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCellTwo : UITableViewCell

{
    
    BOOL			m_checked;
}

@property(nonatomic,weak)UILabel *lblName;
@property(nonatomic,weak)UILabel *lblNum;
@property(nonatomic,weak)UIImageView *btnS;
//@property(nonatomic,assign)BOOL isSelect;

+ (SelectCellTwo *)cellWithTabelView:(UITableView *)tableView;
- (void)setChecked:(BOOL)checked;

@end
