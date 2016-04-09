//
//  SupportViewController.m
//  ceshi
//
//  Created by Mr Wei on 16/1/10.
//  Copyright © 2016年 Mr Wei. All rights reserved.
// *******************  我要支持  *************

#import "SupportViewController.h"
#import "UIView+MJExtension.h"
#import "Reward.h"
#import "Model.h"
@interface SupportViewController ()<UITextFieldDelegate>
{
    Reward *reward;
    BOOL isSelect;
    int sure;
}
@property(nonatomic,weak)UIScrollView *sc;
@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *moneyLab;
@property (nonatomic , strong) UITextField *moneText;
@property (nonatomic , strong) UILabel *contLab;
@property (nonatomic , strong) UITextField *contText;
@property (nonatomic , strong) UILabel *transporLab;
@property (nonatomic , strong) UITextField *transporText;
@property (nonatomic , strong) UILabel *quotaLab;
@property (nonatomic , strong) UITextField *quotaText;
@property (nonatomic , strong) UILabel *periodLab;
@property (nonatomic , strong) UITextField *periodText;
@property (nonatomic , strong) UILabel *paymentsLab;
@property (nonatomic , strong) UITextField *paymentsText;
@property (nonatomic , strong) UITextField *receiverText;
@property (nonatomic , strong) UITextField *AddressText;
@property (nonatomic , strong) UITextField *CodeText;
@property (nonatomic , strong) UITextField *phoneText;
@property (nonatomic , strong) UITextField *telephoneText;
@property (nonatomic , strong) UITextField *EmailText;
@property (nonatomic , strong) UITextField *QQText;
@property (nonatomic , strong) UITextField *commLab;
@property (nonatomic , strong) UIButton *checkBtn;
@property (nonatomic , strong) UILabel *commTitleLab;
@property (nonatomic , strong) UILabel *commdetailLab;
@property (nonatomic , strong) UIButton *sureBtn;
@property (nonatomic , strong) UIButton *cancleBtn;
@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sure = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我要支持";
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h / 5 * 2 + 50)];
    
    reward = self.objc.rewardList[0];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.mj_w - 20, 30)];
    titleLab.textColor = [UIColor grayColor];
    titleLab.text = self.objc.name;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, titleLab.mj_y + titleLab.mj_h + 10, self.view.mj_w - 20, 1)];
   
    line.backgroundColor = [UIColor lightGrayColor];
    UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLab.mj_y + titleLab.mj_h + 11, self.view.mj_w / 5, 30)];
    moneyLab.textColor = [UIColor lightGrayColor];
    moneyLab.text = @"支持金额:";
    
    UITextField *moneText = [[UITextField alloc]initWithFrame:CGRectMake(moneyLab.mj_x + moneyLab.mj_w + 10, moneyLab.mj_y,  self.view.mj_w / 5 * 4 - 30, 30)];
    moneText.placeholder =[NSString stringWithFormat:@"%d",reward.supportMoney];
    
    UILabel *contLab = [[UILabel alloc]initWithFrame:CGRectMake(10, moneyLab.mj_y + moneyLab.mj_h + 10, self.view.mj_w / 5, 30)];
    contLab.textColor =[UIColor lightGrayColor];
    contLab.text = @"回报内容:";
    
    UITextField *contText = [[UITextField alloc]initWithFrame:CGRectMake(moneyLab.mj_x + moneyLab.mj_w + 10, contLab.mj_y,  self.view.mj_w / 5 * 4 - 30, 30)];
    contText.placeholder = reward.rewardContent;
    
    
    UILabel *transporLab = [[UILabel alloc]initWithFrame:CGRectMake(10, contLab.mj_y + contLab.mj_h + 10, self.view.mj_w / 5, 30)];
    transporLab.text = @"所需运费:";
    transporLab.textColor = [UIColor lightGrayColor];
    UITextField *transporText = [[UITextField alloc]initWithFrame:CGRectMake(transporLab.mj_x + transporLab.mj_w + 10, transporLab.mj_y,  self.view.mj_w / 5 * 4 - 30, 30)];
    transporText.placeholder = [NSString stringWithFormat:@"%d",reward.carriage];
    
    UILabel *quotaLab = [[UILabel alloc]initWithFrame:CGRectMake(10, transporLab.mj_y + transporLab.mj_h + 10, self.view.mj_w / 5, 30)];
    quotaLab.textColor = [UIColor lightGrayColor];
    quotaLab.text = @"名额限制:";
    
    
    UITextField *quotaText = [[UITextField alloc]initWithFrame:CGRectMake(transporLab.mj_x + transporLab.mj_w + 10, quotaLab.mj_y,  self.view.mj_w / 5 * 4 - 30, 30)];
    quotaText.placeholder = [NSString stringWithFormat:@"%d人",reward.limitNum];
    
    
    
    UILabel *periodLab = [[UILabel alloc]initWithFrame:CGRectMake(10, quotaLab.mj_y + quotaLab.mj_h + 10, self.view.mj_w / 5, 30)];
    periodLab.textColor = [UIColor lightGrayColor];
    periodLab.text = @"回报时间:";
    
    
    UITextField *periodText = [[UITextField alloc]initWithFrame:CGRectMake(transporLab.mj_x + transporLab.mj_w + 10, periodLab.mj_y,  self.view.mj_w / 5 * 4 - 30, 30)];
    periodText.placeholder = [NSString stringWithFormat:@"项目成功结束后%d天内",reward.rewardDay];
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, periodText.mj_y + periodLab.mj_h + 10, self.view.mj_w - 20, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *paymentsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, periodLab.mj_y + periodLab.mj_h + 10, self.view.mj_w / 5, 30)];
    paymentsLab.text = @"结算信息:";
    paymentsLab.textColor =[UIColor lightGrayColor];
    
