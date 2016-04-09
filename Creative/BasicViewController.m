//
//  BasicViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "BasicViewController.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "User.h"
#import "Model.h"
#import "EducationViewController.h"

#define YNBOOL YES;
#define NYBOOL NO;
/// pickview 的高度
#define hPickViewHeight 200

@interface BasicViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>

@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;


@property (nonatomic , strong) UIView *detaTileView;
@property (nonatomic , strong) UILabel *placeLab;
@property (nonatomic , strong) UITextField *placeText;
@property (nonatomic , strong) UITextField *placeText1;
@property (nonatomic , strong) UILabel *nameLab;
@property (nonatomic , strong) UITextField *NameText;
@property (nonatomic , strong) UILabel *emailLab;
@property (nonatomic , strong) UITextField *EmailText;
@property (nonatomic , strong) UILabel *sexLab;
@property (nonatomic , strong) UITextField *sexText;
@property (nonatomic , strong) UILabel *IDLab;
@property (nonatomic , strong) UITextField *IDText;
@property (nonatomic , strong) UILabel *realNameLab;
@property (nonatomic , strong) UITextField *realNameText;
@property (nonatomic , strong) UILabel *birthdayLab;
@property (nonatomic , strong) UITextField *birthdayText;
@property (nonatomic , strong) UIView *detaSecondView;
@property (nonatomic , strong) UILabel *QQLab;
@property (nonatomic , strong) UITextField *QQText;
@property (nonatomic , strong) UILabel *weiLab;
@property (nonatomic , strong) UITextField *weiText;
@property (nonatomic , strong) UIView *detaThirdView;
@property (nonatomic , strong) UILabel *guildLab;
@property (nonatomic , strong) UITextField *guildText;
@property (nonatomic , strong) UILabel *adeptLab;
@property (nonatomic , strong) UITextView *adeptText;
@property (nonatomic , strong) UILabel *wordLab;
@property (nonatomic , strong) UITextView *wordText;
@property (nonatomic , strong) UILabel *briefLab;
@property (nonatomic , strong) UITextView *briefText;
@property (nonatomic , strong) UIButton *nextBtn;
@property (nonatomic , strong) UIButton *comNextBtn;


@property(nonatomic,strong)UIView *datePut;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSArray *arrDataS;
@property(nonatomic,strong)UIView *picker;
@property(nonatomic,strong)UIPickerView *pick;
@property(nonatomic,copy)NSString *strPicker;
@property(nonatomic,copy)NSString *formatterDate;

@property (nonatomic , strong)  NSMutableArray *cityList;
@property (nonatomic , strong) NSMutableArray *proviceArr;
@property (nonatomic , strong) NSMutableArray *cityArr;
@property (nonatomic , strong) NSMutableArray *cityAreamArr;


@property (nonatomic , strong) NSArray *sexArr; // 性别
@property (nonatomic , strong) NSArray *identityArr; // 身份
@property (nonatomic , strong) NSArray *hangArr; //   行业

@property (nonatomic , strong) MBProgressHUD *hud;
@property (nonatomic , strong) User *user;

@property (nonatomic , strong) UIView *grayView2;
@property (nonatomic , strong) UIView *line8;
@property (nonatomic , strong) UIView *line10;
@property (nonatomic , strong) UIView *line11;

@property (nonatomic , strong) UIView *btnView;



@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"基本信息";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(alterAction) withTitle:@"提交"];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.hud = [common createHud];
    
    
    [self loadServeData];
}

- (void)loadServeData
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_GERENXINXI params:@{@"id":DEF_USERID} complete:^(BOOL successed, NSDictionary *result)
     {
         if ([result isKindOfClass:[NSDictionary class]])
         {
             if ([result[@"code"] isEqualToString:@"10000"])
             {
                 User *user = [User objectWithKeyValues:result[@"obj"]];
                 weakSelf.user = user;
                 
             }
         }
         
         [weakSelf.hud hide:YES];
         [weakSelf initView];
     }];
}

- (void)returnKeyBoard
{
    [self.textField resignFirstResponder];
    [self.briefText resignFirstResponder];
    [self.wordText resignFirstResponder];
    [self.adeptText resignFirstResponder];
    [self.placeText resignFirstResponder];
    [self.placeText1 resignFirstResponder];
    [self.NameText resignFirstResponder];
    [self.EmailText resignFirstResponder];
    [self.sexText resignFirstResponder];
    [self.IDText resignFirstResponder];
    [self.realNameText resignFirstResponder];
    [self.birthdayText resignFirstResponder];
    [self.QQText resignFirstResponder];
    [self.weiText resignFirstResponder];
    [self.guildText resignFirstResponder];
    
}

