//
//  TenderViewController.m
//  ceshi
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import "TenderViewController.h"
#import "UIView+MJExtension.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#define ImgH    30
#define Height  50


@interface TenderViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITextField *moneyText;
    UITextField *dayText;
    UITextView *contentText;
}
@property (nonatomic , strong) UIButton *placeMsgBtn;
@property (nonatomic , strong) UIButton *adjunctBtn;

@property(nonatomic,weak)UIScrollView *sc;
@property (nonatomic , strong) UIView *introduceView;
@property (nonatomic , strong) UITextField *proText;

@property (nonatomic , strong) UITextField *cityText;
@property (nonatomic , strong) UITextField *addressText;
@property(nonatomic,copy)NSString *provinceId;
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

@implementation TenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(finishClick) title:@"提交"];
    self.title = @"我要投标";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self searchMesage];
    [self creatView];
}
- (void)finishClick
{
    if ([moneyText.text isEqualToString:@""]) {
        showAlertView(@"报价金额不能为空");
        return;
    }
    if ([dayText.text isEqualToString:@""]) {
        showAlertView(@"工作周期不能为空");
        return;
    }
    if ([self.proText.text isEqualToString:@""]) {
        showAlertView(@"省份不能为空");
        return;
    }
    if ([self.cityText.text isEqualToString:@""]) {
        showAlertView(@"城市不能为空");
        return;
    }
    self.objct.provinceId =[ common checkStrValue:self.provinceId];
    self.objct.provinceName = [common checkStrValue:self.proText.text];
       self.objct.cityName = [common checkStrValue:self.cityText.text];
    self.objct.address = [common checkStrValue:self.addressText.text];

    for (int i = 0; i < self.cityArr.count; i++)
    {
        placeModel *plp = self.cityArr[i];
        if ([self.cityText.text isEqualToString:plp.areaName] )
        {
            self.objct.cityId =[ common checkStrValue:plp.strID];
        }
        
    }
    // ,@"attachment":@"" 暂时不传
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_XIANGMUTOUBIAO params:@{@"engineeringId":self.objct.roadId,@"offerMoney":moneyText.text,@"workDuration":dayText.text,@"provinceId":self.objct.provinceId,@"provinceName":self.objct.provinceName,@"cityId":self.objct.cityId,@"cityName":self.objct.cityName,@"address":self.objct.address,@"description":contentText.text} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            [weakSelf back];
            
        }
    }];
}
- (void)searchMesage
{
//    [MHNetworkManager postReqeustWithURL:DEF_XMCHAXUNTOUBIAO params:@{@"id":self.objct.roadId} successBlock:^(NSDictionary *returnData) {
//    } failureBlock:^(NSError *error) {
//        
//    } showHUD:YES];
}
- (void)creatView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h )];
    sc.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *returnTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnKeyBoard)];
    [sc addGestureRecognizer:returnTap];
    
    moneyText =[[UITextField alloc]initWithFrame:CGRectMake(10, 80, self.view.mj_w - 40, 30)];
    moneyText.placeholder = @"报价金额";
    moneyText.delegate = self;
    moneyText.keyboardType = UIKeyboardTypeNumberPad;
    moneyText.returnKeyType = UIReturnKeyDone;
    [sc addSubview:moneyText];
    
    UILabel *yuanLab = [[UILabel alloc]initWithFrame:CGRectMake(moneyText.mj_w + moneyText.mj_x, moneyText.mj_y, 30, 30)];
    yuanLab.text = @"元";
    [sc addSubview:yuanLab];
    
    dayText =[[UITextField alloc]initWithFrame:CGRectMake(10,  moneyText.mj_y +  moneyText.mj_h + 20, self.view.mj_w - 40, 30)];
    dayText.placeholder = @"工作周期";
    dayText.delegate = self;
    dayText.keyboardType = UIKeyboardTypeNumberPad;// UIKeyboardTypePhonePad;
    dayText.returnKeyType = UIReturnKeyDone;
    [sc addSubview:dayText];
    
    UILabel *dayLab = [[UILabel alloc]initWithFrame:CGRectMake(dayText.mj_w + dayText.mj_x, dayText.mj_y, 30, 30)];
    dayLab.text = @"天";
    [sc addSubview:dayLab];
    
    //    UIView *place = [[UIView alloc]initWithFrame:CGRectMake(10,  dayLab.mj_y +  dayLab.mj_h + 20, self.view.mj_w - 20, 30)];
    //    place.backgroundColor = [UIColor grayColor];
    //    [sc addSubview:place];
    
    [sc addSubview:[self createViewWithFrame:CGRectMake(0, dayText.mj_h + dayText.mj_y + 10, self.view.mj_w , Height) withIcon:@"g (2)" withTitle:@"所在地区"]];
    
    self.placeMsgBtn = [self createBtnWithFrame:CGRectMake(0,dayText.mj_h + dayText.mj_y + 10, self.view.mj_w , Height) wihtAction:@selector(placeMsgBtnAction:) andTarget:self];
    [sc addSubview:self.placeMsgBtn];
    
    UITextField *proText = [[UITextField alloc]initWithFrame:CGRectMake(10,self.placeMsgBtn.mj_y + self.placeMsgBtn.mj_h + 10, (self.view.mj_w - 40)/2, 25)];
    proText.adjustsFontSizeToFitWidth = YES;
    proText.font = [UIFont systemFontOfSize:14.0];
    proText.textColor = [UIColor grayColor];
    proText.placeholder = @"- 省 -";
    proText.tag = 103;
    proText.borderStyle = UITextBorderStyleRoundedRect;
    proText.delegate = self;
    [sc addSubview:proText];
    self.proText = proText;
    
    UITextField *cityText = [[UITextField alloc]initWithFrame:CGRectMake(proText.mj_x + proText.mj_w + 20,self.placeMsgBtn.mj_y + self.placeMsgBtn.mj_h + 10, (self.view.mj_w - 40)/2, 25)];
    cityText.adjustsFontSizeToFitWidth = YES;
    cityText.font = [UIFont systemFontOfSize:14.0];
    cityText.textColor = [UIColor grayColor];
    cityText.placeholder = @"- 市 -";
    cityText.tag = 104;
    cityText.borderStyle = UITextBorderStyleRoundedRect;
    cityText.delegate = self;
    [sc addSubview:cityText];
    self.cityText = cityText;
    
    UITextField *addressText = [[UITextField alloc]initWithFrame:CGRectMake(proText.mj_x ,self.proText.mj_y + self.proText.mj_h + 10, self.view.mj_w - 20, 25)];
    addressText.adjustsFontSizeToFitWidth = YES;
    addressText.font = [UIFont systemFontOfSize:14.0];
    addressText.textColor = [UIColor grayColor];
    addressText.placeholder = @"请输入详细地址";
    addressText.delegate = self;
    [sc addSubview:addressText];
    self.addressText = addressText;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, addressText.mj_h + addressText.mj_y, self.view.mj_w - 20, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [sc addSubview:line];
    
    
    
    UIView *introduceView = [[UIView alloc]initWithFrame:CGRectMake(0,addressText.mj_y + addressText.mj_h + 50, self.view.mj_w , 120)];
    introduceView.backgroundColor = [UIColor whiteColor];
    
    UILabel *introduceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.mj_w / 2, 20)];
    introduceLab.text = @"报价说明";
    introduceLab.font = [UIFont systemFontOfSize:16.0f];
    introduceLab.textColor = [UIColor blackColor];
    
    [introduceView addSubview:introduceLab];
    
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setFrame:CGRectMake(self.view.mj_w - 45, 0, 20, 20)];
    //    delBtn.backgroundColor = [UIColor redColor];
    [delBtn setBackgroundImage:[UIImage imageNamed:@"delet"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [introduceView addSubview:delBtn];
    
    contentText = [[UITextView alloc]initWithFrame:CGRectMake(10, delBtn.mj_y + delBtn.mj_h + 10, self.view.mj_w - 20, 80)];
    contentText.backgroundColor = [UIColor whiteColor];
    contentText.layer.borderWidth = 1.0;
    contentText.layer.borderColor = [UIColor grayColor].CGColor;
    contentText.layer.masksToBounds = YES;
    contentText.layer.cornerRadius = 4.0;
    contentText.font = [UIFont systemFontOfSize:17.0];
    [introduceView addSubview:contentText];
    
    [sc addSubview:introduceView];
    self.introduceView = introduceView;
    
    
    
    //    [sc addSubview:[self createViewWithFrame:CGRectMake(0, contentText.mj_h + contentText.mj_y + 10, self.view.mj_w , Height) withIcon:@"g (3)" withTitle:@"上传附件"]];
    
    
    //    self.adjunctBtn = [self createBtnWithFrame:CGRectMake(0,contentText.mj_h + contentText.mj_y + 10, self.view.mj_w , Height) wihtAction:@selector(adjunctBtnAction:) andTarget:self];
    //    [sc addSubview:self.adjunctBtn];
    
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 100);
    self.sc = sc;
    [self.view addSubview:sc];
}

