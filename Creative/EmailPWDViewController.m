//
//  EmailPWDViewController.m
//  Creative
//
//  Created by Mr Wei on 15/12/30.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "EmailPWDViewController.h"
#import "Model.h"
#import "common.h"
#import "placeModel.h"
#import "SQLiteBase.h"

#define hPickViewHeight 200

@interface EmailPWDViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UITextField *pwdText;

@property (weak, nonatomic) IBOutlet UITextField *checkPwdText;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIImageView *checkNameIm;
@property (weak, nonatomic) IBOutlet UIImageView *checkEmailIm;

@property (weak, nonatomic) IBOutlet UITextField *proviceText;

@property (weak, nonatomic) IBOutlet UITextField *cityText;


@property (nonatomic , assign) BOOL YNname;
@property (nonatomic , assign) BOOL YNemail;


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

@implementation EmailPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sureBtn.layer.borderColor = COMColor(74, 189, 50, 1.0).CGColor;
    self.sureBtn.clipsToBounds = YES;
    self.sureBtn.layer.borderWidth = 1.0;
    self.sureBtn.layer.cornerRadius = 4;
    self.checkNameIm.hidden = YES;
    self.checkEmailIm.hidden = YES;
    self.nickNameText.tag = 101;
    self.nickNameText.delegate = self;
    self.emailText.tag = 102;
    self.emailText.delegate = self;
    self.pwdText.tag = 103;
    self.pwdText.delegate = self;
    self.checkPwdText.tag = 104;
    self.checkPwdText.delegate = self;
    
    self.proviceText.tag = 105;
    self.proviceText.delegate = self;
    self.cityText.tag = 106;
    self.cityText.delegate = self;
    
    
    self.YNemail = NO;
    self.YNname  = NO;
}
- (IBAction)nextAction:(id)sender
{
    self.sureBtn.enabled = NO;
    if ([self.nickNameText.text isEqualToString:@""]) {
        showAlertView(@"昵称不能为空");
        self.sureBtn.enabled = YES;
        return;
    }
    
    if ([self.emailText.text isEqualToString:@""]) {
        showAlertView(@"邮箱不能为空");
        self.sureBtn.enabled = YES;
        return;
    }
    BOOL isOk =[Model validateEmail:self.emailText.text];
    if (isOk==NO)
    {
        showAlertView(@"邮箱格式不正确");
        self.sureBtn.enabled = YES;
        return;
    }
    if (self.pwdText.text == nil ||self.pwdText.text.length < 6)
    {
        showAlertView(@"密码不能小于6位");
        self.sureBtn.enabled = YES;
        return;
    }
    else if (![self.checkPwdText.text isEqualToString:self.pwdText.text])
    {
        showAlertView(@"密码不一致");
        self.sureBtn.enabled = YES;
        return;
    }
    WEAKSELF;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.proviceArr.count; i++)
    {
        placeModel *plpr = self.proviceArr[i];
        if ([self.proviceText.text isEqualToString:plpr.areaName] )
        {
            [dic setObject:plpr.strID forKey:@"provinceId"];
            
        }
        
    }
    [dic setObject:self.proviceText.text forKey:@"provinceName"];
    
    for (int i = 0; i < self.cityArr.count; i++)
    {
        placeModel *plp = self.cityArr[i];
        if ([self.cityText.text isEqualToString:plp.areaName] )
        {
            [dic setObject:plp.strID forKey:@"cityId"];
            
        }
        
    }
    [dic setObject:self.cityText.text forKey:@"cityName"];
    [dic setObject:self.nickNameText.text forKey:@"loginName"];
    [dic setObject:self.emailText.text forKey:@"email"];
    [dic setObject:self.usePhoneNum forKey:@"phoneNumber"];
    [dic setObject:self.checkPwdText.text forKey:@"password"];
    [dic setObject:@"personal" forKey:@"role"];
    if (self.YNname && self.YNemail)
    {
        [[HttpManager defaultManager] postRequestToUrl:DEF_REGISTER params:dic complete:^(BOOL successed, NSDictionary *result)
        {
            self.sureBtn.enabled = YES;
            if ([result isKindOfClass:[NSDictionary class]])
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    showAlertView(@"注册成功");
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }
                else
                {
                    showAlertView(result[@"msg"]);
                }
            }
        }];
    }
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
    NSLog(@"%ld",(unsigned long)provinceList.count);
    switch (textField.tag) {
        case 105:
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
            
        case 106:
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
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    BOOL emailYN = NO;
    BOOL nameYN  = NO;
    BOOL skipYN = NO;
    switch (textField.tag) {
        case 101:
            if ([self.nickNameText.text isEqualToString:@""]) {
                showAlertView(@"昵称不能为空");
                return;
            }
            [dic setObject:self.nickNameText.text forKey:@"loginName"];
            emailYN = NO;
            nameYN  = YES;
            skipYN = NO;
            break;
        case 102:
            if ([self.emailText.text isEqualToString:@""])
            {
                showAlertView(@"邮箱不能为空");
                return;
            }
            BOOL isOk =[Model validateEmail:self.emailText.text];
            if (isOk==NO)
            {
                showAlertView(@"邮箱格式不正确");
                return;
            }
            [dic setObject:self.emailText.text forKey:@"email"];
            emailYN = YES;
            nameYN  = NO;
            skipYN = NO;
            break;
        case 103:
            //
            skipYN = YES;
            break;
            
        case 105:
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
            skipYN = YES;
            break;

            
        default:
            skipYN = YES;
            break;
    }
    
    if (skipYN)
    {
        
    }
    else
    {
        [[HttpManager defaultManager] postRequestToUrl:DEF_VALIDATION params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if ([result isKindOfClass:[NSDictionary class]]) {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    if (nameYN) {
                        //
                        self.YNname = YES;
                        self.checkNameIm.hidden = NO;
                    }
                    if (emailYN) {
                        //
                        self.YNemail = YES;
                        self.checkEmailIm.hidden = NO;
                    }
                }
                else if ([result[@"code"] isEqualToString:@"10001"])
                {
                    if (nameYN) {
                        showAlertView(result[@"msg"]);
                        self.YNname = NO;
                        self.checkNameIm.hidden = YES;
                    }
                    if (emailYN) {
                        showAlertView(result[@"msg"]);
                        self.YNemail = NO;
                        self.checkEmailIm.hidden = YES;
                    }
                }
                else
                {
                    
                }
            }
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerFirstRespond:(id)sender
{
    
    [self.nickNameText resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    [self.checkPwdText resignFirstResponder];
    [self.proviceText resignFirstResponder];
    [self.cityText resignFirstResponder];
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
