//
//  AddPerViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "AddPerViewController.h"
#import "UIView+MJExtension.h"
#import "UIBarButtonItem+Extension.h"

@interface AddPerViewController ()

@end

@implementation AddPerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加乘客";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(saveAction) withTitle:@"保存"];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 64,self.view.mj_w , 81)];
    UITextField *nameText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, whiteView.mj_w, 40)];
    nameText.placeholder = @"姓名";
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, nameText.mj_h, whiteView.mj_w, 1)];
    [self.view addSubview:line];
    
    UITextField *idCardText = [[UITextField alloc]initWithFrame:CGRectMake(0, nameText.mj_h + 1, whiteView.mj_w, 40)];
    idCardText.placeholder = @"身份证号";
    [self.view addSubview:idCardText];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
// 保存
- (void)saveAction
{
    
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
