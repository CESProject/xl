//
//  LoginViewController.m
//  Creative
//
//  Created by huahongbo on 15/12/29.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "LoginViewController.h"
#import "Model.h"
#import "RegisterViewController.h"
#import "User.h"

@interface LoginViewController ()

@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户登录";
    
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backButton) image:@"分享.png"];
    self.navigationItem.leftBarButtonItems = @[back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    
    [self creatLoginView];
    
    self.hud = [common createHud];
    
}
- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatLoginView
{
    UIImageView *nameImg = [[UIImageView alloc] init];
    nameImg.frame = CGRectMake(10, 100, 25, 25);
        nameImg.image = [UIImage imageNamed:@"login (2)"];
//    nameImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:nameImg];
    
    nameTF = [[UITextField alloc] init];
    nameTF.frame = CGRectMake([nameImg right]+10, nameImg.frame.origin.y, self.view.frame.size.width*0.8,30);
    nameTF.borderStyle = 0;
    nameTF.placeholder = @"手机号";
    nameTF.delegate = self;
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:nameTF];
    
    UIImageView *pswImg = [[UIImageView alloc] init];
    pswImg.frame = CGRectMake(nameImg.frame.origin.x, [nameTF bottom]+50, 25, 25);
        pswImg.image = [UIImage imageNamed:@"login (1)"];
//    pswImg.backgroundColor = [UIColor blueColor];
    [self.view addSubview:pswImg];
    
    passwordTF = [[UITextField alloc] init];
    passwordTF.frame = CGRectMake(nameTF.frame.origin.x, pswImg.frame.origin.y,nameTF.frame.size.width,nameTF.frame.size.height);
    passwordTF.secureTextEntry = YES;
    passwordTF.borderStyle = 0;
    passwordTF.placeholder = @"密码";
    passwordTF.delegate = self;
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:passwordTF];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(nameImg.frame.origin.x, [passwordTF bottom]+100, DEF_SCREEN_WIDTH-20, 40);
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setBackgroundColor:GREENCOLOR];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seeBtn.frame = CGRectMake(loginBtn.frame.origin.x,[loginBtn bottom]+10, loginBtn.frame.size.width, loginBtn.frame.size.height);
    [seeBtn setTitle:@"注册" forState:UIControlStateNormal];
    seeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    seeBtn.layer.borderColor = GREENCOLOR.CGColor;
    seeBtn.layer.borderWidth = 1.0f;
    seeBtn.layer.cornerRadius = 5;
    seeBtn.layer.masksToBounds = YES;
    [seeBtn setTitleColor:GREENCOLOR forState:UIControlStateNormal];
    [seeBtn setBackgroundColor:[UIColor whiteColor]];
    [seeBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeBtn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.center = CGPointMake(DEF_SCREEN_WIDTH/2, [seeBtn bottom]+30);
    forgetBtn.bounds = CGRectMake(0, 0, 100, 20);
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];

}
- (void)loginClick
{
    if (NETWORKEROR)
    {
        showAlertView(@"当前无网络连接");
        return;
    }
    if ([nameTF.text isEqualToString:@""]||[passwordTF.text isEqualToString:@""])
    {
        showAlertView(@"手机号或密码为空");
        return;
    }
    [self.hud show:YES];
    [self.view endEditing:YES];
    [self AFNetLoad];
}
- (void)AFNetLoad
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:@"time"];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_LOGIN params:@{@"username":nameTF.text,@"password":passwordTF.text} complete:^(BOOL successed, NSDictionary *result) {
        if (successed) {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                User *user = [[User alloc] init];
                user.userId = result[@"id"];
                user.loginName = result[@"loginName"];
                user.imageDiyBgVo = result[@"imageDiyBgVo"];
                user.userName =nameTF.text;
                user.password =passwordTF.text;
                [[NSUserDefaults standardUserDefaults]setObject:nameTF.text forKey:@"username"];
                [[NSUserDefaults standardUserDefaults]setObject:passwordTF.text forKey:@"userpass"];
                [HMFileManager saveObject:user byFileName:@"User"];
                [Model setLoginOk];
                [Model openMainVC];
            }else
            {
                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            }
        }
        [weakSelf.hud hide:YES];
    }];
}

- (void)registerClick
{
    RegisterViewController *regisVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regisVC animated:YES];
}
- (void)forgetClick
{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
