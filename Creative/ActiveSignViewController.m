//
//  ActiveSignViewController.m
//  Creative
//
//  Created by huahongbo on 16/2/29.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ActiveSignViewController.h"

@interface ActiveSignViewController ()
{
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *titleTF;
    UITextField *msTF;
    UIButton *senderBtn;
    UIButton *cancleBtn;
}
@end

@implementation ActiveSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =DEF_RGB_COLOR(242, 242, 242);
    self.title = @"报名";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self creatView];
}
- (void)creatView
{
    nameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 70, DEF_SCREEN_WIDTH, 30)];
    nameTF.backgroundColor = [UIColor whiteColor];
    nameTF.placeholder = @"姓名";
    [self.view addSubview:nameTF];
    
    phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(0, [nameTF bottom]+1, DEF_SCREEN_WIDTH, 30)];
    phoneTF.backgroundColor = [UIColor whiteColor];
    phoneTF.placeholder = @"联系电话";
    [self.view addSubview:phoneTF];
    
    titleTF = [[UITextField alloc] initWithFrame:CGRectMake(0, [phoneTF bottom]+1, DEF_SCREEN_WIDTH, 30)];
    titleTF.backgroundColor = [UIColor whiteColor];
    titleTF.placeholder = @"Email";
    [self.view addSubview:titleTF];
    
    msTF = [[UITextField alloc] initWithFrame:CGRectMake(0, [titleTF bottom]+1, DEF_SCREEN_WIDTH, 30)];
    msTF.backgroundColor = [UIColor whiteColor];
    msTF.placeholder = @"参加人数";
    [self.view addSubview:msTF];
    
    senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    senderBtn.layer.cornerRadius = 5;
    senderBtn.layer.borderWidth = 1;
    [senderBtn setTitle:@"确定" forState:UIControlStateNormal];
    [senderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [senderBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [senderBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [senderBtn setFrame:CGRectMake(40, [msTF bottom]+100, (DEF_SCREEN_WIDTH -100) /2, 40)];
    [self.view addSubview:senderBtn];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.layer.cornerRadius = 5;
    cancleBtn.layer.borderWidth = 1;
    [cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [cancleBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setFrame:CGRectMake([senderBtn right]+20, senderBtn.mj_y, senderBtn.mj_w, senderBtn.mj_h)];
    [self.view addSubview:cancleBtn];
}
- (void)sureClick
{
    senderBtn.selected = YES;
    cancleBtn.selected = NO;
    senderBtn.layer.borderColor = [UIColor greenColor].CGColor;
    cancleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_HDBAOMING params:@{@"activityId":self.ActivId,@"name":nameTF.text,@"cellphone":phoneTF.text,@"email":titleTF.text,@"num":msTF.text} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([result[@"code"] isEqualToString:@"10000"])
            {
                [MBProgressHUD showSuccess:@"发送成功" toView:weakSelf.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
                
            }else
            {
                [MBProgressHUD showSuccess:result[@"msg"] toView:weakSelf.view];
            }
        }
    }];
}
- (void)cancelClick
{
    cancleBtn.selected = YES;
    senderBtn.selected = NO;
    cancleBtn.layer.borderColor = [UIColor greenColor].CGColor;
    senderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
