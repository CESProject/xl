//
//  BecTeacViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/21.
//  Copyright © 2016年 王文静. All rights reserved.
// *****************  我要做导师  ******************

#import "BecTeacViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "Model.h"
#import "SQLiteBase.h"
#import "placeModel.h"
//#import "DateEventModel.h"
#import "EventTableViewCell.h"
#import "informationModel.h"
#import "CareerTableViewCell.h"
#import "informationModel.h"

#define LBLHEI   21
#define TEXHEI   35
#define LBLX     28
#define TEXX     25
#define ASSY     27
#define LBLTEXSPACE  15
#define TEXLBLSPACE  25
#define BTNWID       60
#define LBLWID       self.view.mj_w - 56
/// pickview 的高度
#define hPickViewHeight 200

@interface BecTeacViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate,WJSliderViewDelegate>
{
    UITableView *myTableview;
    UITableView *comTableView;
    int numberOfrow;
}
@property (nonatomic , assign) NSInteger scrollNum;

@property (nonatomic , strong) NSMutableArray *modelArr;
@property (nonatomic , strong) NSMutableArray *infoModelArr;

@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;


@property (nonatomic , strong) UIView *grayView;
@property (nonatomic , strong) UIView *detaTileView;
@property (nonatomic , strong) UILabel *placeLab;
@property (nonatomic , strong) UITextField *placeText;
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
@property (nonatomic , strong) UITextField *adeptText;
@property (nonatomic , strong) UILabel *wordLab;
@property (nonatomic , strong) UITextField *wordText;
@property (nonatomic , strong) UILabel *briefLab;
@property (nonatomic , strong) UITextField *briefText;
@property (nonatomic , strong) UIButton *nextBtn;
@property (nonatomic , strong) UIButton *comNextBtn;


@property(nonatomic,strong)UIView *datePut;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSArray *arrDataS;
@property(nonatomic,strong)UIView *picker;
@property(nonatomic,strong)UIPickerView *pick;
@property(nonatomic,copy)NSString *strPicker;
@property(nonatomic,copy)NSString *formatterDate;
@property(nonatomic,weak)UITextField *textDate;

@property (nonatomic , strong)  NSMutableArray *cityList;

@property (nonatomic , strong) NSArray *sexArr; // 性别
@property (nonatomic , strong) NSArray *identityArr; // 身份
@property (nonatomic , strong) NSArray *hangArr; //   行业

@end

@implementation BecTeacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我要做导师";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.scrollNum = 0;

    
    [self initView];
}

