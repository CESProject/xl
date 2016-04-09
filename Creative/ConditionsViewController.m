//
//  ConditionsViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/10.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ConditionsViewController.h"

@interface ConditionsViewController ()

@end

@implementation ConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GRAYCOLOR;
    self.title = @"入孵条件";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, DEF_SCREEN_WIDTH-20, DEF_SCREEN_HEIGHT/3)];
    img.backgroundColor = [UIColor grayColor];
    [view addSubview:img];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(img.mj_x, [img bottom]+5, img.mj_w, 100)];
    lab.text = @"11111111111";
    lab.backgroundColor = [UIColor yellowColor];
    [view addSubview:lab];
    
    view.frame = CGRectMake(0, 65, DEF_SCREEN_WIDTH, img.mj_h+lab.mj_h+45);
    [self.view addSubview:view];
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
