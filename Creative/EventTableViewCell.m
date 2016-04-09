//
//  EventTableViewCell.m
//  addcellTest
//
//  Created by Mr Wei on 16/1/22.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

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
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addBtn.backgroundColor = [UIColor cyanColor];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"c-3"] forState:UIControlStateNormal];
    self.addBtn = addBtn;
    [self.contentView addSubview:addBtn];
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setBackgroundImage:[UIImage imageNamed:@"c-2"] forState:UIControlStateNormal];
    self.delBtn = delBtn;
    [self.contentView addSubview:delBtn];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.text = @"时间";
    dateLab.font = [UIFont systemFontOfSize:17.0];
    dateLab.textColor = [UIColor grayColor];
    self.dateLab = dateLab;
    
    UITextField *dateText = [[UITextField alloc]init];
    dateText.font = [UIFont systemFontOfSize:17.0];
    dateText.placeholder = @"请输入年份：2016";
    dateText.delegate = self;
    dateText.tag = 101;
//    dateText.inputView = self.datePut;
    [dateText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
   
    self.dateText = dateText;
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 = line2;
    
    UILabel *eventLab = [[UILabel alloc]init];
    eventLab.text = @"事件";
    eventLab.font = [UIFont systemFontOfSize:17.0];
    eventLab.textColor = [UIColor grayColor];
    self.eventLab = eventLab;
    
    UITextField *eventText = [[UITextField alloc]init];
    eventText.font = [UIFont systemFontOfSize:17.0];
    eventText.placeholder = @"事件";
    eventText.delegate = self;
    eventText.tag = 102;
    [eventText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.eventText = eventText;
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    [backView addSubview:line1];
    [backView addSubview:dateLab];
    [backView addSubview:dateText];
    [backView addSubview:line2];
    [backView addSubview:eventLab];
    [backView addSubview:eventText];
    [backView addSubview:line3];
    
    self.backView = backView;
    [self.contentView addSubview:backView];
    
}

- (void)layoutSubviews
{
    self.line1.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    
    self.addBtn.frame = CGRectMake(self.mj_w - 100, 10, 30, 30);
    self.delBtn.frame = CGRectMake(self.mj_w - 50, 10, 30, 30);
    self.backView.frame = CGRectMake(0, 40, self.frame.size.width, 71);
    self.dateLab.frame = CGRectMake(10, 10, 60, 25);
    self.dateText.frame = CGRectMake(self.dateLab.mj_w + self.dateLab.mj_x, 10, self.frame.size.width - 80, 25);
    self.line2.frame = CGRectMake(10, self.dateText.frame.size.height + self.dateText.frame.origin.y , self.frame.size.width - 20, 1);
    
    self.eventLab.frame = CGRectMake(10, CGRectGetHeight(self.dateText.frame) + self.dateText.frame.origin.y + 10, 60, 25);
    self.eventText.frame =  CGRectMake(self.eventLab.mj_w + self.eventLab.mj_x, CGRectGetHeight(self.dateText.frame)+self.dateText.frame.origin.y + 10, self.frame.size.width - 80, 25);
    self.line3.frame = CGRectMake(0, CGRectGetHeight(self.eventText.frame) + self.eventText.frame.origin.y, self.frame.size.width, 1);

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
+ (EventTableViewCell *)cellWithTableView:(UITableView *)tableview
{
    static NSString *eventCellID = @"eventCellID";
    EventTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:eventCellID];
    if (nil == cell) {
        cell = [[EventTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellID];
        
    }
    return cell;
}

- (void)setInfoModel:(informationModel *)infoModel
{
    if (_infoModel != infoModel)
    {
        _infoModel = infoModel;
    }
}

-(void)doValueChanged:(UITextField *)sender
{
    if (sender.tag == 101)
    {
        _infoModel.footprintTime = sender.text;
    }
    else
    {
        _infoModel.incident = sender.text;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}


- (UIView *)datePut
{
    
    if (!_datePut) {
        _datePut = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.mj_w,216)];
        UIButton *btnS = [[UIButton alloc] initWithFrame:CGRectMake(10, 3, 40, 20)];
        [btnS setTitle:@"确定" forState:UIControlStateNormal];
        [btnS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnS addTarget:self action:@selector(btnSClike) forControlEvents:UIControlEventTouchUpInside];
        [_datePut addSubview:btnS];
        
        UIButton *btnQ = [[UIButton alloc] initWithFrame:CGRectMake(_datePut.mj_w - 20, 3, 40, 20)];
        [btnQ setTitle:@"取消" forState:UIControlStateNormal];
        [btnQ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnQ addTarget:self action:@selector(btnQClike) forControlEvents:UIControlEventTouchUpInside];
        [_datePut addSubview:btnQ];
        
        UIDatePicker *dat = [[UIDatePicker alloc] initWithFrame:CGRectMake(20,20, _datePut.mj_w, _datePut.mj_h - 20)];
        dat.datePickerMode = UIDatePickerModeDate;
        [dat addTarget:self action:@selector(datePick:) forControlEvents:UIControlEventValueChanged];
        [_datePut addSubview:dat];
    }
    return _datePut;
}
- (void)datePick:(id)pick
{
    UIDatePicker *pc = (UIDatePicker *)pick;
    NSDate *da = pc.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.formatterDate = [formatter stringFromDate:da];
}
- (void)btnSClike
{
    self.dateText.text = self.formatterDate;
    [self.dateText endEditing:YES];
    
}
- (void)btnQClike
{
    self.dateText.text = @"";
    [self.dateText endEditing:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
