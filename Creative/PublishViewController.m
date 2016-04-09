//
//  PublishViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//********* 发布需求  **************

#import "PublishViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "Model.h"
#import "SQLiteBase.h"
#import "placeModel.h"

#define hPickViewHeight 200

@interface PublishViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic , strong) UITextField *provinceText;
@property (nonatomic , strong) UITextField *cityText;
@property (nonatomic , strong) UITextField *dayNum;
@property (nonatomic , strong) UITextField *typeText;
@property (nonatomic , strong) UITextField *moneyNum;
@property (nonatomic , strong) UITextField *personNum;
@property (nonatomic , strong) UITextField *contactText;
@property (nonatomic , strong) UITextField *phoneNum;

@property (nonatomic , strong) NSArray *participantNumArr; // 参加会议人数
@property (nonatomic , strong) NSArray *meetingTimeArr; // 会议时间
@property (nonatomic , strong) NSArray *meetingTypeArr; //会议类型

@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;
@property(nonatomic,copy)NSString *strPicker;
@property(nonatomic,strong)UIView *picker;
@property(nonatomic,strong)UIPickerView *pick;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSArray *arrDataS;
@property (nonatomic , strong) NSMutableArray *proviceArr;
@property (nonatomic , strong) NSMutableArray *cityArr;
@property (nonatomic , strong) NSMutableArray *cityAreamArr;

@end

