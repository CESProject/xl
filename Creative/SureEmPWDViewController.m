//
//  SureEmPWDViewController.m
//  Creative
//
//  Created by Mr Wei on 15/12/30.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "SureEmPWDViewController.h"
#import "Model.h"

@interface SureEmPWDViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UITextField *pwdText;

@property (weak, nonatomic) IBOutlet UITextField *checkPwdText;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SureEmPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sureBtn.layer.borderColor = COMColor(74, 189, 50, 1.0).CGColor;
    self.sureBtn.clipsToBounds = YES;
    self.sureBtn.layer.borderWidth = 1.0;
    self.sureBtn.layer.cornerRadius = 4;
}
- (IBAction)SureAction:(id)sender
{
    
    self.sureBtn.enabled = NO;
    BOOL isOk =[Model validateEmail:self.emailText.text];
    if (isOk==NO)
    {
        self.sureBtn.enabled = YES;
        showAlertView(@"邮箱格式不正确");
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
