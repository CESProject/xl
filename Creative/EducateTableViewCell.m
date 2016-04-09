//
//  EducateTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "EducateTableViewCell.h"

#define YNBOOL YES;

@implementation EducateTableViewCell

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
    [addBtn setBackgroundImage:[UIImage imageNamed:@"c-3"] forState:UIControlStateNormal];
//    addBtn.backgroundColor = [UIColor whiteColor];
    self.addBtn = addBtn;
    [self.contentView addSubview:addBtn];
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setBackgroundImage:[UIImage imageNamed:@"c-2"] forState:UIControlStateNormal];
    self.delBtn = delBtn;
    [self.contentView addSubview:delBtn];
    
    UIView *backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    UIView *line6 = [[UIView alloc]init];
    line6.backgroundColor = [UIColor grayColor];
    self.line6 = line6;
    
    UILabel *schooltypeLab = [[UILabel alloc]init];
    schooltypeLab.text = @"学校类型";
    schooltypeLab.textColor = [UIColor grayColor];
    
    self.schooltypeLab = schooltypeLab;
    
    UITextField *schooltypeText = [[UITextField alloc]init];
    schooltypeText.tag = 101;
    schooltypeText.enabled = YNBOOL;
    schooltypeText.placeholder = @"请输入年份：2015";
    schooltypeText.delegate = self;
    [schooltypeText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
    self.schooltypeText = schooltypeText;
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UILabel *schoolnameLab = [[UILabel alloc]init];
    schoolnameLab.text = @"学校名称";
    schoolnameLab.textColor = [UIColor grayColor];
    self.schoolnameLab = schoolnameLab;
    
    UITextField *schoolnameText = [[UITextField alloc]init];
    schoolnameText.tag = 102;
    schoolnameText.delegate =self;
    schoolnameText.enabled = YNBOOL;
    //    schoolnameText.delegate = self;
    [schoolnameText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.schoolnameText = schoolnameText;
    
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 = line2;
    
    UILabel *sectionLab = [[UILabel alloc]init];
    sectionLab.text = @"院系";
    sectionLab.textColor = [UIColor grayColor];
    
    self.sectionLab = sectionLab;
    
    UITextField *sectionText = [[UITextField alloc]init];
    sectionText.tag = 103;
    sectionText.delegate = self;
    sectionText.enabled = YNBOOL;
    [sectionText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.sectionText = sectionText;
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.text = @"入学年份";
    dateLab.textColor = [UIColor grayColor];
    
    self.dateLab = dateLab;
    
    UITextField *dateText1 = [[UITextField alloc]init];
    dateText1.tag = 104;
    dateText1.delegate = self;
    dateText1.enabled = YNBOOL;
    [dateText1 addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.dateText1 = dateText1;
    
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    
    [backGroundView addSubview:schooltypeLab];
    [backGroundView addSubview:schooltypeText];
    [backGroundView addSubview:schoolnameLab];
    [backGroundView addSubview:schoolnameText];
    [backGroundView addSubview:sectionLab];
    [backGroundView addSubview:sectionText];
    [backGroundView addSubview:dateLab];
    [backGroundView addSubview:dateText1];
    
    [backGroundView addSubview:line1];
    [backGroundView addSubview:line2];
    [backGroundView addSubview:line3];
    [backGroundView addSubview:line4];
    [backGroundView addSubview:line6];
    
    self.backGroundView = backGroundView;
    [self.contentView addSubview:backGroundView];
}

- (void)layoutSubviews
{
    self.addBtn.frame = CGRectMake(self.mj_w - 100, 10, 30, 30);
    self.delBtn.frame = CGRectMake(self.mj_w - 50, 10, 30, 30);
    
    self.backGroundView.frame = CGRectMake(0, self.addBtn.mj_y + self.addBtn.mj_h , self.mj_w, 140);
    self.line6.frame = CGRectMake(0, 0, self.mj_w, 1);
    self.schooltypeLab.frame = CGRectMake(10, 10, 80, 25);
    self.schooltypeText.frame = CGRectMake(self.schooltypeLab.mj_x +self.schooltypeLab.mj_w ,10,  self.mj_w - self.schooltypeLab.mj_x - self.schooltypeLab.mj_w - 20, 25);
    self.line1.frame = CGRectMake(10, self.schooltypeText.mj_h + self.schooltypeText.mj_y,  self.mj_w - 20, 1);
    
    self.schoolnameLab.frame = CGRectMake(self.schooltypeLab.mj_x, self.schooltypeText.mj_h + self.schooltypeText.mj_y + 10, 80, 25);
    
    self.schoolnameText.frame = CGRectMake(self.schoolnameLab.mj_x +self.schoolnameLab.mj_w, self.schoolnameLab.mj_y, self.mj_w - self.schoolnameLab.mj_x - self.schoolnameLab.mj_w - 20, 25);
    self.line2.frame = CGRectMake(self.line1.mj_x , self.schoolnameText.mj_y + self.schoolnameText.mj_h, self.mj_w - 20, 1);
    
    self.sectionLab.frame = CGRectMake(self.schooltypeLab.mj_x, self.schoolnameText.mj_h + self.schoolnameText.mj_y + 10, 80, 25);
    
    self.sectionText.frame = CGRectMake(self.sectionLab.mj_x +self.sectionLab.mj_w, self.sectionLab.mj_y , self.mj_w - self.sectionLab.mj_x - self.sectionLab.mj_w - 20, 25);
    self.line3.frame = CGRectMake(self.line1.mj_x , self.sectionText.mj_y + self.sectionText.mj_h, self.mj_w - 20, 1);
    
    self.dateLab.frame = CGRectMake(self.schooltypeLab.mj_x, self.sectionText.mj_h + self.sectionText.mj_y + 10, 80, 25);
    self.dateText1.frame = CGRectMake(self.dateLab.mj_x +self.dateLab.mj_w, self.dateLab.mj_y, self.mj_w - self.dateLab.mj_x - self.dateLab.mj_w - 80, 25);
    
    
    self.line4.frame = CGRectMake(0, self.dateText1.mj_y + self.dateText1.mj_h, self.mj_w , 1);
    
}

+ (EducateTableViewCell *)cellWithTableView:(UITableView *)tableview
{
    static NSString *eduCellID = @"eduCellID";
    EducateTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:eduCellID];
    if (nil == cell) {
        cell = [[EducateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eduCellID];
        
    }
    return cell;
}

- (void)setInfmodelcell:(informationModel *)infmodelcell
{
    if (_infmodelcell != infmodelcell) {
        _infmodelcell = infmodelcell;
    }
}

-(void)doValueChanged:(UITextField *)sender
{
    if (sender.tag == 101)
    {
        //        _infmodelcell.schoolType = sender.text;
        for (int i = 0; i < self.schoolArr.count; i ++) {
            if ([self.schoolArr[i] isEqualToString:sender.text])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                _infmodelcell.schoolType = str;
            }
        }
    }
    else if(sender.tag == 102)
    {
        _infmodelcell.schoolName = sender.text;
        
    }
    else if(sender.tag == 103)
    {
        _infmodelcell.academyName = sender.text;
    }
    
    else
    {
        _infmodelcell.entranceYear = sender.text;
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textFieldS = textField;
    
    switch (textField.tag) {
        case 101:
            self.arrDataS = self.schoolArr;
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            
            break;
            
        default:
            break;
    }
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSArray *)schoolArr
{
    if (!_schoolArr) {
        _schoolArr = @[@"大学",@"大专",@"高中",@"初中",@"小学",@"其他"];
        //        0：大学；1：大专；2：高中；3：初中；4：小学；5其他
    }
    return _schoolArr;
}

#pragma mark - pickerDelegate 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return [self.arrDataS count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.arrDataS[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    self.strPicker = self.arrDataS[row];
    
}
//
- (UIView *)picker
{
    
    if (!_picker) {
        _picker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.mj_w, 200)];
        _picker.backgroundColor = [UIColor lightGrayColor];
        UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.mj_w, 200)];
        pick.delegate = self;
        pick.dataSource = self;
        pick.showsSelectionIndicator = YES;
        self.pick = pick;
        [_picker addSubview:pick];
        
        UIButton *btnS = [[UIButton alloc] initWithFrame:CGRectMake(5, 4, 60, 30)];
        [btnS setTitle:@"确定" forState:UIControlStateNormal];
        [btnS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnS.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btnS.backgroundColor = [UIColor clearColor];
        [btnS addTarget:self action:@selector(btnOK) forControlEvents:UIControlEventTouchUpInside];
        [_picker addSubview:btnS];
        
        UIButton *btnC = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.mj_w - 65, 4, 60, 30)];
        [btnC setTitle:@"取消" forState:UIControlStateNormal];
        [btnC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnC.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btnC.backgroundColor = [UIColor clearColor];
        [btnC addTarget:self action:@selector(btnCancle) forControlEvents:UIControlEventTouchUpInside];
        [_picker addSubview:btnC];
        
        
    }
    return _picker;
}
- (void)btnCancle
{
    
    [self.textFieldS endEditing:YES];
    
}
- (void)btnOK
{
    self.textFieldS.text = self.strPicker;
    [self.textFieldS endEditing:YES];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