//    UITextField *paymentsText = [[UITextField alloc]initWithFrame:CGRectMake(transporLab.mj_x + transporLab.mj_w + 10, paymentsLab.mj_y,  self.view.mj_w / 5 * 4 - 30, 30)];
//    paymentsText.backgroundColor = [UIColor grayColor];
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(periodText.mj_x,paymentsLab.mj_y, 70, 30);
    lab.textColor = [UIColor orangeColor];
    lab.text = @"支持资金";
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.frame = CGRectMake([lab right], lab.mj_y, 100, lab.mj_h);
    lab2.textColor = [UIColor lightGrayColor];
    lab2.text = [NSString stringWithFormat:@"%@元  ＋",moneText.placeholder];
    UILabel *lab3 = [[UILabel alloc] init];
    lab3.frame = CGRectMake([lab2 right], lab.mj_y, 40, lab.mj_h);
    lab3.textColor = [UIColor orangeColor];
    lab3.text = @"运费";
    
    UILabel *lab4 = [[UILabel alloc] init];
    lab4.frame = CGRectMake([lab3 right], lab.mj_y, 50, lab.mj_h);
    lab4.textColor = [UIColor lightGrayColor];
    lab4.text = [NSString stringWithFormat:@"%@元",transporText.placeholder];
    
    UILabel *lab5 = [[UILabel alloc] init];
    lab5.frame = CGRectMake(lab.mj_x, [lab bottom], lab.mj_w, lab.mj_h);
    lab5.text = @"应付总额";
    lab5.textColor = [UIColor orangeColor];
    
    int a =reward.supportMoney + reward.carriage;
    UILabel *lab6 = [[UILabel alloc] init];
    lab6.frame = CGRectMake([lab5 right], lab5.mj_y, lab2.mj_w, lab5.mj_h);
    lab6.textColor = [UIColor lightGrayColor];
    lab6.text = [NSString stringWithFormat:@"%d元",a];
    
    lab.font = [UIFont systemFontOfSize:14.0f];
    lab2.font = [UIFont systemFontOfSize:14.0f];
    lab3.font = [UIFont systemFontOfSize:14.0f];
    lab4.font = [UIFont systemFontOfSize:14.0f];
    lab5.font = [UIFont systemFontOfSize:14.0f];
    lab6.font = [UIFont systemFontOfSize:14.0f];
    
    [titleView addSubview:lab];
    [titleView addSubview:lab2];
    [titleView addSubview:lab3];
    [titleView addSubview:lab4];
    [titleView addSubview:lab5];
    [titleView addSubview:lab6];
    
    UITextField *receiverText = [[UITextField alloc]initWithFrame:CGRectMake(10, titleView.mj_y + titleView.mj_h + 10,  self.view.mj_w - 20, 30)];
    receiverText.placeholder = @"收件人姓名";
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(10, receiverText.mj_y + receiverText.mj_h + 10, self.view.mj_w - 20, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *AddressText = [[UITextField alloc]initWithFrame:CGRectMake(10, receiverText.mj_y + receiverText.mj_h + 10,  self.view.mj_w - 20, 30)];
    AddressText.placeholder = @"详细地址";
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(10, AddressText.mj_y + AddressText.mj_h + 10, self.view.mj_w - 20, 1)];
    line4.backgroundColor = [UIColor lightGrayColor];
    
    
    UITextField *CodeText = [[UITextField alloc]initWithFrame:CGRectMake(10, AddressText.mj_y + AddressText.mj_h + 10,  self.view.mj_w - 20, 30)];
    CodeText.placeholder = @"邮件编码";
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(10, CodeText.mj_y + CodeText.mj_h + 10, self.view.mj_w - 20, 1)];
    line5.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, CodeText.mj_y + CodeText.mj_h + 10,  self.view.mj_w - 20, 30)];
    phoneText.placeholder = @"收件人手机";
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(10, phoneText.mj_y + phoneText.mj_h + 10, self.view.mj_w - 20, 1)];
    line6.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *telephoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, phoneText.mj_y + phoneText.mj_h + 10,  self.view.mj_w - 20, 30)];
    telephoneText.placeholder = @"固定电话";
    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(10, telephoneText.mj_y + telephoneText.mj_h + 10, self.view.mj_w - 20, 1)];
    line7.backgroundColor = [UIColor lightGrayColor];
    
    
    UITextField *EmailText = [[UITextField alloc]initWithFrame:CGRectMake(10, telephoneText.mj_y + telephoneText.mj_h + 10,  self.view.mj_w - 20, 30)];
    EmailText.placeholder = @"收件人邮箱";
    UIView *line8 = [[UIView alloc]initWithFrame:CGRectMake(10, EmailText.mj_y + EmailText.mj_h + 10, self.view.mj_w - 20, 1)];
    line8.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *QQText = [[UITextField alloc]initWithFrame:CGRectMake(10, EmailText.mj_y + EmailText.mj_h + 10,  self.view.mj_w - 20, 30)];
    QQText.placeholder = @"收件人QQ";
    UIView *line9 = [[UIView alloc]initWithFrame:CGRectMake(10, QQText.mj_y + QQText.mj_h + 10, self.view.mj_w - 20, 1)];
    line9.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *commLab = [[UITextField alloc]initWithFrame:CGRectMake(10, QQText.mj_y + QQText.mj_h + 10, self.view.mj_w - 20, 30)];
    
    commLab.placeholder = @"备注";
    commLab.textColor = [UIColor lightGrayColor];
    
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBtn setFrame:CGRectMake(10, commLab.mj_y + commLab.mj_h + 10, 20, 20)];
    [checkBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    [checkBtn setBackgroundImage:[UIImage imageNamed:@"note2"] forState:UIControlStateSelected];
    [checkBtn addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *commTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(35, commLab.mj_y + commLab.mj_h + 10, self.view.mj_w - 45, 30)];
    
    commTitleLab.text = @"不需要给我回报，无私奉献";
    commTitleLab.textColor = [UIColor grayColor];
    UILabel *commdetailLab = [[UILabel alloc]initWithFrame:CGRectMake(35, commTitleLab.mj_y + commTitleLab.mj_h + 5, self.view.mj_w - 45, 30)];
    commdetailLab.textColor = [UIColor lightGrayColor];
    commdetailLab.text = @"项目成功后项目发起人将不会给你发送回报";
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setFrame:CGRectMake(30, commdetailLab.mj_y + commdetailLab.mj_h + 10, (self.view.mj_w - 80) / 2, 30)];
    
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 4;
    sureBtn.layer.borderWidth = 1;
    sureBtn.tintColor = GREENCOLOR;
    sureBtn.layer.borderColor = GREENCOLOR.CGColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setFrame:CGRectMake(sureBtn.mj_x + sureBtn.mj_w + 20, commdetailLab.mj_y + commdetailLab.mj_h + 10, (self.view.mj_w - 80) / 2, 30)];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.layer.cornerRadius = 4;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.tintColor = GREENCOLOR;
    cancleBtn.layer.borderColor = GREENCOLOR.CGColor;
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    receiverText.delegate = self;
    AddressText.delegate = self;
    CodeText.delegate = self;
    phoneText.delegate = self;
    telephoneText.delegate = self;
    EmailText.delegate = self;
    QQText.delegate = self;
    
    self.contLab = contLab;
    self.contText = contText;
    self.moneText = moneText;
    self.moneyLab = moneyLab;
    self.transporLab = transporLab;
    self.transporText = transporText;
    self.quotaLab = quotaLab;
    self.quotaText = quotaText;
    self.periodLab = periodLab;
    self.periodText = periodText;
    self.paymentsLab =  paymentsLab;
    self.receiverText = receiverText;
    self.AddressText = AddressText;
    self.CodeText =  CodeText;
    self.phoneText = phoneText;
    self.telephoneText = telephoneText;
    self.EmailText = EmailText;
    self.QQText = QQText;
    self.commLab = commLab;
    self.checkBtn = checkBtn;
    self.commTitleLab = commTitleLab;
    self.commdetailLab = commdetailLab;
    self.sureBtn = sureBtn;
    self.cancleBtn = cancleBtn;
    
    titleView.backgroundColor = DEF_RGB_COLOR(240, 240, 240);
    self.titleView = titleView;



   
    
    
    [titleView addSubview:titleLab];
    [titleView addSubview:line];
    [titleView addSubview:moneText];
    [titleView addSubview:moneyLab];
    [titleView addSubview:contLab];
    [titleView addSubview:contText];
    [titleView addSubview:transporText];
    [titleView addSubview:transporLab];
    [titleView addSubview:quotaText];
    [titleView addSubview:quotaLab];
    [titleView addSubview:periodText];
    [titleView addSubview:periodLab];
    [titleView addSubview:line2];