@implementation PublishViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"立刻询价";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(alterAction) withTitle:@"发布"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h )];
    sc.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 600)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *citLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.mj_w - 20, 30)];
    citLab.text =  @"* 活动城市";
    [titleView addSubview:citLab];
    
    UITextField *provinceText = [[UITextField alloc]initWithFrame:CGRectMake(10, citLab.mj_h + citLab.mj_y, (self.view.mj_w - 40) / 2, 30)];
    provinceText.placeholder = @"-- 省 --";
    provinceText.delegate = self;
    provinceText.tag = 101;
    provinceText.layer.masksToBounds = YES;
    provinceText.clipsToBounds = YES;
    provinceText.layer.borderColor = [UIColor blackColor].CGColor;
    self.provinceText = provinceText;
    [titleView addSubview:provinceText];
    
    UITextField *cityText = [[UITextField alloc]initWithFrame:CGRectMake(provinceText.mj_x + provinceText.mj_w + 20, citLab.mj_h + citLab.mj_y, (self.view.mj_w - 40) / 2, 30)];
    cityText.placeholder = @"-- 市 --";
    cityText.delegate = self;
    cityText.tag = 102;
    cityText.layer.masksToBounds = YES;
    cityText.clipsToBounds = YES;
    cityText.layer.borderColor = [UIColor blackColor].CGColor;
    self.cityText = cityText;
    [titleView addSubview:cityText];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(provinceText.mj_x, provinceText.mj_y + provinceText.mj_h, provinceText.mj_w, 1)];
    line.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line];
    
    UIView *lineFU = [[UIView alloc]initWithFrame:CGRectMake(provinceText.mj_x + provinceText.mj_w + 20, provinceText.mj_y + provinceText.mj_h, provinceText.mj_w, 1)];
    lineFU.backgroundColor = [UIColor grayColor];
    [titleView addSubview:lineFU];
    
    UILabel *dayLab = [[UILabel alloc]initWithFrame:CGRectMake(provinceText.mj_x, provinceText.mj_y + provinceText.mj_h + 15, 100, 30)];
    dayLab.text = @"* 会议时长：";
    [titleView addSubview:dayLab];
    
    UITextField *dayNum = [[UITextField alloc]initWithFrame:CGRectMake(dayLab.mj_x + dayLab.mj_w, provinceText.mj_y + provinceText.mj_h + 15, self.view.mj_w - 120, 30)];
    dayNum.placeholder = @"-- 请选择 --";
    dayNum.delegate = self;
    dayNum.tag = 103;
    dayNum.layer.masksToBounds = YES;
    dayNum.clipsToBounds = YES;
    dayNum.layer.borderColor = [UIColor blackColor].CGColor;
    self.dayNum = dayNum;
    [titleView addSubview:dayNum];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(dayLab.mj_x + dayLab.mj_w, dayNum.mj_y + dayNum.mj_h, self.view.mj_w - 120, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line1];
    
    UILabel *typeLab = [[UILabel alloc]initWithFrame:CGRectMake(provinceText.mj_x, dayNum.mj_y + dayNum.mj_h + 15, 100, 30)];
    typeLab.text = @"* 会议类型：";
    [titleView addSubview:typeLab];
    
    UITextField *typeText = [[UITextField alloc]initWithFrame:CGRectMake(typeLab.mj_x + typeLab.mj_w, dayNum.mj_y + dayNum.mj_h + 15, self.view.mj_w - 20, 30)];
    typeText.placeholder = @"-- 请选择 --";
    typeText.delegate = self;
    typeText.tag = 104;
    typeText.layer.masksToBounds = YES;
    typeText.clipsToBounds = YES;
    typeText.layer.borderColor = [UIColor blackColor].CGColor;
    self.typeText = typeText;
    [titleView addSubview:typeText];
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(typeLab.mj_x + typeLab.mj_w, typeText.mj_y + typeText.mj_h, self.view.mj_w - 120, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line2];
    
    UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(provinceText.mj_x, typeText.mj_y + typeText.mj_h + 15, 100, 30)];
    moneyLab.text =  @"* 会议预算：";
    [titleView addSubview:moneyLab];
    
    UITextField *moneyNum = [[UITextField alloc]initWithFrame:CGRectMake(moneyLab.mj_x + moneyLab.mj_w, typeText.mj_y + typeText.mj_h + 15 , self.view.mj_w - 150, 30)];
    moneyNum.placeholder = @"金额";
    moneyNum.delegate = self;
    moneyNum.tag = 105;
    moneyNum.layer.masksToBounds = YES;
    moneyNum.clipsToBounds = YES;
    moneyNum.layer.borderColor = [UIColor blackColor].CGColor;
    self.moneyNum = moneyNum;
    [titleView addSubview:moneyNum];
    
    UILabel *yuanLab = [[UILabel alloc]initWithFrame:CGRectMake(moneyNum.mj_x + moneyNum.mj_w, typeText.mj_y + typeText.mj_h + 15 , 30, 30)];
    yuanLab.text = @"元";
    [titleView addSubview:yuanLab];
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(moneyLab.mj_x + moneyLab.mj_w, moneyNum.mj_y + moneyNum.mj_h, self.view.mj_w - 120, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line3];
    
    UILabel *personLab = [[UILabel alloc]initWithFrame:CGRectMake(provinceText.mj_x, moneyNum.mj_y + moneyNum.mj_h + 15, 100, 30)];
    personLab.text = @"* 参加人数：";
    [titleView addSubview:personLab];
    
    UITextField *personNum = [[UITextField alloc]initWithFrame:CGRectMake(personLab.mj_x + personLab.mj_w, moneyNum.mj_y + moneyNum.mj_h + 15 , self.view.mj_w - 150, 30)];
    personNum.placeholder = @"-- 请选择 --";
    personNum.delegate = self;
    personNum.tag = 106;
    personNum.layer.masksToBounds = YES;
    personNum.clipsToBounds = YES;
    personNum.layer.borderColor = [UIColor blackColor].CGColor;
    [titleView addSubview:personNum];
    self.personNum = personNum;
    
    UILabel *renLab = [[UILabel alloc]initWithFrame:CGRectMake(personNum.mj_x + personNum.mj_w, moneyNum.mj_y + moneyNum.mj_h + 15 , 30, 30)];
    renLab.text = @"人";
    [titleView addSubview:renLab];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(personLab.mj_x + personLab.mj_w, personNum.mj_y + personNum.mj_h, self.view.mj_w - 120, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line4];
    
    UILabel *contactLab = [[UILabel alloc]initWithFrame:CGRectMake(provinceText.mj_x, personNum.mj_y + personNum.mj_h + 15, 100, 30)];
    contactLab.text = @"* 联系人：";
    [titleView addSubview:contactLab];
    
    UITextField *contactText = [[UITextField alloc]initWithFrame:CGRectMake(contactLab.mj_x + contactLab.mj_w, personNum.mj_y + personNum.mj_h + 15, self.view.mj_w - 120, 30)];
    contactText.placeholder = @"联系人";
    contactText.delegate = self;
    contactText.tag = 107;
    contactText.layer.masksToBounds = YES;
    contactText.clipsToBounds = YES;
    contactText.layer.borderColor = [UIColor blackColor].CGColor;
    [titleView addSubview:contactText];
    self.contactText = contactText;
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(contactLab.mj_x + contactLab.mj_w, contactText.mj_y + contactText.mj_h, self.view.mj_w - 120, 1)];
    line5.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line5];
    
    UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(provinceText.mj_x, contactText.mj_y + contactText.mj_h + 15, 100, 30)];
    phoneLab.text = @"* 手机：";
    [titleView addSubview:phoneLab];
    
    UITextField *phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(phoneLab.mj_x + phoneLab.mj_w, contactText.mj_y + contactText.mj_h + 15, self.view.mj_w - 120, 30)];
    phoneNum.placeholder = @"手机号";
    phoneNum.delegate = self;
    phoneNum.tag = 108;
    phoneNum.layer.masksToBounds = YES;
    phoneNum.clipsToBounds = YES;
    phoneNum.layer.borderColor = [UIColor blackColor].CGColor;
    [titleView addSubview:phoneNum];
    self.phoneNum = phoneNum;
    
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(phoneLab.mj_x + phoneLab.mj_w, phoneNum.mj_y + phoneNum.mj_h, self.view.mj_w - 120, 1)];
    line6.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line6];
    
    [sc addSubview:titleView];
    [self.view addSubview:sc];
    
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 350);
    self.sc = sc;
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 * 发布
 */