- (void)initView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UIView *detaTileView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 246)];
    detaTileView.backgroundColor = [UIColor whiteColor];
    [sc addSubview:detaTileView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnKeyBoard)];
    [sc addGestureRecognizer:tap];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    nameLab.text = @"用户名";
    nameLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UITextField *NameText = [[UITextField alloc]initWithFrame:CGRectMake(nameLab.mj_w + nameLab.mj_x, nameLab.mj_y, self.view.mj_w - 90, 25)];
    NameText.delegate = self;
    NameText.tag = 101;
    NameText.placeholder = @"----";
    NameText.enabled = YNBOOL;
    NameText.text = self.user.loginName;
    [detaTileView addSubview:NameText];
    self.NameText = NameText;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, NameText.mj_y + NameText.mj_h, self.view.mj_w - 20, 1)];
    line.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line];
    
    UILabel *emailLab = [[UILabel alloc] initWithFrame:CGRectMake(10, NameText.mj_y + NameText.mj_h + 10, 80, 25)];
    emailLab.text = @"注册邮箱";
    emailLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:emailLab];
    self.emailLab = emailLab;
    
    UITextField *EmailText = [[UITextField alloc]initWithFrame:CGRectMake(emailLab.mj_w + emailLab.mj_x, emailLab.mj_y, self.view.mj_w - 90, 25)];
    EmailText.placeholder = @"----";
    EmailText.delegate = self;
    EmailText.tag = 102;
    EmailText.enabled = NYBOOL;
    EmailText.text = self.user.email;
    [detaTileView addSubview:EmailText];
    self.EmailText = EmailText;
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, EmailText.mj_y + EmailText.mj_h, self.view.mj_w - 20, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line1];
    
    UILabel *placeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, EmailText.mj_y + EmailText.mj_h + 10, 60, 25)];
    placeLab.text = @"所在地";
    placeLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:placeLab];
    self.emailLab = placeLab;
    
//    UILabel *shengLab = [[UILabel alloc]initWithFrame:CGRectMake([placeLab right], placeLab.mj_y, 50, 25)];
//    shengLab.text = @"省";
//    shengLab.textColor = [UIColor grayColor];
//    [detaTileView addSubview:shengLab];
    
    UITextField *placeText = [[UITextField alloc]initWithFrame:CGRectMake([placeLab right], placeLab.mj_y, (self.view.mj_w - 140)/2, 25)];
    placeText.placeholder = @"- 省 -";
    placeText.delegate = self;
    placeText.tag = 103;
    placeText.enabled = YNBOOL;
    placeText.text = self.user.provinceName;
    [detaTileView addSubview:placeText];
    self.placeText = placeText;
    
