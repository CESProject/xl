//
//  ResourcesViewController.m
//  Creative
//
//  Created by huahongbo on 16/2/1.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResourcesViewController.h"
#import "ResMoneyViewController.h"
#import "ResSiteViewController.h"
@interface ResourcesViewController ()

@property(nonatomic, strong) ResMoneyViewController *resMoneyVC;
@property(nonatomic, strong) ResSiteViewController *resSiteVC;

@property(nonatomic, strong) UIViewController *currentVC;
@end

@implementation ResourcesViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _seg = [[UISegmentedControl alloc]initWithItems:@[@"资金", @"场地"]];
        self.navigationItem.titleView = _seg;
        _seg.selectedSegmentIndex = 0;
        [_seg addTarget:self action:@selector(segmentDidChanged:) forControlEvents:UIControlEventValueChanged];
        
        [_seg setWidth:80.0 forSegmentAtIndex:0];
        [_seg setWidth:80.0 forSegmentAtIndex:1];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    self.resMoneyVC = [[ResMoneyViewController alloc]init];
    self.resMoneyVC.view.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64);
    [self addChildViewController:self.resMoneyVC];
    [self.view addSubview:self.resMoneyVC.view];
    self.currentVC = self.resMoneyVC;
    
    
    self.resSiteVC = [[ResSiteViewController alloc]init];
    self.resSiteVC.view.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64);

}
- (void)segmentDidChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        if (self.currentVC == self.resMoneyVC) {
            return;
        }
        [self replaceController:self.currentVC withNewController:self.resMoneyVC];
    }else
    {
        if (self.currentVC == self.resSiteVC) {
            return;
        }
        [self replaceController:self.currentVC withNewController:self.resSiteVC];
    }
}
- (void)replaceController:(UIViewController *)oldController withNewController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            self.currentVC = newController;
        }else
        {
            self.currentVC = oldController;
        }
    }];
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
