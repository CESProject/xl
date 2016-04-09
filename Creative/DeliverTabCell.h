//
//  DeliverTabCell.h
//  Creative
//
//  Created by huahongbo on 16/1/20.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliverTabCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *deliTF;

+ (DeliverTabCell *)cellWithTabelView:(UITableView *)tableView;
@end
