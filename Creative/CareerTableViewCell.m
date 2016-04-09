//
//  CareerTableViewCell.m
//  addcellTest
//
//  Created by Mr Wei on 16/1/25.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import "CareerTableViewCell.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "common.h"

@implementation CareerTableViewCell

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
//    addBtn.backgroundColor = [UIColor cyanColor];
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
    
    UILabel *proviceLab = [[UILabel alloc]init];
    proviceLab.text = @"所在省";
    proviceLab.textColor = [UIColor grayColor];
    
    self.proviceLab = proviceLab;
    
    UITextField *proviceText = [[UITextField alloc]init];
    proviceText.tag = 101;
    proviceText.delegate = self;
    [proviceText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
    self.proviceText = proviceText;
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UILabel *cityLab = [[UILabel alloc]init];
    cityLab.text = @"所在市";
    cityLab.textColor = [UIColor grayColor];
    self.cityLab = cityLab;
    
    UITextField *cityText = [[UITextField alloc]init];
    cityText.tag = 102;
    cityText.delegate = self;
    [cityText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
    self.cityText = cityText;
    
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 = line2;
    
    UILabel *sectionLab = [[UILabel alloc]init];
    sectionLab.text = @"单位名称";
    sectionLab.textColor = [UIColor grayColor];
    
    self.sectionLab = sectionLab;
    
    UITextField *sectionText = [[UITextField alloc]init];
    sectionText.tag = 103;
    sectionText.delegate = self;
    [sectionText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.sectionText = sectionText;
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.text = @"工作时间";
    dateLab.textColor = [UIColor grayColor];
    
    
    UILabel *textLab = [[UILabel alloc]init];
    textLab.text = @"至";
    textLab.textColor = [UIColor grayColor];
    self.textLab = textLab;
    
    UIImageView *imCl1 = [[UIImageView alloc]init];
    imCl1.image = [UIImage imageNamed:@"z (1)"];
    
    UIImageView *imCl2 = [[UIImageView alloc]init];
    imCl2.image = [UIImage imageNamed:@"z (1)"];
    
    self.imCl1 = imCl1;
    self.imCl2 = imCl2;
    
    self.dateLab = dateLab;
    
    UITextField *dateText1 = [[UITextField alloc]init];
    UITextField *dateText2 = [[UITextField alloc]init];
    dateText1.tag = 104;
    dateText1.delegate = self;
    dateText1.inputView = self.datePut;
    [dateText1 addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
    
    dateText2.tag = 105;
    dateText2.delegate = self;
    dateText2.inputView = self.datePut;
    [dateText2 addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.dateText1 = dateText1;
    self.dateText2 = dateText2;
    
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    UILabel *branchLab = [[UILabel alloc]init];
    branchLab.text = @"部门/职位";
    branchLab.textColor = [UIColor grayColor];
    
    self.branchLab = branchLab;
    
    UITextField *branchText = [[UITextField alloc]init];
    branchText.tag = 106;
    branchText.delegate = self;
    [branchText addTarget:self action:@selector(doValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.branchText = branchText;
    
    UIView *line5 = [[UIView alloc]init];
    line5.backgroundColor = [UIColor grayColor];
    self.line5 = line5;
    
    [backGroundView addSubview:proviceLab];
    [backGroundView addSubview:proviceText];
    [backGroundView addSubview:cityLab];
    [backGroundView addSubview:cityText];
    [backGroundView addSubview:sectionLab];
    [backGroundView addSubview:sectionText];
    [backGroundView addSubview:dateLab];
    [backGroundView addSubview:dateText1];
    [backGroundView addSubview:dateText2];
    [backGroundView addSubview:branchLab];
    [backGroundView addSubview:branchText];
    
    [backGroundView addSubview:line1];
    [backGroundView addSubview:line2];
    [backGroundView addSubview:line3];
    [backGroundView addSubview:line4];
    [backGroundView addSubview:line5];
    [backGroundView addSubview:line6];
    
    [backGroundView addSubview:imCl1];
    [backGroundView addSubview:textLab];
    [backGroundView addSubview:imCl2];
    
    self.backGroundView = backGroundView;
    [self.contentView addSubview:backGroundView];
}

- (void)layoutSubviews
{
    self.addBtn.frame = CGRectMake(self.mj_w - 100, 10, 30, 30);
    self.delBtn.frame = CGRectMake(self.mj_w - 50, 10, 30, 30);
    
    self.backGroundView.frame = CGRectMake(0, self.addBtn.mj_y + self.addBtn.mj_h , self.mj_w, 180);
    self.line6.frame = CGRectMake(0, 0, self.mj_w, 1);
    self.proviceLab.frame = CGRectMake(10, 10, 80, 25);
    self.proviceText.frame = CGRectMake(self.proviceLab.mj_x +self.proviceLab.mj_w ,10,  self.mj_w - self.proviceLab.mj_x - self.proviceLab.mj_w - 20, 25);
    self.line1.frame = CGRectMake(10, self.proviceText.mj_h + self.proviceText.mj_y,  self.mj_w - 20, 1);
    
    self.cityLab.frame = CGRectMake(self.proviceLab.mj_x, self.proviceText.mj_h + self.proviceText.mj_y + 10, 80, 25);
    
    self.cityText.frame = CGRectMake(self.cityLab.mj_x +self.cityLab.mj_w, self.cityLab.mj_y, self.mj_w - self.cityLab.mj_x - self.cityLab.mj_w - 20, 25);
    self.line2.frame = CGRectMake(self.line1.mj_x , self.cityText.mj_y + self.cityText.mj_h, self.mj_w - 20, 1);
    
    self.sectionLab.frame = CGRectMake(self.proviceLab.mj_x, self.cityText.mj_h + self.cityText.mj_y + 10, 80, 25);
    
    self.sectionText.frame = CGRectMake(self.sectionLab.mj_x +self.sectionLab.mj_w, self.sectionLab.mj_y , self.mj_w - self.sectionLab.mj_x - self.sectionLab.mj_w - 20, 25);
    self.line3.frame = CGRectMake(self.line1.mj_x , self.sectionText.mj_y + self.sectionText.mj_h, self.mj_w - 20, 1);
    
    self.dateLab.frame = CGRectMake(self.proviceLab.mj_x, self.sectionText.mj_h + self.sectionText.mj_y + 10, 80, 25);
    self.dateText1.frame = CGRectMake(self.dateLab.mj_x +self.dateLab.mj_w, self.dateLab.mj_y, (self.mj_w - self.sectionLab.mj_x - self.sectionLab.mj_w - 80) / 2, 25);
    
    self.imCl1.frame = CGRectMake(self.dateText1.mj_w + self.dateText1.mj_x, self.dateText1.mj_y - 3, 20, 25);
    self.textLab.frame = CGRectMake(self.imCl1.mj_w + self.imCl1.mj_x, self.dateText1.mj_y, 20, 25);
    self.dateText2.frame = CGRectMake(self.textLab.mj_x +self.textLab.mj_w, self.dateLab.mj_y, (self.mj_w - self.sectionLab.mj_x - self.sectionLab.mj_w - 80) / 2, 25);
    self.imCl2.frame = CGRectMake(self.dateText2.mj_w + self.dateText2.mj_x, self.dateText1.mj_y - 3, 20, 25);
    
    
    self.line4.frame = CGRectMake(self.line1.mj_x , self.dateText2.mj_y + self.dateText2.mj_h, self.mj_w - 20, 1);
    
    
    self.branchLab.frame = CGRectMake(self.proviceLab.mj_x, self.dateText2.mj_h + self.dateText2.mj_y + 10, 80, 25);
    
    self.branchText.frame = CGRectMake(self.branchLab.mj_x +self.branchLab.mj_w, self.branchLab.mj_y, self.mj_w - self.branchLab.mj_x - self.branchLab.mj_w - 20, 25);
    self.line5.frame = CGRectMake(0, self.branchLab.mj_y + self.branchLab.mj_h, self.mj_w , 1);
    
}

+ (CareerTableViewCell *)cellWithTableView:(UITableView *)tableview
{
    static NSString *carCellID = @"carCellID";
    CareerTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:carCellID];
    if (nil == cell) {
        cell = [[CareerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carCellID];
        
    }
    return cell;
}

- (void)setInfoModel:(informationModel *)infoModel
{
    if (_infoModel != infoModel)
    {
        _infoModel = infoModel;
        NSLog(@"%@",_infoModel.workEndDate);
    }
}

-(void)doValueChanged:(UITextField *)sender
{
    if (sender.tag == 101)
    {
        _infoModel.provinceName = sender.text;
        for (int i = 0; i < self.proviceArr.count; i ++) {
            placeModel *plp = self.proviceArr[i];
            if ([plp.areaName isEqualToString:sender.text]) {
                
                _infoModel.provinceId = plp.strID;
                NSLog(@"%@ == %@",_infoModel.provinceId ,plp.strID);
            }
        }
    }
    else if(sender.tag == 102)
    {
        _infoModel.cityName = sender.text;
        
        for (int i = 0; i < self.cityArr.count; i ++) {
            placeModel *plp = self.cityArr[i];
            if ([plp.areaName isEqualToString:sender.text]) {
                
                _infoModel.cityId = plp.strID;
                NSLog(@"%@ == %@",_infoModel.cityId ,plp.strID);
            }
        }
    }
    else if(sender.tag == 103)
    {
        _infoModel.organizationName = sender.text;
    }
    else if(sender.tag == 104)
    {
        _infoModel.workStartDate = sender.text;
    }
    else if(sender.tag == 105)
    {
        _infoModel.workEndDate = sender.text;
    }
    else
    {
        _infoModel.position = sender.text;
    }
    
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
    self.textFieldS.text = self.formatterDate;
    [self.textFieldS endEditing:YES];
    
}
- (void)btnQClike
{
    self.textFieldS.text = @"";
    [self.textFieldS endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textFieldS = textField;
    
    //    @"provinceList"
    //    @"cityList"
    //    @"countryList"
    
    SQLiteBase *sqlitePlaceList = [SQLiteBase ShareSQLiteBaseSave];
    NSMutableArray *provinceList = [sqlitePlaceList searchAllDataFromTableName:@"provinceList"] ;
    switch (textField.tag) {
        case 101:
            if (provinceList.count)
            {
                
                self.proviceArr = [NSMutableArray array];
                NSMutableArray *areamArr = [NSMutableArray array];
                for (placeModel *pl in provinceList) {
                    [areamArr addObject:pl.areaName];
                    [self.proviceArr addObject:pl];
                }
                self.arrDataS = areamArr;
                
                [self.pick reloadAllComponents];
                textField.inputView = self.picker;
            }
            else
            {
                // 省
                [sqlitePlaceList deleteAllDataFromTableName:@"provinceList"];
                [[HttpManager defaultManager]postRequestToUrl:DEF_DIQU params:@{@"areaLevel":@(1)} complete:^(BOOL successed, NSDictionary *result) {
                    
                    NSMutableArray *proArr = [NSMutableArray array];
                    for ( NSDictionary *dic  in result[@"objList"]) {
                        placeModel *plcae = [placeModel objectWithKeyValues:dic];
                        [proArr addObject:plcae];
                        [sqlitePlaceList createWithTableName:@"provinceList" withModel:plcae];
                    }
                    
                    //                    [common setProvinceData:proArr];
                }];
                NSMutableArray *provinceList1 = [sqlitePlaceList searchAllDataFromTableName:@"provinceList"] ;
                self.proviceArr = [NSMutableArray array];
                NSMutableArray *areamArr = [NSMutableArray array];
                for (placeModel *pl in provinceList1) {
                    [areamArr addObject:pl.areaName];
                    [self.proviceArr addObject:pl];
                }
                self.arrDataS = areamArr;
                
                [self.pick reloadAllComponents];
                textField.inputView = self.picker;
                
            }
            break;
        case 102:
            self.arrDataS = self.cityAreamArr;
            if ([self.proviceText.text isEqualToString:@""])
            {
                showAlertView(@"请选择所属省份或直辖市");
                textField.inputView = [UIView new];
                break ;
            }
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SQLiteBase *sqliteCityList = [SQLiteBase ShareSQLiteBaseSave];
    NSMutableArray *cityList = [[sqliteCityList searchAllDataFromTableName:@"cityList"] copy];
    switch (textField.tag) {
        case 101:
            if (cityList.count)
            {
                for (placeModel *plp in self.proviceArr)
                {
                    
                    
                    if ([textField.text isEqualToString:plp.areaName])
                    {
                        self.cityArr = [NSMutableArray array];
                        self.cityAreamArr = [NSMutableArray array];
                        NSMutableArray *areamArr = [NSMutableArray array];
                        for (placeModel *plc in cityList)
                        {
                            if ([plp.strID isEqualToString:plc.parentId])
                            {
                                [self.cityArr addObject:plc];
                                [areamArr addObject:plc.areaName];
                                [self.cityAreamArr addObject:plc.areaName];
                            }
                        }
                        
                        self.arrDataS = areamArr;
                    }
                }
                
            }
            else
            {
                for (placeModel *plp in self.proviceArr)
                {
                    
                    
                    if ([textField.text isEqualToString:plp.areaName])
                    {
                        NSMutableArray *areamArr = [NSMutableArray array];
                        self.cityArr = [NSMutableArray array];
                        self.cityAreamArr = [NSMutableArray array];
                        // 市
                        [[HttpManager defaultManager]postRequestToUrl:DEF_DIQU params:@{@"areaLevel":@(2),@"parentId":plp.strID} complete:^(BOOL successed, NSDictionary *result) {
                            
                            for ( NSDictionary *dic  in result[@"objList"]) {
                                placeModel *plcae = [placeModel objectWithKeyValues:dic];
                                [self.cityArr addObject:plcae];
                                [areamArr addObject:plcae.areaName];
                                [self.cityAreamArr addObject:plcae.areaName];
                            }
                            self.arrDataS = areamArr;
                        }];
                    }
                }
            }
            break;
            
        default:
            break;
    }
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
