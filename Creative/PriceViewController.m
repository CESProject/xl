//
//  PriceViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PriceViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "Model.h"

@interface PriceViewController ()<UITextFieldDelegate>

@property (nonatomic , strong)  UITextField *nameText;
@property (nonatomic , strong)  UITextField *phoneNum;

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"立刻询价";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(alterAction) withTitle:@"提交"];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_w, 80)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UITextField *nameText = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.mj_w - 20, 30)];
    nameText.placeholder = @"请输入你的称呼";
    nameText.delegate = self;
    [titleView addSubview:nameText];
    self.nameText = nameText;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(nameText.mj_x, nameText.mj_y + nameText.mj_h, nameText.mj_w, 1)];
    line.backgroundColor = [UIColor grayColor];
    [titleView addSubview:line];
    
    UITextField *phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(nameText.mj_x, nameText.mj_y + nameText.mj_h + 10, nameText.mj_w, 30)];
    phoneNum.placeholder = @"请输入你的联系电话";
    [titleView addSubview:phoneNum];
    self.phoneNum = phoneNum;
    [self.view addSubview:titleView];
    
}

#pragma mark - textField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
    
    if ([self.phoneNum.text isEqualToString:@""]) {
        showAlertView(@"手机号不能为空");
        return;
    }
    BOOL isOk =[Model checkInputMobile:self.phoneNum.text];
    if (isOk==NO)
    {
        showAlertView(@"手机号格式不正确");
        return;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAOPLACEENQUIRY params:@{@"placeId":self.strID,@"appellation":self.nameText.text,@"phoneNumber":self.phoneNum.text} complete:^(BOOL successed, NSDictionary *result) {
        
        //        NSLog(@"DEF_ZHAOPLACEENQUIRY %@",result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"code"] isEqualToString:@"10000"])
            {
//                showAlertView(@"询价成功");
                [MBProgressHUD showSuccess:@"询价成功" toView:nil];
                [weakSelf back];
            }
            else
            {
                showAlertView(@"询价失败");
            }
        }
        else
        {
            showAlertView(@"询价失败");
        }
    }];
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
