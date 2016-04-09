//
//  SignUpViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/3.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "SignUpViewController.h"
#import "PersonSignUpView.h"
#import "UIView+MJExtension.h"
#import "Model.h"
#import "CommponyView.h"
#import "common.h"

@interface SignUpViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)UIScrollView *sc;
@property (nonatomic , strong) UIButton *personBtn;
@property (nonatomic , strong) UIButton *companyBtn;
@property (nonatomic , strong) PersonSignUpView *personView; // 个人
@property (nonatomic , strong) CommponyView *commponyView; // 企业
@property(nonatomic,assign)CGFloat scHeight;
@property (nonatomic , strong) MBProgressHUD *hud;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报名";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    self.navigationController.navigationBarHidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.hud = [common createHud];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 64)];
    btnView.backgroundColor = [UIColor whiteColor];
    
    
    
    self.personBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.personBtn setTitle:@"个人投资人" forState:UIControlStateNormal];
    self.personBtn.tintColor = [UIColor blackColor];
    [self.personBtn addTarget:self action:@selector(personBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.personBtn setFrame:CGRectMake(0, 0,(btnView.mj_w - 1) / 2 , btnView.mj_h)];
    self.personBtn.backgroundColor = [UIColor whiteColor];
    
    [btnView addSubview:self.personBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.personBtn.mj_x + self.personBtn.mj_w , 6, 1, 50)];
    lineView.backgroundColor = [UIColor grayColor];
    [btnView addSubview:lineView];
    
    self.companyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.companyBtn setTitle:@"企业投资人" forState:UIControlStateNormal];
    self.companyBtn.tintColor = [UIColor blackColor];
    [self.companyBtn addTarget:self action:@selector(companyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.companyBtn setFrame:CGRectMake(self.personBtn.mj_x + self.personBtn.mj_w + 1, 0,(btnView.mj_w - 2) / 2 , btnView.mj_h)];
    self.companyBtn.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:self.companyBtn];
    [self.view addSubview:btnView];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, btnView.mj_h + btnView.mj_y, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    sc.bounces = NO;
    sc.pagingEnabled = YES;
    
    PersonSignUpView *personView = [[PersonSignUpView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    personView.name.tag = 101;
    personView.name.delegate = self;
    personView.identity.tag = 102;
    personView.identity.delegate = self;
    personView.phone.tag = 103;
    personView.phone.delegate = self;
    personView.QQnum.tag = 104;
    personView.QQnum.delegate = self;
    personView.Emailnum.tag = 105;
    personView.Emailnum.delegate = self;
    personView.weiNum.tag = 106;
    personView.weiNum.delegate = self;
    
    [personView.sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    personView.sureBtn.tag = 101;
    
    
    [personView.cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    personView.cancleBtn.tag = 102;
    
    [sc addSubview:personView];
    self.personView = personView;
    
    CommponyView *commpanoyView = [[CommponyView alloc]initWithFrame:CGRectMake(personView.mj_w, personView.mj_y, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [sc addSubview:commpanoyView];
    
    [commpanoyView.cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [commpanoyView.sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    commpanoyView.sureBtn.tag = 103;
    commpanoyView.cancleBtn.tag = 104;
    self.commponyView = commpanoyView;
    
    
    
    
    [self.view addSubview:sc];
    self.sc = sc;
    self.sc.contentSize = CGSizeMake(self.view.mj_w * 2,self.personView.mj_h + self.personView.mj_y + 50);
}

/**
 * 个人投资
 */
- (void)personBtnAction
{
    [self.sc setContentOffset:CGPointMake(0, 0) animated:YES];
}

/**
 * 企业投资
 */
- (void)companyBtnAction
{
    [self.sc setContentOffset:CGPointMake(self.view.mj_w, 0) animated:YES];
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
    //    if (ff.height < self.scHeight + keyboardH) {
    ff.height += keyboardH;
    self.sc.contentSize = ff;
    //    }
    
    
    
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

- (void)sureBtnAction:(UIButton *)sender
{
    if (sender.tag == 101) {
        
        
        self.personView.sureBtn.enabled = NO;
        
        
        if ([self.personView.name.text isEqualToString: @""]) {
            showAlertView(@"姓名不能为空");
            self.personView.sureBtn.enabled = YES;
            return;
        }
        NSString *pattern = @"([1-9]\\d{5}[1-2]\\d{3}[0-1]\\d[0-3]\\d{4}(x|X|\\d))|([1-9]\\d{5}\\d{2}[0-1]\\d[0-3]\\d{3}(x|X|\\d))";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isIDcard = [pred evaluateWithObject:self.personView.identity.text];
        if ([self.personView.identity.text isEqualToString:@""]) {
            showAlertView(@"身份证号不能为空");
            self.personView.sureBtn.enabled = YES;
            return;
        }
        else if (isIDcard == NO)
        {
            showAlertView(@"身份证号格式不正确");
            self.personView.sureBtn.enabled = YES;
            return;
        }
        BOOL isPhone = [Model checkInputMobile:self.personView.phone.text];
        if ([self.personView.phone.text isEqualToString:@""]) {
            showAlertView(@"联系电话不能为空");
            self.personView.sureBtn.enabled = YES;
            return;
        }
        else if (isPhone == NO)
        {
            showAlertView(@"联系电话格式不正确");
            self.personView.sureBtn.enabled = YES;
            return;
        }
//            BOOL isEmail = [Model validateEmail:self.personView.Emailnum.text];
//            if ([self.personView.Emailnum.text isEqualToString:@""]) {
//                showAlertView(@"邮箱不能为空");
//                self.personView.sureBtn.enabled = YES;
//                return;
//            }
//            else if (isEmail == NO)
//            {
//                showAlertView(@"邮箱格式不正确");
//                self.personView.sureBtn.enabled = YES;
//                return;
//            }
//            if ([self.personView.QQnum.text isEqualToString:@""]) {
//                showAlertView(@"QQ号不能为空");
//                self.personView.sureBtn.enabled = YES;
//                return;
//            }
//            if ([self.personView.weiNum.text isEqualToString:@""]) {
//                showAlertView(@"微信号不能为空");
//                self.personView.sureBtn.enabled = YES;
//                return;
//            }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.personView.name.text forKey:@"name"];
        [dic setObject:self.personView.identity.text forKey:@"identityCardNo"];
        [dic setObject:self.personView.phone.text forKey:@"cellphone"];
        if (self.personView.Emailnum.text)
        {
            
            [dic setObject:self.personView.Emailnum.text forKey:@"email"];
        }
        if (self.personView.QQnum.text) {
            
            [dic setObject:self.personView.QQnum.text forKey:@"qq"];
        }
        if (self.personView.weiNum.text) {
            
            [dic setObject:self.personView.weiNum.text forKey:@"wechat"];
        }
        [dic setObject:@(0) forKey:@"type"];
        //    [dic setObject:@"" forKey:@"businessLicence"]; //营业执照
        [dic setObject:self.roadShowId forKey:@"roadshowId"]; // 路演id
        if (self.roadShowId.length!=0) {
            WEAKSELF;
            [self.hud show:YES];
            [[HttpManager defaultManager] postRequestToUrl:DEF_LYSINGUP params:dic complete:^(BOOL successed, NSDictionary *result) {
                //
                NSLog(@"%@", result);
                if ([result isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"code"] isEqualToString:@"10000"]) {
                        showAlertView(result[@"报名成功"]);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                        self.personView.sureBtn.enabled = YES;
                    }
                    else
                    {
                        showAlertView(result[@"msg"]);
                        self.personView.sureBtn.enabled = YES;
                    }
                }
                
                [self.hud hide:YES];
                self.personView.sureBtn.enabled = YES;
            }];

        }
        else
        {
            WEAKSELF;
            [self.hud show:YES];
            [[HttpManager defaultManager] postRequestToUrl:DEF_HDSINGUP params:@{@"name":self.personView.name.text,@"cellphone":self.personView.phone.text,@"email":self.personView.Emailnum.text,@"num":@"5",@"activityId":self.activeId} complete:^(BOOL successed, NSDictionary *result) {
                //
                NSLog(@"%@", result);
                if ([result isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"code"] isEqualToString:@"10000"]) {
//                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                        weakSelf.personView.sureBtn.enabled = YES;
                    }
                    else
                    {
                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        weakSelf.personView.sureBtn.enabled = YES;
                    }
                }
                
                [self.hud hide:YES];
                self.personView.sureBtn.enabled = YES;
            }];

        }
        
    }
    else
    {
        showAlertView(@"企业报名尚未开放");
        self.personView.sureBtn.enabled = YES;
    }
}

- (void)cancleBtnAction:(UIButton *)sender
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