- (void)returnKeyBoard
{
    [moneyText resignFirstResponder];
    [dayText resignFirstResponder];
    [contentText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)delBtnAction:(UIButton *)sender
{
    //    [sender.superview removeFromSuperview];
    contentText.text = @"";
}
- (void)placeMsgBtnAction:(UIButton *)sender
{
    
}

- (void)adjunctBtnAction:(UIButton *)sender
{
    
}

- (UIButton *)createBtnWithFrame:(CGRect)frame wihtAction:(SEL)action andTarget:(id)target
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
    
}
- (UIView *)createViewWithFrame:(CGRect)frame withIcon:(NSString *)icon withTitle:(NSString *)title
{
    
    UIView *views = [[UIView alloc] initWithFrame:frame];
    views.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *icone = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, ImgH, ImgH)];
//    icone.image = [UIImage imageNamed:icon];
    
    UIImageView *ims = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.mj_w - 23, 19.5, 7, 11)];
    ims.image = [UIImage imageNamed:icon];//@"arrow"
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, Height - 1, self.view.mj_w - 20, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(13, 15, self.view.mj_w - 100, 20)];
    lblText.text = title;
    lblText.font = [UIFont systemFontOfSize:16.0f];
    lblText.textColor = [UIColor blackColor];
    
//    [views addSubview:icone];
    [views addSubview:ims];
    [views addSubview:line];
    [views addSubview:lblText];
    return views;
    
    
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

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        case 103:
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
        case 104:
            self.arrDataS = self.cityAreamArr;
            if ([self.proText.text isEqualToString:@""])
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
        case 103:
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
                                self.provinceId = plc.parentId;
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
        UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, 200)];
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
