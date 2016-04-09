//
//  ParTenViewController.m
//  Creative
//
//  Created by Mr Wei on 16/2/1.
//  Copyright © 2016年 王文静. All rights reserved.
//*****************  项目投资  ***********************

#import "ParTenViewController.h"

#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11

@interface ParTenViewController ()

@end

@implementation ParTenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    
    //    self.numArray= [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"back"];
    self.navigationItem.leftBarButtonItems = @[back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    
    
    for (int i=0; i<self.numArray.count; i++)
    {
        CGRect frame;
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:self.numArray[i] forState:UIControlStateNormal];//设置title
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        Btn.tag = i;
        frame.size.width = BUTTONWIDTH;//设置按钮坐标及大小
        frame.size.height = BUTTONHEIGHT;
        frame.origin.x = 20 +(i%3)*(BUTTONWIDTH + 10);
        frame.origin.y = 80 +(i/3)*(BUTTONHEIGHT + 10);
        [Btn setFrame:frame];
        Btn.layer.borderColor = [UIColor grayColor].CGColor;
        Btn.layer.borderWidth = 1.0f;
        Btn.layer.cornerRadius = 5;
        Btn.layer.masksToBounds = YES;
        Btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn addTarget:self action:@selector(selectBthClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Btn];
    }
    
}
- (void)selectBthClick:(UIButton *)button
{
    NSDictionary *dic = @{
                          @"nature":button.titleLabel.text
                          };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tenderJieDuan" object:nil userInfo:dic];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)backClick
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
