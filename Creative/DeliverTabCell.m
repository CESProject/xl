//
//  DeliverTabCell.m
//  Creative
//
//  Created by huahongbo on 16/1/20.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "DeliverTabCell.h"

@implementation DeliverTabCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.deliTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, DEF_SCREEN_WIDTH-40, self.mj_h)];
        self.deliTF.delegate = self;
        [self addSubview:self.deliTF];
        
    }
    return self;
}
+ (DeliverTabCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *cellId = @"deliverCellID";
    DeliverTabCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DeliverTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