- (void)initView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    
    self.detalView = [UIView new];
    self.commentsView = [UIView new];
    self.resulsView = [UIView new];
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    UILabel *label3 = [UILabel new];
    
    label1.text = @"基本信息";
    label2.text = @"职业信息";
    label3.text = @"成长足迹";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    label3.textAlignment = NSTextAlignmentCenter;
    
    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.height + 50) itemArray:@[label1,label2,label3] contentArray:@[self.detalView,self.commentsView,self.resulsView]];
    self.wjScroll.delegate = self;
    self.wjScroll.backgroundColor = [UIColor whiteColor];
    
    [sc addSubview:self.wjScroll];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //    [self.detalView addSubview:grayView];
    
    
    UIView *detaTileView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 250)];
    detaTileView.backgroundColor = [UIColor whiteColor];
    [self.detalView addSubview:detaTileView];
    
    
    UILabel *placeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    placeLab.text = @"所在地";
    placeLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:placeLab];
    self.placeLab = placeLab;
    
    UITextField *placeText = [[UITextField alloc]initWithFrame:CGRectMake(placeLab.mj_w + placeLab.mj_x, placeLab.mj_y, self.view.mj_w - 90, 25)];
    placeText.delegate = self;
    placeText.tag = 101;
    placeText.placeholder = @"- 请选择 -";
    [detaTileView addSubview:placeText];
    self.placeText = placeText;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, placeText.mj_y + placeText.mj_h, self.view.mj_w - 20, 1)];
    line.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, placeText.mj_y + placeText.mj_h + 10, 80, 25)];
    nameLab.text = @"用户名";
    nameLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UITextField *NameText = [[UITextField alloc]initWithFrame:CGRectMake(nameLab.mj_w + nameLab.mj_x, nameLab.mj_y, self.view.mj_w - 90, 25)];
    NameText.placeholder = @"----";
    NameText.delegate = self;
    NameText.tag = 102;
    [detaTileView addSubview:NameText];
    self.NameText = NameText;
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, NameText.mj_y + NameText.mj_h, self.view.mj_w - 20, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line1];
    
    UILabel *emailLab = [[UILabel alloc] initWithFrame:CGRectMake(10, NameText.mj_y + NameText.mj_h + 10, 80, 25)];
    emailLab.text = @"注册邮箱";
    emailLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:emailLab];
    self.emailLab = emailLab;
    
    
    UITextField *EmailText = [[UITextField alloc]initWithFrame:CGRectMake(emailLab.mj_w + emailLab.mj_x, emailLab.mj_y, self.view.mj_w - 90, 25)];
    EmailText.placeholder = @"----";
    EmailText.delegate = self;
    EmailText.tag = 103;
    [detaTileView addSubview:EmailText];
    self.EmailText = EmailText;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, EmailText.mj_y + EmailText.mj_h, self.view.mj_w - 20, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [detaTileView addSubview:line2];
    
    UILabel *sexLab = [[UILabel alloc] initWithFrame:CGRectMake(10, EmailText.mj_y + EmailText.mj_h + 10, 80, 25)];
    sexLab.text = @"性别";
    sexLab.textColor = [UIColor grayColor];
    [detaTileView addSubview:sexLab];
    self.sexLab = sexLab;
    
    UITextField *sexText = [[UITextField alloc]initWithFrame:CGRectMake(sexLab.mj_w + sexLab.mj_x, sexLab.mj_y, self.view.mj_w - 90, 25)];
    sexText.placeholder = @"- 请选择 -";
    sexText.delegate = self;
    sexText.tag = 104;
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
    birthdayText.inputView = self.datePut;
    [detaTileView addSubview:birthdayText];
    self.birthdayText = birthdayText;
    
    UIView *grayView1 = [[UIView alloc]initWithFrame:CGRectMake(0, detaTileView.mj_y + detaTileView.mj_h, self.view.mj_w , 5)];
    grayView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detalView addSubview:grayView1];
    
    
    UIView *detaSecondView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView1.mj_h + grayView1.mj_y, self.view.mj_w, 80)];
    detaSecondView.backgroundColor = [UIColor whiteColor];
    
    [self.detalView addSubview:detaSecondView];
    
    UILabel *QQLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    QQLab.text = @"QQ";
    QQLab.textColor = [UIColor grayColor];
    [detaSecondView addSubview:QQLab];
    self.QQLab = QQLab;
    
    UITextField *QQText = [[UITextField alloc]initWithFrame:CGRectMake(QQLab.mj_w + QQLab.mj_x, QQLab.mj_y, self.view.mj_w - 90, 25)];
    QQText.placeholder = @"----";
    QQText.delegate = self;
    QQText.tag = 108;
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
    [detaSecondView addSubview:weiText];
    self.weiText = weiText;
    
    UIView *grayView2 = [[UIView alloc]initWithFrame:CGRectMake(0, detaSecondView.mj_y + detaSecondView.mj_h, self.view.mj_w , 5)];
    grayView2.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detalView addSubview:grayView2];
    
    
    UIView *detaThirdView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView2.mj_h + grayView2.mj_y, self.view.mj_w, 250)];
    detaThirdView.backgroundColor = [UIColor whiteColor];
    [self.detalView addSubview:detaThirdView];
    
    UILabel *guildLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    guildLab.text = @"从事行业";
    guildLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:guildLab];
    self.guildLab = guildLab;
    
    UITextField *guildText = [[UITextField alloc]initWithFrame:CGRectMake(10, guildLab.mj_y + guildLab.mj_h, self.view.mj_w - 20, 25)];
    guildText.placeholder = @"- 请选择 -";
    guildText.delegate = self;
    guildText.tag = 110;
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
    
    UITextField *adeptText = [[UITextField alloc]initWithFrame:CGRectMake(10, adeptLab.mj_y + adeptLab.mj_h, self.view.mj_w - 20, 25)];
    adeptText.placeholder = @"请填写您的专长";
    adeptText.delegate = self;
    adeptText.tag = 111;
    [detaThirdView addSubview:adeptText];
    self.adeptText = adeptText;
    
    UIView *line8 = [[UIView alloc]initWithFrame:CGRectMake(10, adeptText.mj_y + adeptText.mj_h, self.view.mj_w - 20, 1)];
    line8.backgroundColor = [UIColor grayColor];
    [detaThirdView addSubview:line8];
    
    //    UILabel *adeptLab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, adeptText.mj_y + adeptText.mj_h + 10, 80, 25)];
    //    adeptLab1.text = @"个人专长字段";
    //    adeptLab1.textColor = [UIColor grayColor];
    //    [detaThirdView addSubview:adeptLab1];
    //
    //    UITextField *adeptText1 = [[UITextField alloc]initWithFrame:CGRectMake(adeptLab1.mj_w + adeptLab1.mj_x, adeptLab1.mj_y, self.view.mj_w - 90, 25)];
    //    adeptText1.placeholder = @"----";
    //    [detaThirdView addSubview:adeptText1];
    //
    //    UIView *line9 = [[UIView alloc]initWithFrame:CGRectMake(10, adeptText1.mj_y + adeptText1.mj_h, self.view.mj_w - 20, 1)];
    //    line9.backgroundColor = [UIColor grayColor];
    //    [detaThirdView addSubview:line9];
    
    UILabel *wordLab = [[UILabel alloc] initWithFrame:CGRectMake(10, adeptText.mj_y + adeptText.mj_h + 10, 100, 25)];
    wordLab.text = @"一句话介绍";
    wordLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:wordLab];
    self.wordLab = wordLab;
    
    UITextField *wordText = [[UITextField alloc]initWithFrame:CGRectMake(10, wordLab.mj_y + wordLab.mj_h, self.view.mj_w - 20, 25)];
    wordText.placeholder = @"----";
    wordText.delegate = self;
    wordText.tag = 112;
    [detaThirdView addSubview:wordText];
    self.wordText = wordText;
    
    UIView *line10 = [[UIView alloc]initWithFrame:CGRectMake(10, wordText.mj_y + wordText.mj_h, self.view.mj_w - 20, 1)];
    line10.backgroundColor = [UIColor grayColor];
    [detaThirdView addSubview:line10];
    
    UILabel *briefLab = [[UILabel alloc] initWithFrame:CGRectMake(10, wordText.mj_y + wordText.mj_h + 10, 80, 25)];
    briefLab.text = @"简介";
    briefLab.textColor = [UIColor grayColor];
    [detaThirdView addSubview:briefLab];
    self.briefLab = briefLab;
    
    UITextField *briefText = [[UITextField alloc]initWithFrame:CGRectMake(10, briefLab.mj_y + briefLab.mj_h, self.view.mj_w - 90, 25)];
    briefText.placeholder = @"----";
    briefText.delegate = self;
    briefText.tag = 113;
    [detaThirdView addSubview:briefText];
    self.briefText = briefText;
    
    UIView *line11 = [[UIView alloc]initWithFrame:CGRectMake(10, briefText.mj_y + briefText.mj_h, self.view.mj_w - 20, 1)];
    line11.backgroundColor = [UIColor grayColor];
    [detaThirdView addSubview:line11];
    //
    //    UILabel *realNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, IDText.mj_y + IDText.mj_h + 10, 80, 25)];
    //    realNameLab.text = @"真实姓名";
    //    realNameLab.textColor = [UIColor grayColor];
    //    [detaTileView addSubview:realNameLab];
    //
    //    UITextField *realNameText = [[UITextField alloc]initWithFrame:CGRectMake(realNameLab.mj_w + realNameLab.mj_x, realNameLab.mj_y, self.view.mj_w - 90, 25)];
    //    realNameText.placeholder = @"----";
    //    [detaTileView addSubview:realNameText];
    //
    //    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(10, realNameText.mj_y + realNameText.mj_h, self.view.mj_w - 20, 1)];
    //    line5.backgroundColor = [UIColor grayColor];
    //    [detaTileView addSubview:line5];
    //
    //    UILabel *birthdayLab = [[UILabel alloc] initWithFrame:CGRectMake(10, realNameText.mj_y + realNameText.mj_h + 10, 80, 25)];
    //    birthdayLab.text = @"生日";
    //    birthdayLab.textColor = [UIColor grayColor];
    //    [detaTileView addSubview:birthdayLab];
    //
    //    UITextField *birthdayText = [[UITextField alloc]initWithFrame:CGRectMake(birthdayLab.mj_w + birthdayLab.mj_x, birthdayLab.mj_y, self.view.mj_w - 90, 25)];
    //    birthdayText.placeholder = @"----";
    //    [detaTileView addSubview:birthdayText];
    //
    //    UIView *grayView1 = [[UIView alloc]initWithFrame:CGRectMake(0, detaTileView.mj_y + detaTileView.mj_h, self.view.mj_w , 5)];
    //    grayView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //    [self.detalView addSubview:grayView1];
    [self.detalView addSubview:grayView];
    self.detaTileView = detaTileView;
    self.detaSecondView = detaSecondView;
    self.detaThirdView = detaThirdView;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.tag = 301;
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setFrame:CGRectMake(20, detaThirdView.mj_h + detaThirdView.mj_y + 40, self.view.mj_w - 40, 30)];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 4;
    nextBtn.layer.borderWidth = 1;
    nextBtn.tintColor = GREENCOLOR;
    nextBtn.layer.borderColor = GREENCOLOR.CGColor;
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    nextBtn.backgroundColor = [UIColor cyanColor];
    self.nextBtn = nextBtn;
    [self.detalView addSubview:nextBtn];
    
    
    self.infoModelArr = [NSMutableArray array];
    informationModel *inmodel = [informationModel new];
    inmodel.provinceName = @"";
    inmodel.cityName = @"";
    inmodel.organizationName = @"";
    inmodel.workStartDate = @"";
    inmodel.workEndDate = @"";
    inmodel.position = @"";
    [self.infoModelArr addObject:inmodel];
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.mj_w, self.view.bounds.size.height - 160) style:UITableViewStylePlain];
    comTableView.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    comTableView.dataSource = self;
    comTableView.delegate  = self;
    comTableView.rowHeight = 230;
    comTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.commentsView addSubview:comTableView];
    
    UIButton *comNextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [comNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    comNextBtn.tag = 302;
    [comNextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [comNextBtn setFrame:CGRectMake(20, comTableView.mj_h + comTableView.mj_y + 10, self.view.mj_w - 40, 30)];
    comNextBtn.layer.masksToBounds = YES;
    comNextBtn.layer.cornerRadius = 4;
    comNextBtn.layer.borderWidth = 1;
    comNextBtn.tintColor = GREENCOLOR;
    comNextBtn.layer.borderColor = GREENCOLOR.CGColor;
    comNextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    comNextBtn.backgroundColor = [UIColor cyanColor];
    self.commentsView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.comNextBtn = comNextBtn;
    [self.commentsView addSubview:comNextBtn];
    ////////////////////////////////////////////////
    numberOfrow = (int)self.modelArr.count;
    
    myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.mj_h - 160) style:UITableViewStylePlain];
    myTableview.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    myTableview.delegate = self;
    myTableview.dataSource = self;
    myTableview.rowHeight = 121;
    [self.resulsView addSubview:myTableview];
    
    UIButton *resNextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [resNextBtn setTitle:@"完成" forState:UIControlStateNormal];
    resNextBtn.tag = 303;
    [resNextBtn addTarget:self action:@selector(finishideAction) forControlEvents:UIControlEventTouchUpInside];
    [resNextBtn setFrame:CGRectMake(20, myTableview.mj_h + myTableview.mj_y + 10, self.view.mj_w - 40, 30)];
    resNextBtn.layer.masksToBounds = YES;
    resNextBtn.layer.cornerRadius = 4;
    resNextBtn.layer.borderWidth = 1;
    resNextBtn.tintColor = GREENCOLOR;
    resNextBtn.layer.borderColor = GREENCOLOR.CGColor;
    comNextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    resNextBtn.backgroundColor = [UIColor cyanColor];
    self.resulsView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    self.resNextBtn = resNextBtn;
    [self.resulsView addSubview:resNextBtn];
    
    self.modelArr = [NSMutableArray array];
    informationModel *model = [informationModel new];
    model.footprintTime = @"";
    model.incident = @"";
    [self.modelArr addObject:model];
    
    /////////////////////////////////////////////////
    
    
    
    
    sc.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    sc.userInteractionEnabled = YES;
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 350);
    self.sc = sc;
    [self.view addSubview:sc];
    
}

