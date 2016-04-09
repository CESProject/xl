//
//  NewsViewController.m
//  ceshi
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import "NewsViewController.h"
#import "UITextView+placeholder.h"
#import "UIView+MJExtension.h"

@interface NewsViewController ()<UIAlertViewDelegate>
{
    UITextView *textView;
    UIButton *senderBtn;
    UIButton *cancleBtn;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发私信";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 80, self.view.mj_w - 20,self.view.mj_h/ 5 )];
    textView.placeholder = @"请输入私信内容";
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 4;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    senderBtn.layer.cornerRadius = 5;
    senderBtn.layer.borderWidth = 1;
    [senderBtn setTitle:@"发送" forState:UIControlStateNormal];
    [senderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [senderBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [senderBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [senderBtn setFrame:CGRectMake(40, [textView bottom]+40, (DEF_SCREEN_WIDTH -100) /2, 40)];
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_FASIXIN params:@{@"receiverId":self.userInfoId,@"content":textView.text} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([result[@"code"] isEqualToString:@"10000"])
            {
                [MBProgressHUD showSuccess:@"发送成功" toView:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            
            }
        }
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    
}
- (void)cancelClick
{
    cancleBtn.selected = YES;
    senderBtn.selected = NO;
    cancleBtn.layer.borderColor = [UIColor greenColor].CGColor;
    senderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.text = @"";
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