//    UILabel *shiLab = [[UILabel alloc]initWithFrame:CGRectMake(placeText.mj_w + placeText.mj_x + 20,placeLab.mj_y, 50, 25)];
//    shiLab.text = @"市";
//    shiLab.textColor = [UIColor grayColor];
//    [detaTileView addSubview:shiLab];
    
    UITextField *placeText1 = [[UITextField alloc]initWithFrame:CGRectMake(placeText.mj_w + placeText.mj_x + 20,placeLab.mj_y, (self.view.mj_w - 140)/2, 25)];
    placeText1.placeholder = @"- 市 -";
    placeText1.delegate = self;
    placeText1.tag = 301;
    placeText1.enabled = YNBOOL;
    placeText1.text = self.user.cityName;
    [detaTileView addSubview:placeText1];
    self.placeText1 = placeText1;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, placeText.mj_y + placeText.mj_h, self.view.mj_w - 20, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line2];
    
    UILabel *sexLab = [[UILabel alloc] initWithFrame:CGRectMake(10, placeText.mj_y + placeText.mj_h + 10, 80, 25)];
    sexLab.text = @"性别";
    sexLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:sexLab];
    self.sexLab = sexLab;
    
    UITextField *sexText = [[UITextField alloc]initWithFrame:CGRectMake(sexLab.mj_w + sexLab.mj_x, sexLab.mj_y, self.view.mj_w - 90, 25)];
    sexText.placeholder = @"- 请选择 -";
    sexText.delegate = self;
    sexText.tag = 104;
    sexText.enabled = YNBOOL;
    sexText.text = [self.sexArr objectAtIndex:self.user.gender.intValue];
    [detaTileView addSubview:sexText];
    self.sexText = sexText;
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(10, sexText.mj_y + sexText.mj_h, self.view.mj_w - 20, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line3];
    
    UILabel *IDLab = [[UILabel alloc] initWithFrame:CGRectMake(10, sexText.mj_y + sexText.mj_h + 10, 80, 25)];
    IDLab.text = @"身份";
    IDLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:IDLab];
    self.IDLab = IDLab;
    
    UITextField *IDText = [[UITextField alloc]initWithFrame:CGRectMake(IDLab.mj_w + IDLab.mj_x, IDLab.mj_y, self.view.mj_w - 90, 25)];
    IDText.placeholder = @"- 请选择 -";
    IDText.delegate = self;
    IDText.tag = 105;
    IDText.enabled = YNBOOL;
    IDText.text = [self.identityArr objectAtIndex:self.user.personType.intValue];
    [detaTileView addSubview:IDText];
    self.IDText = IDText;
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(10, IDText.mj_y + IDText.mj_h, self.view.mj_w - 20, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line4];
    
    UILabel *realNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, IDText.mj_y + IDText.mj_h + 10, 80, 25)];
    realNameLab.text = @"真实姓名";
    realNameLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:realNameLab];
    
    self.realNameLab = realNameLab;
    
    UITextField *realNameText = [[UITextField alloc]initWithFrame:CGRectMake(realNameLab.mj_w + realNameLab.mj_x, realNameLab.mj_y, self.view.mj_w - 90, 25)];
    realNameText.placeholder = @"----";
    realNameText.delegate = self;
    realNameText.tag = 106;
    realNameText.enabled = YNBOOL;
    realNameText.text = self.user.userName;
    [detaTileView addSubview:realNameText];
    self.realNameText = realNameText;
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(10, realNameText.mj_y + realNameText.mj_h, self.view.mj_w - 20, 1)];
    line5.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line5];
    
    UILabel *birthdayLab = [[UILabel alloc] initWithFrame:CGRectMake(10, realNameText.mj_y + realNameText.mj_h + 10, 80, 25)];
    birthdayLab.text = @"生日";
    birthdayLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:birthdayLab];
    self.birthdayLab = birthdayLab;
    
    UITextField *birthdayText = [[UITextField alloc]initWithFrame:CGRectMake(birthdayLab.mj_w + birthdayLab.mj_x, birthdayLab.mj_y, self.view.mj_w - 90, 25)];
    birthdayText.placeholder = @"- 请选择 -";
    birthdayText.delegate = self;
    birthdayText.tag = 107;
    birthdayText.enabled = YNBOOL;
    birthdayText.inputView = self.datePut;
    if (self.user.birthday==0.000000) {
        birthdayText.text =@"";
    }else
    {
        birthdayText.text =[ common sectionStrByCreateTime:self.user.birthday];
    }
    [detaTileView addSubview:birthdayText];
    self.birthdayText = birthdayText;
    
    UIView *grayView1 = [[UIView alloc]initWithFrame:CGRectMake(0, detaTileView.mj_y + detaTileView.mj_h, self.view.mj_w , 5)];
    grayView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [sc addSubview:grayView1];
    
    UIView *detaSecondView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView1.mj_h + grayView1.mj_y, self.view.mj_w, 80)];
    detaSecondView.backgroundColor = [UIColor whiteColor];
    
    [sc addSubview:detaSecondView];
    
    UILabel *QQLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    QQLab.text = @"QQ";
    QQLab.textColor = [UIColor grayColor];
    [detaSecondView addSubview:QQLab];
    self.QQLab = QQLab;
    
    UITextField *QQText = [[UITextField alloc]initWithFrame:CGRectMake(QQLab.mj_w + QQLab.mj_x, QQLab.mj_y, self.view.mj_w - 90, 25)];
    QQText.placeholder = @"----";
    QQText.delegate = self;
    QQText.tag = 108;
    QQText.enabled = YNBOOL;
    QQText.text = self.user.qq;
    [detaSecondView addSubview:QQText];
    self.QQText = QQText;
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(10, QQText.mj_y + QQText.mj_h, self.view.mj_w - 20, 1)];
    line6.backgroundColor = [UIColor grayColor];
    [detaSecondView addSubview:line6];
    
    UILabel *weiLab = [[UILabel alloc] initWithFrame:CGRectMake(10, QQText.mj_y + QQText.mj_h + 10, 80, 25)];
    weiLab.text = @"微信";
    weiLab.textColor = [UIColor grayColor];
    [detaSecondView addSubview:weiLab];
    self.weiLab = weiLab;
    
    UITextField *weiText = [[UITextField alloc]initWithFrame:CGRectMake(weiLab.mj_w + weiLab.mj_x, weiLab.mj_y, self.view.mj_w - 90, 25)];
    weiText.placeholder = @"----";
    weiText.delegate = self;
    weiText.tag = 109;
    weiText.enabled = YNBOOL;
    weiText.text = self.user.weixin;
    [detaSecondView addSubview:weiText];
    self.weiText = weiText;
    
    UIView *grayView2 = [[UIView alloc]initWithFrame:CGRectMake(0, detaSecondView.mj_y + detaSecondView.mj_h, self.view.mj_w , 5)];
    grayView2.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.grayView2 = grayView2;
    [sc addSubview:grayView2];
    
    
    UIView *detaThirdView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView2.mj_h + grayView2.mj_y, self.view.mj_w, 250)];
    detaThirdView.backgroundColor = [UIColor whiteColor];
    [sc addSubview:detaThirdView];
    
    UILabel *guildLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    guildLab.text = @"从事行业";
    guildLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:guildLab];
    self.guildLab = guildLab;
    
    UITextField *guildText = [[UITextField alloc]initWithFrame:CGRectMake(10, guildLab.mj_y + guildLab.mj_h, self.view.mj_w - 20, 25)];
    guildText.placeholder = @"- 请选择 -";
    guildText.delegate = self;
    guildText.tag = 110;
    guildText.enabled = YNBOOL;
    guildText.text = [self.hangArr objectAtIndex:self.user.industry.intValue];
    [detaThirdView addSubview:guildText];
    self.guildText = guildText;
    
    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(10, guildText.mj_y + guildText.mj_h, self.view.mj_w - 20, 1)];
    line7.backgroundColor = [UIColor grayColor];
    [detaThirdView addSubview:line7];
    
    
    
    
    UILabel *adeptLab = [[UILabel alloc] initWithFrame:CGRectMake(10, guildText.mj_y + guildText.mj_h + 10, 80, 25)];
    adeptLab.text = @"个人专长";
    adeptLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:adeptLab];
    self.adeptLab = adeptLab;
    
     UITextView *adeptText = [[UITextView alloc]init];
    CGSize size1 ;
    if (!self.user.speciality || [self.user.speciality isEqualToString:@""]) {
        adeptText.frame = CGRectMake(10, adeptLab.mj_y + adeptLab.mj_h, self.view.mj_w - 20, 25);
    }
    else
    {
        size1 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - 20, self.user.speciality, 15.0);
        if (size1.height < 25) {
            size1.height = 25;
        }
        adeptText.frame = CGRectMake(10, adeptLab.mj_y + adeptLab.mj_h, self.view.mj_w - 20, size1.height);
    }
    adeptText.delegate = self;
    adeptText.tag = 111;
    adeptText.font = [UIFont systemFontOfSize:15.0];
    adeptText.text = self.user.speciality;
    [detaThirdView addSubview:adeptText];
    self.adeptText = adeptText;
    
    UIView *line8 = [[UIView alloc]initWithFrame:CGRectMake(10, adeptText.mj_y + adeptText.mj_h, self.view.mj_w - 20, 1)];
    line8.backgroundColor = [UIColor grayColor];
    self.line8 = line8;
    [detaThirdView addSubview:line8];
    
    UILabel *wordLab = [[UILabel alloc] initWithFrame:CGRectMake(10, adeptText.mj_y + adeptText.mj_h + 10, 100, 25)];
    wordLab.text = @"一句话介绍";
    wordLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:wordLab];
    self.wordLab = wordLab;
    
    UITextView *wordText = [[UITextView alloc]init];
    
    
    
    CGSize size2 ;
    if (!self.user.oneSentenceDesc || [self.user.oneSentenceDesc isEqualToString:@""]) {
        wordText.frame = CGRectMake(10, wordLab.mj_y + wordLab.mj_h, self.view.mj_w - 20, 25);
    }
    else
    {
        size2 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - 20, self.user.oneSentenceDesc, 15.0);
        if (size2.height < 25) {
            size2.height = 25;
        }
        wordText.frame = CGRectMake(10, wordLab.mj_y + wordLab.mj_h, self.view.mj_w - 20, size2.height);
    }
    wordText.delegate = self;
    wordText.tag = 112;
    wordText.font = [UIFont systemFontOfSize:15.0];
    wordText.text = self.user.oneSentenceDesc;
    [detaThirdView addSubview:wordText];
    self.wordText = wordText;
    
    UIView *line10 = [[UIView alloc]initWithFrame:CGRectMake(10, wordText.mj_y + wordText.mj_h, self.view.mj_w - 20, 1)];
    line10.backgroundColor = [UIColor grayColor];
    self.line10 = line10;
    [detaThirdView addSubview:line10];
    
    UILabel *briefLab = [[UILabel alloc] initWithFrame:CGRectMake(10, wordText.mj_y + wordText.mj_h + 10, 80, 25)];
    briefLab.text = @"简介";
    briefLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:briefLab];
    self.briefLab = briefLab;
    
    UITextView *briefText = [[UITextView alloc]init];
    
    CGSize size3 ;
    if (!self.user.oneSentenceDesc || [self.user.oneSentenceDesc isEqualToString:@""]) {
        briefText.frame = CGRectMake(10, briefLab.mj_y + briefLab.mj_h, self.view.mj_w - 20, 25);
    }
    else
    {
        size3 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - 20, self.user.oneSentenceDesc, 15.0);
        if (size3.height < 25) {
            size3.height = 25;
        }
        briefText.frame = CGRectMake(10, briefLab.mj_y + briefLab.mj_h, self.view.mj_w - 20, size3.height);
    }
    
    briefText.delegate = self;
    briefText.tag = 113;
    briefText.font = [UIFont systemFontOfSize:15.0];
    briefText.text = self.user.individualResume;
    [detaThirdView addSubview:briefText];
    self.briefText = briefText;
    
    UIView *line11 = [[UIView alloc]initWithFrame:CGRectMake(10, briefText.mj_y + briefText.mj_h, self.view.mj_w - 20, 1)];
    line11.backgroundColor = [UIColor grayColor];
    self.line11 = line11;
    [detaThirdView addSubview:line11];
    
    if (self.passNum == 1) {
        UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, detaThirdView.mj_h + detaThirdView.mj_y + 20, self.view.mj_w, 40)];
        //        btnView.backgroundColor = [UIColor lightGrayColor];
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [nextBtn setFrame:CGRectMake(10, 5, self.view.mj_w - 20, 30)];
        
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 4;
        nextBtn.layer.borderWidth = 1;
        nextBtn.tintColor = GREENCOLOR;
        nextBtn.layer.borderColor = GREENCOLOR.CGColor;
        [btnView addSubview:nextBtn];
        [sc addSubview:btnView];
        self.nextBtn = nextBtn;
        self.btnView = btnView;
    }
    
    self.detaThirdView = detaThirdView;
    
    sc.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    sc.userInteractionEnabled = YES;
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 350);
    self.sc = sc;
    [self.view addSubview:sc];
    [sc endEditing:NO];
    [self.view endEditing:NO];
}