//    [titleView addSubview:paymentsText];
    [titleView addSubview:paymentsLab];
    [sc addSubview:CodeText];
    [sc addSubview:receiverText];
    [sc addSubview:line3];
    [sc addSubview:AddressText];
    [sc addSubview:line4];
    [sc addSubview:line5];
    [sc addSubview:phoneText];
    [sc addSubview:line6];
    [sc addSubview:telephoneText];
    [sc addSubview:line7];
    [sc addSubview:EmailText];
    [sc addSubview:line8];
    [sc addSubview:QQText];
    [sc addSubview:line9];
    [sc addSubview:checkBtn];
    [sc addSubview:commLab];
    [sc addSubview:commdetailLab];
    [sc addSubview:commTitleLab];
    [sc addSubview:cancleBtn];
    [sc addSubview:sureBtn];
    
    [sc addSubview:titleView];
    
    sc.contentSize = CGSizeMake(0,sureBtn.mj_h + sureBtn.mj_y + 50);
    self.sc = sc;
    [self.view addSubview:sc];
}
- (void)checkClick:(UIButton *)btn
{
    if (isSelect==NO)
    {
        btn.selected = YES;
        isSelect = YES;
        sure = 0;
    }else
    {
        btn.selected = NO;
        isSelect = NO;
        sure = 1;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)sureBtnClick
{
//    self.sureBtn.enabled = NO;
    if ([self.phoneText.text isEqualToString:@""]||[self.receiverText.text isEqualToString:@""])
    {
        showAlertView(@"手机号为空");
//        self.sureBtn.enabled = YES;
        return;
    }
    BOOL isOk =[Model checkInputMobile:self.phoneText.text];
    if (isOk==NO)
    {
        showAlertView(@"手机号格式不正确");
//        self.sureBtn.enabled = NO;
        return;
    }
    
    if ([self.EmailText.text isEqualToString:@""]) {
        showAlertView(@"邮箱为空");
//        self.sureBtn.enabled = YES;
    }
    BOOL isEmail = [Model validateEmail:self.EmailText.text];
    if (isEmail == NO) {
        showAlertView(@"邮箱格式不正确");
//        self.sureBtn.enabled = NO;
        return;
    }

    NSString *pattern = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self.telephoneText.text];
    
    if (isMatch == NO) {
        showAlertView(@"电话格式不正确");
//        self.sureBtn.enabled = YES;
        return;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_XIANGMUZHICHI params:@{@"engineeringId":self.objc.roadId,@"recipientName":self.receiverText.text,@"provinceId":self.objc.provinceId,@"cityId":self.objc.cityId,@"postcode":self.CodeText.text,@"cellphone":self.phoneText.text,@"telephone":self.telephoneText.text,@"qq":self.QQText.text,@"email":self.EmailText.text,@"engineeringRewardId":reward.zcId,@"address":self.AddressText.text,@"engineeringName":self.objc.name,@"supportMoney":@(reward.supportMoney),@"rewardContent":reward.rewardContent,@"carriage":@(reward.carriage),@"limitNum":@(reward.limitNum),@"rewardDay":@(reward.rewardDay),@"remark":self.commLab.text,@"isNeedReward":@(sure)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([result[@"code"] isEqualToString:@"10000"])
            {
//                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });

            }
        }
    }];
}
- (void)cancleBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
