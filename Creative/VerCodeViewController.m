//
//  VerCodeViewController.m
//  Creative
//
//  Created by Mr Wei on 15/12/30.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "VerCodeViewController.h"
#import "Model.h"
#import "EmailPWDViewController.h"
#import "common.h"
@interface VerCodeViewController ()<UITextFieldDelegate>
{
    UITextField *phone;
    
}

@property (nonatomic , strong) UILabel *timeLab; // 显示时间
@property (nonatomic , strong) UIButton *nextBtn;
@property (nonatomic , strong) UIButton *codeBtn;
@property (nonatomic , strong) MBProgressHUD *hud;
@end

@implementation VerCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.hud = [common createHud];
    
    [self creatView];
}

- (void)creatView
{
    
    [self startTimer];
    NSString *labText = [NSString stringWithFormat:@"短信验证码已发送至 %@",self.phoneNum];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, DEF_SCREEN_WIDTH-50, 40)];
    lab.text = @"您收到的短信验证码是什么？";
    lab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:lab];
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, [lab bottom]+5, DEF_SCREEN_WIDTH-50, 30)];
    la.text = labText;
    la.font = [UIFont systemFontOfSize:12];
    la.textColor = [UIColor grayColor];
    [self.view addSubview:la];
    
    phone = [[UITextField alloc] initWithFrame:CGRectMake(lab.frame.origin.x, [la bottom]+30, self.view.frame.size.width - lab.frame.origin.x * 2, 30)];
    UIColor *color = [UIColor orangeColor];
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    phone.borderStyle = UITextBorderStyleBezel;//UITextBorderStyleLine
//    phone.keyboardType =  UIKeyboardTypeNumberPad;
    phone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: color}];
    
    phone.delegate = self;
    phone.tag = 101;
    [self.view addSubview:phone];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(phone.frame.origin.x, [phone bottom], [phone width], 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(phone.frame.origin.x,[phone bottom]+60, DEF_SCREEN_WIDTH-lab.frame.origin.x*2, 50);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    nextBtn.layer.borderColor = GREENCOLOR.CGColor;
    nextBtn.layer.borderWidth = 1.0f;
    nextBtn.layer.cornerRadius = 5;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn setTitleColor:GREENCOLOR forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor whiteColor]];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    self.nextBtn = nextBtn;
    
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame = CGRectMake(phone.frame.origin.x,[phone bottom]+60, DEF_SCREEN_WIDTH-lab.frame.origin.x*2, 50);
    [codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    codeBtn.layer.borderColor = GREENCOLOR.CGColor;
    codeBtn.layer.borderWidth = 1.0f;
    codeBtn.layer.cornerRadius = 5;
    codeBtn.layer.masksToBounds = YES;
    [codeBtn setTitleColor:GREENCOLOR forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:[UIColor whiteColor]];
    [codeBtn addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.hidden = YES;
    [self.view addSubview:codeBtn];
    self.codeBtn = codeBtn;
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, [nextBtn bottom]+5, DEF_SCREEN_WIDTH-50, 30)];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textColor = [UIColor grayColor];
    timeLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLab];
    self.timeLab = timeLab;
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapAction
{
    [phone resignFirstResponder];
}
- (void)nextClick
{
    if ([phone.text isEqualToString:@""])
    {
        showAlertView(@"验证码为空");
        return;
    }
    //    else
    //    {
    //        showAlertView(@"请输入正确的验证码");
    //        return;
    //    }
    
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_CHECKVALIDATECODE params:@{@"phoneNumber":self.phoneNum,@"validateCode":phone.text} complete:^(BOOL successed, NSDictionary *result) {
        NSLog(@"%@",result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"code"] isEqualToString:@"10000"])
            {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                EmailPWDViewController *guide = [sb instantiateViewControllerWithIdentifier:@"EmailPWD"];
                guide.usePhoneNum = weakSelf.phoneNum;
                [weakSelf.navigationController pushViewController:guide animated:YES];
                
            }
            else if ([result[@"code"] isEqualToString:@"10001"])
            {
                showAlertView(result[@"msg"]);
            }
            else
            {
                showAlertView(@"验证码发送失败");
            }
        }
        
        [weakSelf.hud hide:YES];
    }];
}


- (void)startTimer
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout < 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.nextBtn.hidden = YES;
                self.codeBtn.hidden = NO;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.timeLab.text = [NSString stringWithFormat:@"%@秒 后重新发送",strTime];
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
- (void)sendCodeAction:(UIButton *)sender
{
    [self startTimer];
    self.codeBtn.hidden = YES;
    self.nextBtn.hidden = NO;
    WEAKSELF;
    NSString *url = [NSString stringWithFormat:@"/%@",self.phoneNum];
    NSString *url1 = [DEF_VALIDATECODE stringByAppendingString:url];
    [self.hud show:YES];
    [[HttpManager defaultManager] getRequestToUrl:url1 params:nil complete:^(BOOL successed, NSDictionary *result) {
        
        NSLog(@"%@",result);
        if ([result isKindOfClass:[NSDictionary class]])
        {
            if ([result[@"code"] isEqualToString:@"10000"])
            {
                
                
            }
            else if ([result[@"code"] isEqualToString:@"10001"])
            {
                showAlertView(@"该用户已被注册");
            }
            else
            {
                showAlertView(@"验证码请求失败");
            }
        }
        [weakSelf.hud hide:YES];
        
    }];
    
}
#pragma mark - textFiled Delegate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//            if ([textField.text length] >= 6)
//            {
//                return NO;
//            }
//            else
//            {
//                return YES;
//            }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
