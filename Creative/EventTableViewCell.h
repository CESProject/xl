//
//  EventTableViewCell.h
//  addcellTest
//
//  Created by Mr Wei on 16/1/22.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateEventModel.h"
#import "informationModel.h"

@interface EventTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UILabel *dateLab;
@property (nonatomic , strong) UITextField *dateText;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UILabel *eventLab;
@property (nonatomic , strong) UITextField *eventText;
@property (nonatomic , strong) UIView *line3;

@property (nonatomic , strong) UIButton *addBtn;
@property (nonatomic , strong) UIButton *delBtn;

@property(nonatomic,strong)UIView *datePut;
@property(nonatomic,copy)NSString *formatterDate;
@property(nonatomic,strong)UITextField *textFieldS;





@property (nonatomic , strong) informationModel *infoModel;

+ (EventTableViewCell *)cellWithTableView:(UITableView *)tableview;

@end