- (void)finishideAction
{
    
}

- (void)nextBtnAction:(UIButton *)sender
{
    if (sender.tag == 301) {
        
   
    self.nextBtn.enabled = NO;
    if ([self.placeText.text isEqualToString:@""]) {
        showAlertView(@"所在地不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.NameText.text isEqualToString:@""]) {
        showAlertView(@"用户名不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.EmailText.text isEqualToString:@""]) {
        showAlertView(@"注册邮箱不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    BOOL isOk =[Model validateEmail:self.EmailText.text];
    if (isOk==NO)
    {
        showAlertView(@"邮箱格式不正确");
        self.nextBtn.enabled = YES;
        return;
    }
    
    if ([self.sexText.text isEqualToString:@""]) {
        showAlertView(@"性别不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.IDText.text isEqualToString:@""]) {
        showAlertView(@"身份不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.realNameText.text isEqualToString:@""]) {
        showAlertView(@"真实姓名不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.birthdayText.text isEqualToString:@""]) {
        showAlertView(@"生日不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.QQText.text isEqualToString:@""]) {
        showAlertView(@"QQ不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.weiText.text isEqualToString:@""]) {
        showAlertView(@"微信不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.guildText.text isEqualToString:@""]) {
        showAlertView(@"从事行业不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.adeptText.text isEqualToString:@""]) {
        showAlertView(@"个人专长不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.wordText.text isEqualToString:@""]) {
        showAlertView(@"一句话介绍不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([self.briefText.text isEqualToString:@""]) {
        showAlertView(@"简介不能为空");
        self.nextBtn.enabled = YES;
        return;
    }
    
    
    [self.wjScroll WJSliderViewDidIndex:1];
    self.scrollNum = 1;
    [myTableview reloadData];
         }
    else if (sender.tag == 302)
    {
        [self.wjScroll WJSliderViewDidIndex:2];
        self.scrollNum = 2;
        [comTableView reloadData];
    }
}

#pragma mark - textField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textField = textField;
    SQLiteBase *sqlitePlaceList = [SQLiteBase ShareSQLiteBaseSave];
    NSMutableArray *cityList = [sqlitePlaceList searchAllDataFromTableName:@"cityList"] ;
    switch (textField.tag) {
            
        case 101:
            if (cityList.count)
            {
                
                self.cityList = [NSMutableArray array];
                NSMutableArray *areamArr = [NSMutableArray array];
                for (placeModel *pl in cityList) {
                    [areamArr addObject:pl.areaName];
                    [self.cityList addObject:pl];
                }
                self.arrDataS = areamArr;
                
                [self.pick reloadAllComponents];
                textField.inputView = self.picker;
            }
            else
            {
                // 市
                [sqlitePlaceList deleteAllDataFromTableName:@"cityList"];
                [[HttpManager defaultManager]postRequestToUrl:DEF_DIQU params:@{@"areaLevel":@(2)} complete:^(BOOL successed, NSDictionary *result) {
                    
                    NSMutableArray *proArr = [NSMutableArray array];
                    for ( NSDictionary *dic  in result[@"objList"]) {
                        placeModel *plcae = [placeModel objectWithKeyValues:dic];
                        [proArr addObject:plcae];
                        [sqlitePlaceList createWithTableName:@"cityList" withModel:plcae];
                    }
                    
                }];
                NSMutableArray *provinceList1 = [sqlitePlaceList searchAllDataFromTableName:@"cityList"] ;
                self.cityList = [NSMutableArray array];
                NSMutableArray *areamArr = [NSMutableArray array];
                for (placeModel *pl in provinceList1) {
                    [areamArr addObject:pl.areaName];
                    [self.cityList addObject:pl];
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
            
            
            
        default:
            break;
    }
    
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
//        CGPoint position = CGPointMake(0, keyboardH);
//        [self.sc setContentOffset:position animated:YES];
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

///
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

#pragma mark - tableview Delegate

- (void)loadWJSliderViewDidIndex:(NSInteger)index
{
    self.scrollNum = index;
    if (self.scrollNum == 2) {
        [myTableview reloadData];
    }
    else if(self.scrollNum == 1)
    {
        [comTableView reloadData];
    }
    else
    {
        
    }
}

- (void)addButtonAction
{
    
    if (self.scrollNum == 2) {
        
        informationModel *model = [[informationModel alloc]init];
        model.footprintTime = @"";
        model.incident = @"";
        
        [self.modelArr addObject:model];
        [myTableview reloadData];
    }
    else if(self.scrollNum == 1)
    {
        informationModel *model = [informationModel new];
        model.provinceName = @"";
        model.cityName = @"";
        model.organizationName = @"";
        model.workStartDate = @"";
        model.workEndDate = @"";
        model.position = @"";
        [self.infoModelArr addObject:model];
        [comTableView reloadData];
    }
    else
    {
        
    }
}

- (void)delButtonAction:(UIButton *)sender
{
    if (self.scrollNum == 2) {
        
        
        if (self.modelArr.count > 1)
        {
            [self.modelArr removeObjectAtIndex:sender.tag];
            [myTableview reloadData];
            NSLog(@"%@",self.modelArr);
            
        }
        else
        {
            [self.modelArr removeAllObjects];
            //        [self.modelArr removeObjectAtIndex:sender.tag];
            informationModel *model = [[informationModel alloc]init];
            model.footprintTime = @"";
            model.incident = @"";
            
            [self.modelArr addObject:model];
            [myTableview reloadData];
        }
    }
    else if (self.scrollNum == 1)
    {
        if (self.infoModelArr.count > 1)
        {
            [self.infoModelArr removeObjectAtIndex:sender.tag];
            [comTableView reloadData];
            NSLog(@"%@",self.infoModelArr);
            
        }
        else
        {
            [self.infoModelArr removeAllObjects];
            informationModel *model = [informationModel new];
            model.provinceName = @"";
            model.cityName = @"";
            model.organizationName = @"";
            model.workStartDate = @"";
            model.workEndDate = @"";
            model.position = @"";
            [self.infoModelArr addObject:model];
            [comTableView reloadData];
        }
    }
    else
    {
        
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.scrollNum == 2)
    {
        return self.modelArr.count;
    }
    else  if (self.scrollNum == 1)
    {
        return self.infoModelArr.count;
    }
    else
    {
        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollNum == 2)
    {
        return 121;
    }
    else  if (self.scrollNum == 1)
    {
        return 230;
    }
    else
    {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollNum == 2)
    {
        EventTableViewCell *cell = [EventTableViewCell cellWithTableView:tableView];
//        informationModel *model = [self.infoModelArr objectAtIndex:indexPath.row];
        informationModel *model = self.modelArr[indexPath.row];
        cell.dateText.text = model.footprintTime;
        cell.eventText.text = model.incident;
        [cell.addBtn addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
        cell.delBtn.tag = indexPath.row;
        [cell.delBtn addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.infoModel = model;
        return cell;
    }
    else if (self.scrollNum == 1)
    {
        CareerTableViewCell *cell = [CareerTableViewCell cellWithTableView:tableView];
        //    informationModel *model = [informationModel new];
        //        model = [self.infoModelArr objectAtIndex:indexPath.row];
        informationModel *model = [informationModel objectWithKeyValues:[self.modelArr objectAtIndex:indexPath.row]];
        cell.proviceText.text = model.provinceName;
        cell.cityText.text = model.cityName;
        cell.sectionText.text = model.organizationName;
        
        cell.dateText1.text = [common sectionStrByCreateTime:model.workStartDate.doubleValue];
        cell.dateText2.text = [common sectionStrByCreateTime:model.workEndDate.doubleValue];
        cell.branchText.text = model.position;
        
        [cell.addBtn addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
        cell.delBtn.tag = indexPath.row;
        [cell.delBtn addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.infoModel = model;
        
        return cell;
    }
    else
    {
        return nil;
    }
    
    
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