- (void)nextBtnAction
{
    if ([self.NameText.text isEqualToString:@""]) {
        showAlertView(@"用户名不能为空");
        return;
    }
    if ([self.EmailText.text isEqualToString:@""]) {
        showAlertView(@"注册邮箱不能为空");
        return;
    }
    BOOL isOk =[Model validateEmail:self.EmailText.text];
    if (isOk==NO)
    {
        showAlertView(@"邮箱格式不正确");
        return;
    }
    if ([self.placeText.text isEqualToString:@""]) {
        showAlertView(@"省份不能为空");
        return;
    }
    if ([self.placeText1.text isEqualToString:@""]) {
        showAlertView(@"城市不能为空");
        return;
    }
   
    if ([self.sexText.text isEqualToString:@""]) {
        showAlertView(@"性别不能为空");
        return;
    }
    if ([self.IDText.text isEqualToString:@""]) {
        showAlertView(@"身份不能为空");
        return;
    }
    if ([self.realNameText.text isEqualToString:@""]) {
        showAlertView(@"真实姓名不能为空");
        return;
    }
    if ([self.birthdayText.text isEqualToString:@""]) {
        showAlertView(@"生日不能为空");
        return;
    }
    if ([self.QQText.text isEqualToString:@""]) {
        showAlertView(@"QQ不能为空");
        return;
    }
    if ([self.weiText.text isEqualToString:@""]) {
        showAlertView(@"微信不能为空");
        return;
    }
    if ([self.guildText.text isEqualToString:@""]) {
        showAlertView(@"从事行业不能为空");
        return;
    }
    if ([self.adeptText.text isEqualToString:@""]) {
        showAlertView(@"个人专长不能为空");
        return;
    }
    if ([self.wordText.text isEqualToString:@""]) {
        showAlertView(@"一句话介绍不能为空");
        return;
    }
    if ([self.briefText.text isEqualToString:@""]) {
        showAlertView(@"简介业不能为空");
        return;
    }
    
    SQLiteBase *sqliteCityList = [SQLiteBase ShareSQLiteBaseSave];
    NSMutableArray *cityList = [[sqliteCityList searchAllDataFromTableName:@"cityList"] copy];
    NSMutableArray *provinceList = [sqliteCityList searchAllDataFromTableName:@"provinceList"] ;
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:self.NameText.text forKey:@"loginName"];
    [dic setObject:self.EmailText.text forKey:@"email"];
    // 省
    if (self.proviceArr.count != 0) {
        for (int i = 0; i < self.proviceArr.count; i++)
        {
            placeModel *plp = self.proviceArr[i];
            if ([self.placeText.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"provinceId"];
                
            }
            
        }
    }
    else
    {
        for (int i = 0 ; i < provinceList.count; i ++) {
            placeModel *plp = provinceList[i];
            if ([self.placeText.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"provinceId"];
                
            }
        }
    }
    
    [dic setObject:self.placeText.text forKey:@"provinceName"];
    
    // 市
    if (self.cityArr.count != 0) {
        for (int i = 0; i < self.cityArr.count; i++)
        {
            placeModel *plp = self.cityArr[i];
            if ([self.placeText1.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"cityId"];
                
            }
            
        }
    }
    else
    {
        for (int i = 0 ; i < cityList.count; i ++) {
            placeModel *plp = cityList[i];
            if ([self.placeText1.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"cityId"];
                
            }
        }
    }
    
    [dic setObject:self.placeText1.text forKey:@"cityName"];
    
    for (int i = 0; i < self.sexArr.count; i ++) {
        if ([self.sexText.text isEqualToString:self.sexArr[i]]) {
            NSString *sexStr = [NSString stringWithFormat:@"%d",i];
            [dic setObject:sexStr forKey:@"sgender"];
        }
        else
        {
            
        }
    }
    
    for (int i = 0; i < self.identityArr.count; i++)
    {
        if ([self.IDText.text isEqualToString:self.identityArr[i]] )
        {
            NSString *idxStr = [NSString stringWithFormat:@"%d",i];
            [dic setObject:idxStr forKey:@"spersonType"];
            
        }
        
    }
    // 真实姓名
    [dic setObject:self.realNameText.text forKey:@"userName"];
    [dic setObject:self.birthdayText.text forKey:@"sbirthday"];
    [dic setObject:self.QQText.text forKey:@"qq"];
    [dic setObject:self.weiText.text forKey:@"weixin"];
    for (int i = 0; i < self.hangArr.count; i ++) {
        if ([self.guildText.text isEqualToString:self.hangArr[i]])
        {
            if (i < 10) {
                NSString *hangs = [NSString stringWithFormat:@"0%d",i];
                [dic setObject:hangs forKey:@"industry"];
            }
            else
            {
                NSString *hangs1 = [NSString stringWithFormat:@"%d",i];
                [dic setObject:hangs1 forKey:@"industry"];
            }
        }
    }
    [dic setObject:self.adeptText.text forKey:@"speciality"];
    [dic setObject:self.wordText.text forKey:@"oneSentenceDesc"];
    [dic setObject:self.briefText.text forKey:@"individualResume"];
    
    
    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEGERENXINXI params:dic complete:^(BOOL successed, NSDictionary *result) {
        if (successed) {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            EducationViewController *educationVc = [[EducationViewController alloc]init];
            educationVc.passNum = 1;
            [weakSelf.navigationController pushViewController:educationVc animated:YES];
        }
        //
    }];
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 提交
 */