- (void)alterAction
{
    if ([self.provinceText.text isEqualToString:@""]) {
        showAlertView(@"省份不能为空");
        return;
    }
    if ([self.cityText.text isEqualToString:@""]) {
        showAlertView(@"省份不能为空");
        return;
    }
    if ([self.dayNum.text isEqualToString:@""]) {
        showAlertView(@"会议时长不能为空");
        return;
    }
    if ([self.typeText.text isEqualToString:@""]) {
        showAlertView(@"会议类型不能为空");
        return;
    }
    
    if ([self.moneyNum.text isEqualToString:@""]) {
        showAlertView(@"预算金额不能为空");
        return;
    }
    if ([self.personNum.text isEqualToString:@""]) {
        showAlertView(@"参加会议人数不能为空");
        return;
    }
    
    if ([self.contactText.text isEqualToString:@""]) {
        showAlertView(@"联系人不能为空");
        return;
    }
    if ([self.phoneNum.text isEqualToString:@""]) {
        showAlertView(@"手机号不能为空");
        return;
    }
    BOOL isOk =[Model checkInputMobile:self.phoneNum.text];
    if (isOk==NO)
    {
        showAlertView(@"手机号格式不正确");
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"flag"];
    for (int i = 0; i < self.cityArr.count; i++)
    {
        placeModel *plp = self.cityArr[i];
        if ([self.cityText.text isEqualToString:plp.areaName] )
        {
            [dic setObject:plp.strID forKey:@"cityId"];
            
        }
        
    }
    [dic setObject:self.cityText.text forKey:@"cityName"];
    for (int i = 0;i < self.participantNumArr.count; i ++) {
        if ([self.personNum.text isEqualToString:self.participantNumArr[i]])
        {
            NSString *strI = [NSString stringWithFormat:@"%d",i];
            [dic setObject:strI forKey:@"meetingTime"];
        }
    }
    
    [dic setObject:self.moneyNum.text forKey:@"meetingBudget"];
    
    
    
    for (int i = 0;i < self.meetingTimeArr.count; i ++) {
        if ([self.dayNum.text isEqualToString:self.meetingTimeArr[i]])
        {
            NSString *strI = [NSString stringWithFormat:@"%d",i];
            [dic setObject:strI forKey:@"meetingTime"];
        }
    }
    
    for (int i = 0; i < self.meetingTypeArr.count; i ++) {
        if ([self.typeText.text isEqualToString:self.meetingTypeArr[i]])
        {
            NSString *strI = [NSString stringWithFormat:@"%d",i];
            [dic setObject:strI forKey:@"meetingType"];
        }
    }
    
    for (int i = 0; i < self.participantNumArr.count; i ++)
    {
        NSString *strI = [NSString stringWithFormat:@"%d",i];
        [dic setObject:strI forKey:@"participantNum"];
    }
    [dic setObject:self.contactText.text forKey:@"linkman"];
    [dic setObject:self.phoneNum.text forKey:@"phoneNumber"];
    
    
    [[HttpManager defaultManager] postRequestToUrl:DEF_PLACEREQUIRE params:dic complete:^(BOOL successed, NSDictionary *result) {
        //
        //        NSLog(@"%@",result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (result[@"code"]) {
                showAlertView(@"场地需求发布成功");
            }
            else
            {
                showAlertView(@"场地需求发布失败");
            }
        }
        else
        {
            showAlertView(@"场地需求发布失败");
        }
        
    }];
    
}

