//
//  RegisterViewController.m
//  Creative
//
//  Created by huahongbo on 15/12/30.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "RegisterViewController.h"
#import "Model.h"
#import "VerCodeViewController.h"
#import "PatterClass.h"
#import "common.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField *phone;
}
@property(nonatomic , weak)UIImageView *correctImg;
/// 图形验证属性
@property (nonatomic , strong) PatterClass *patterClass;
@property (nonatomic , strong) UIButton *nextBtn;
@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;
@property (nonatomic , strong) MBProgressHUD *hud;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backButton) image:@"back"];
    self.navigationItem.leftBarButtonItems = @[back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    self.hud = [common createHud];
    
    [self creatView];
}
- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIImageView *)correctImg
{
    if (!_correctImg)
    {
        UIImageView *corImg = [[UIImageView alloc] init];
        corImg.frame = CGRectMake(DEF_SCREEN_WIDTH-10-30, phone.frame.origin.y, 30, 30);
        corImg.image = [UIImage imageNamed:@""];
        corImg.hidden = YES;
        self.correctImg = corImg;
    }
    return _correctImg;
}
- (void)creatView
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, DEF_SCREEN_WIDTH-50, 40)];
    lab.text = @"您的电话号码是什么？";
    lab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:lab];
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, [lab bottom]+10, DEF_SCREEN_WIDTH-50, 30)];
    la.text = @"请不要担心，您的号码是默认保密的";
    la.font = [UIFont systemFontOfSize:12];
    la.textColor = [UIColor grayColor];
    [self.view addSubview:la];
    
    phone = [[UITextField alloc] initWithFrame:CGRectMake(lab.frame.origin.x, [la bottom]+60, DEF_SCREEN_WIDTH-50, 30)];
    UIColor *color = [UIColor orangeColor];
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    phone.keyboardType =  UIKeyboardTypeNumberPad;
    phone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:phone];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(lab.frame.origin.x, [phone bottom], DEF_SCREEN_WIDTH-50, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(phone.frame.origin.x,[phone bottom]+10, DEF_SCREEN_WIDTH-lab.frame.origin.x*2, 50);
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapAction
{
    [phone resignFirstResponder];
}
- (void)nextClick
{
    self.nextBtn.enabled = NO;
    [phone resignFirstResponder];
    if (NETWORKEROR)
    {
        showAlertView(@"当前无网络连接");
        self.nextBtn.enabled = YES;
        return;
    }
    if ([phone.text isEqualToString:@""])
    {
        showAlertView(@"手机号为空");
        self.nextBtn.enabled = YES;
        return;
    }
    BOOL isOk =[Model checkInputMobile:phone.text];
    if (isOk==NO)
    {
        showAlertView(@"手机号格式不正确");
        self.nextBtn.enabled = YES;
        return;
    }
    
    // 添加图形验证
    [self addPatterVerification];
    
//    [self sureButtonAction:nil];
    
    
}

- (void)addPatterVerification
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
    scroll.backgroundColor = [UIColor grayColor];
    scroll.alpha = 0.5;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    
    self.patterClass = [[PatterClass alloc]initWithFrame:CGRectMake(40, 100, CGRectGetWidth(self.view.frame)-80, 200)];
    self.patterClass.center = self.view.center;
    
    [self.patterClass.sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.patterClass.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.patterClass.layer.masksToBounds = YES;
    self.patterClass.layer.cornerRadius = 9;
    self.patterClass.input.delegate = self;
    
    [self.view addSubview:scroll];
    [self.view addSubview:_patterClass];
    self.sc = scroll;
    
}


- (void)sureButtonAction:(UIButton *)sender
{
    
    //判断输入的字符串和系统生成的验证码是否相同（不包含大小写）
    if ([self.patterClass.input.text compare:self.patterClass.codeView.changeString options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame) {
        NSLog(@"验证成功");
        //发送验证码
        [self.patterClass removeFromSuperview];
        [self.sc removeFromSuperview];
        //发送手机号
        NSString *url = [NSString stringWithFormat:@"/%@",phone.text];
        NSString *url1 = [DEF_VALIDATECODE stringByAppendingString:url];
        WEAKSELF;
        [self.hud show:YES];
        [[HttpManager defaultManager] getRequestToUrl:url1 params:nil complete:^(BOOL successed, NSDictionary *result) {
            
            NSLog(@"%@",result);
            if ([result isKindOfClass:[NSDictionary class]])
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {// 请求验证码成功
                    weakSelf.correctImg.hidden = NO;
                    [weakSelf.view endEditing:YES];
                    VerCodeViewController *verCodeVc = [[VerCodeViewController alloc]init];
                    verCodeVc.phoneNum = phone.text;
                    [weakSelf.navigationController pushViewController:verCodeVc animated:YES];
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
            weakSelf.nextBtn.enabled = YES;
        }];
        
        
    }
    else
    {
        self.nextBtn.enabled = YES;
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"请输入正确的验证码" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [self.patterClass.codeView.layer addAnimation:anim forKey:nil];
        [self.patterClass.input.layer addAnimation:anim forKey:nil];
    }
}
- (void)cancelButtonAction:(UIButton *)sender
{
    self.nextBtn.enabled = YES;
    [self.patterClass.input resignFirstResponder];
    [self.patterClass removeFromSuperview];
    [self.sc removeFromSuperview];
    //    self.view.alpha = 1.0;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([self.patterClass.input.text isEqualToString:toBeString])
    {
        if ([toBeString length] > 4)
        {
            self.patterClass.input.text = [toBeString substringToIndex:4];
        }
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)keyboardShow:(NSNotification *)not
{
    
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    CGFloat textH = self.patterClass.mj_y + self.patterClass.mj_h;
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat translationY = keyboardY - (textH + 50);
    if (textH > keyboardY)
    {
        CGPoint pointCenter;
        pointCenter.x = self.view.center.x;
        pointCenter.y = self.view.center.y + translationY;
        [UIView animateKeyframesWithDuration:duration delay:0.0 options:7 << 16 animations:^{
            self.patterClass.center = CGPointMake(pointCenter.x, pointCenter.y);
        } completion:nil];
        
    }
    
}
- (void)keyboardHide:(NSNotification *)not
{
    NSDictionary *dict = not.userInfo;
    //    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        self.patterClass.center = self.view.center;
    } completion:nil];
    
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
