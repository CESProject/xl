//
//  GovernDetailViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "GovernDetailViewController.h"

@interface GovernDetailViewController ()

@end

@implementation GovernDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找政务";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    [common creatWebViewUrlName:self.goverDet control:self frame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
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