- (NSArray *)participantNumArr
{
    if (!_participantNumArr) {
        _participantNumArr = @[@"10~30",@"30~60",@"60~100",@"100~200",@"200~300",@"300~500",@"500+"];
        //        0:10~30;1:30~60;2:60~100;3:100~200;4:200~300;5:300~500;6:500+
    }
    return _participantNumArr;
}

- (NSArray *)meetingTimeArr
{
    if (!_meetingTimeArr) {
        _meetingTimeArr = @[@"一晚",@"半天",@"一天",@"两天",@"3~4天",@"5~7天",@"7~14天",@"14天以上"];
        //        0:一晚;1:半天;2:一天;3:两天;4:3~4天;5:5~7天;6:7~14天；7:14天以上
    }
    return _meetingTimeArr;
}

- (NSArray *)meetingTypeArr
{
    if (!_meetingTypeArr) {
        _meetingTypeArr = @[@"培训/讲座",@"工作会/总结会",@"团队建设/拓展/休闲会议",@"公司年会",@"研讨/交流/论坛",@"同学会/好友聚会",@"经销商会议/招商会/推介会",@"答谢会",@"发布会/颁奖/庆典"];
        //        0：培训/讲座；1:工作会/总结会；2：团队建设/拓展/休闲会议；3：公司年会；4：研讨/交流/论坛；5：同学会/好友聚会；6：经销商会议/招商会/推介会；7:答谢会；8：发布会/颁奖/庆典
    }
    return _meetingTypeArr;
}

- (void)keyboardShow:(NSNotification *)not
{
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
    if (ff.height < self.scHeight + keyboardH) {
        ff.height += keyboardH;
        self.sc.contentSize = ff;
    }
    
}
- (void)keyboardHide:(NSNotification *)not
{
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
    ff.height -= keyboardH;
    self.sc.contentSize = ff;
    
}

#pragma mark - textField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textField = textField;
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
            if ([self.provinceText.text isEqualToString:@""])
            {
                showAlertView(@"请选择所属省份或直辖市");
                textField.inputView = [UIView new];
                break ;
            }
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            break;
            
        case 103:
            self.arrDataS = self.meetingTimeArr;
            
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            break;
            
        case 104:
            
            self.arrDataS = self.meetingTypeArr;
            
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            break;
            
        case 106:
            
            self.arrDataS = self.participantNumArr;
            
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
                            
                            ;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _picker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, 200)];
        _picker.backgroundColor = [UIColor lightGrayColor];
        UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, hPickViewHeight)];
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
        
        UIButton *btnC = [[UIButton alloc] initWithFrame:CGRectMake(self.view.mj_w - 65, 4, 60, 30)];
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
    [self.textField endEditing:YES];
    
}
- (void)btnOK
{
    self.textField.text = self.strPicker;
    [self.textField endEditing:YES];
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