- (void)alterAction
{
    if ([self.NameText.text isEqualToString:@""]) {
        showAlertView(@"用户名不能为空");
        return;
    }
    if ([self.EmailText.text isEqualToString:@""]) {
        showAlertView(@"注册邮箱不能为空");
        return;
    }
    BOOL isOk =[Model validateEmail:self.EmailText.text];
    if (isOk==NO)
    {
        showAlertView(@"邮箱格式不正确");
        return;
    }
    if ([self.sexText.text isEqualToString:@""]) {
        showAlertView(@"性别不能为空");
        return;
    }
    if ([self.IDText.text isEqualToString:@""]) {
        showAlertView(@"身份不能为空");
        return;
    }
    if ([self.realNameText.text isEqualToString:@""]) {
        showAlertView(@"真实姓名不能为空");
        return;
    }
    if ([self.birthdayText.text isEqualToString:@""]) {
        showAlertView(@"生日不能为空");
        return;
    }
    if ([self.guildText.text isEqualToString:@""]) {
        showAlertView(@"从事行业不能为空");
        return;
    }
    
    SQLiteBase *sqliteCityList = [SQLiteBase ShareSQLiteBaseSave];
    NSMutableArray *cityList = [[sqliteCityList searchAllDataFromTableName:@"cityList"] copy];
    NSMutableArray *provinceList = [sqliteCityList searchAllDataFromTableName:@"provinceList"] ;
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:self.NameText.text forKey:@"loginName"];
    [dic setObject:self.EmailText.text forKey:@"email"];
    // 省
    if (self.proviceArr.count != 0) {
        for (int i = 0; i < self.proviceArr.count; i++)
        {
            placeModel *plp = self.proviceArr[i];
            if ([self.placeText.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"provinceId"];
                
            }
            
        }
    }
    else
    {
        for (int i = 0 ; i < provinceList.count; i ++) {
            placeModel *plp = provinceList[i];
            if ([self.placeText.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"provinceId"];
                
            }
        }
    }
    
    [dic setObject:self.placeText.text forKey:@"provinceName"];
    
    // 市
    if (self.cityArr.count != 0) {
        for (int i = 0; i < self.cityArr.count; i++)
        {
            placeModel *plp = self.cityArr[i];
            if ([self.placeText1.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"cityId"];
                
            }
            
        }
    }
    else
    {
        for (int i = 0 ; i < cityList.count; i ++) {
            placeModel *plp = cityList[i];
            if ([self.placeText1.text isEqualToString:plp.areaName] )
            {
                [dic setObject:plp.strID forKey:@"cityId"];
                
            }
        }
    }
    
    [dic setObject:self.placeText1.text forKey:@"cityName"];
    
    for (int i = 0; i < self.sexArr.count; i ++) {
        if ([self.sexText.text isEqualToString:self.sexArr[i]]) {
            NSString *sexStr = [NSString stringWithFormat:@"%d",i];
            [dic setObject:sexStr forKey:@"sgender"];
        }
        else
        {
            
        }
    }
    
    for (int i = 0; i < self.identityArr.count; i++)
    {
        if ([self.IDText.text isEqualToString:self.identityArr[i]] )
        {
            NSString *idxStr = [NSString stringWithFormat:@"%d",i];
            [dic setObject:idxStr forKey:@"spersonType"];
            
        }
        
    }
    // 真实姓名
    [dic setObject:self.realNameText.text forKey:@"userName"];
    [dic setObject:self.birthdayText.text forKey:@"sbirthday"];
    [dic setObject:self.QQText.text forKey:@"qq"];
    [dic setObject:self.weiText.text forKey:@"weixin"];
    for (int i = 0; i < self.hangArr.count; i ++) {
        if ([self.guildText.text isEqualToString:self.hangArr[i]])
        {
            if (i < 10) {
                NSString *hangs = [NSString stringWithFormat:@"0%d",i];
                [dic setObject:hangs forKey:@"industry"];
            }
            else
            {
                NSString *hangs1 = [NSString stringWithFormat:@"%d",i];
                [dic setObject:hangs1 forKey:@"industry"];
            }
        }
    }
    [dic setObject:self.adeptText.text forKey:@"speciality"];
    [dic setObject:self.wordText.text forKey:@"oneSentenceDesc"];
    [dic setObject:self.briefText forKey:@"individualResume"];
    
    [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEGERENXINXI params:dic complete:^(BOOL successed, NSDictionary *result) {
        if (successed) {
            if ([result[@"code"] isEqualToString:@"10000"]) {
                [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        }
        //
    }];
}

- (void)keyboardShow:(NSNotification *)not
{
    
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
        ff.height += keyboardH;
        self.sc.contentSize = ff;
        //        CGPoint position = CGPointMake(0, keyboardH);
        //        [self.sc setContentOffset:position animated:YES];
   
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
//date
- (UIView *)datePut
{
    
    if (!_datePut) {
        _datePut = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w,216)];
        UIButton *btnS = [[UIButton alloc] initWithFrame:CGRectMake(10, 3, 40, 20)];
        [btnS setTitle:@"确定" forState:UIControlStateNormal];
        [btnS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnS addTarget:self action:@selector(btnSClike) forControlEvents:UIControlEventTouchUpInside];
        [_datePut addSubview:btnS];
        
        UIButton *btnQ = [[UIButton alloc] initWithFrame:CGRectMake(_datePut.mj_w - 50, 3, 40, 20)];
        [btnQ setTitle:@"取消" forState:UIControlStateNormal];
        [btnQ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnQ addTarget:self action:@selector(btnQClike) forControlEvents:UIControlEventTouchUpInside];
        [_datePut addSubview:btnQ];
        
        UIDatePicker *dat = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,20, _datePut.mj_w, _datePut.mj_h - 20)];
        dat.datePickerMode = UIDatePickerModeDate;
        [dat addTarget:self action:@selector(datePick:) forControlEvents:UIControlEventValueChanged];
        [_datePut addSubview:dat];
    }
    return _datePut;
}
- (void)btnSClike
{
    self.textField.text = self.formatterDate;
    [self.textField endEditing:YES];
    
}
- (void)btnQClike
{
    self.textField.text = @"";
    [self.textField endEditing:YES];
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

#pragma mark - textField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textField = textField;
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
            self.arrDataS = self.sexArr;
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            break;
            
        case 105:
            self.arrDataS = self.identityArr;
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            
            break;
        case 110:
            self.arrDataS = self.hangArr;
            [self.pick reloadAllComponents];
            textField.inputView = self.picker;
            break;
        case 301:
            self.arrDataS = self.cityAreamArr;
            if ([self.placeText.text isEqualToString:@""])
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
            
            self.placeText1.text = @"";
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

#pragma mark - textView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    CGRect frame = textView.frame;
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0]};
    CGSize size1 = [textView.text boundingRectWithSize:CGSizeMake(self.view.mj_w - 25, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                            attributes:attrbute
                                               context:nil].size;
    frame.size.height = size1.height > 1 ? size1.height + 20 : 64;
//    textView.frame = frame;
   self.adeptLab.frame = CGRectMake(10, self.guildText.mj_y + self.guildText.mj_h + 10, 80, 25);
   
    if (textView.tag == 111)
    {
        
       self.adeptText.frame = CGRectMake(10, self.adeptLab.mj_y + self.adeptLab.mj_h, self.view.mj_w - 20, frame.size.height);
    }
    else
    {
//        CGSize size0;
//        size0.height = self.adeptText.frame.size.height;
//        self.adeptText.frame = CGRectMake(10, self.guildText.mj_y + self.guildText.mj_h + 10, self.view.mj_w - 20, size0.height);
        
        CGSize size1;
        size1.height = self.wordText.frame.size.height;
        self.wordText.frame = CGRectMake(10, self.wordLab.mj_y + self.wordLab.mj_h, self.view.mj_w - 20, size1.height);
        
        CGSize size2;
        size2.height = self.briefText.frame.size.height;
        self.briefText.frame = CGRectMake(10, self.briefLab.mj_y + self.briefLab.mj_h, self.view.mj_w - 20, size2.height);
    }
    
    self.line8.frame = CGRectMake(10, self.adeptText.mj_y + self.adeptText.mj_h , self.view.mj_w - 20, 1);
    
    self.wordLab.frame = CGRectMake(10, self.adeptText.mj_y + self.adeptText.mj_h + 10, 100, 25);
    if (textView.tag == 112)
    {
        self.wordText.frame = CGRectMake(10, self.wordLab.mj_y + self.wordLab.mj_h, self.view.mj_w - 20, frame.size.height);
    }
    else
    {
//        CGSize size0;
//        size0.height = self.adeptText.frame.size.height;
//        self.adeptText.frame = CGRectMake(10, self.guildText.mj_y + self.guildText.mj_h + 10, self.view.mj_w - 20, size0.height);
        CGSize size1;
        size1.height = self.wordText.frame.size.height;
        self.wordText.frame = CGRectMake(10, self.wordLab.mj_y + self.wordLab.mj_h, self.view.mj_w - 20, size1.height);
        
        CGSize size2;
        size2.height = self.briefText.frame.size.height;
        self.briefText.frame = CGRectMake(10, self.briefLab.mj_y + self.briefLab.mj_h, self.view.mj_w - 20, size2.height);
    }

    self.line10.frame = CGRectMake(10, self.wordText.mj_y + self.wordText.mj_h, self.view.mj_w - 20, 1);
    
    self.briefLab.frame = CGRectMake(10, self.wordText.mj_y + self.wordText.mj_h + 10, 80, 25);
    if (textView.tag == 113)
    {
        self.briefText.frame = CGRectMake(10, self.briefLab.mj_y + self.briefLab.mj_h, self.view.mj_w - 20, frame.size.height);
    }
    else
    {
        
//        CGSize size0;
//        size0.height = self.adeptText.frame.size.height;
//        self.adeptText.frame = CGRectMake(10, self.guildText.mj_y + self.guildText.mj_h + 10, self.view.mj_w - 20, size0.height);
        
        CGSize size1;
        size1.height = self.wordText.frame.size.height;
        self.wordText.frame = CGRectMake(10, self.wordLab.mj_y + self.wordLab.mj_h, self.view.mj_w - 20, size1.height);
        
        CGSize size2;
        size2.height = self.briefText.frame.size.height;
        self.briefText.frame = CGRectMake(10, self.briefLab.mj_y + self.briefLab.mj_h, self.view.mj_w - 20, size2.height);
    }
    
    self.line11.frame = CGRectMake(10, self.briefText.mj_y + self.briefText.mj_h, self.view.mj_w - 20, 1);
    
    
    if (self.passNum == 1)
    {
        self.btnView.frame = CGRectMake(0, self.detaThirdView.mj_h + self.detaThirdView.mj_y + 20, self.view.mj_w, 40);
        
        [self.nextBtn setFrame:CGRectMake(10, 5, self.view.mj_w - 20, 30)];
       
    }
    
    CGSize size2;
    size2.height = self.detaThirdView.frame.size.height;
    self.detaThirdView.frame = CGRectMake(0, self.grayView2.mj_h + self.grayView2.mj_y, self.view.mj_w, 350  + frame.size.height);
    
    CGSize size3;
    size3.height = self.sc.contentSize.height;
    self.sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 350  + frame.size.height);
//    [textView resignFirstResponder];
    return YES;
}



- (NSArray *)sexArr
{
    if (!_sexArr) {
        _sexArr = @[@"男",@"女"];
    }
    return _sexArr;
}
- (NSArray *)identityArr
{
    if (!_identityArr) {
        _identityArr = @[ @"学生",@"军人",@"其他",@"职场人",@"创业者",@"边工作边创业"];
        //        0:学生；1：军人；2：其他;3:职场人；4:创业者；5：边工作边创业
    }
    return _identityArr;
}

- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"互联网",@"移动互联网",@"IT",@"电信及增值",@"传媒娱乐",@"能源",@"医疗健康",@"旅行",@"游戏",@"金融",@"教育",@"房地产",@"物流仓库",@"农林牧渔",@"住宿餐饮",@"商品服务",@"消费品",@"文体艺术",@"加工制造",@"节能环保",@"其他"];
        //        00：互联网；01:移动互联网；02：IT;03:电信及增值；04：传媒娱乐；05：能源；06：医疗健康；07：旅行；08：游戏；09：金融；10：教育；11：房地产；12：物流仓库；13：农林牧渔；14：住宿餐饮；15：商品服务；16：消费品；17：文体艺术；18：加工制造；19:节能环保；20：其他；
    }
    return _hangArr;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
