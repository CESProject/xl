//
//  ResourceViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResourceViewController.h"
#import "AppDelegate.h"
#import "UIView+MJExtension.h"
#import "ForTeacherViewController.h"
#import "ForMoneyViewController.h"
#import "ForPlaceViewController.h"
#import "MarketingViewController.h"
#import "LegalViewController.h"
#import "GovernmentAffairsViewController.h"

#define ImgH    30
#define Height  50
#define LineH   0.5
#define LineW   self.view.mj_w - 33
@interface ResourceViewController ()

@property (nonatomic , strong)  UIButton *teacherBtn; // 导师
@property (nonatomic , strong)  UIButton *moneyBtn;  // 资金
@property (nonatomic , strong)  UIButton *placeBtn; // 场地
@property (nonatomic , strong)  UIButton *marketBtn; // 营销
@property (nonatomic , strong)  UIButton *judgeBtn; // 法务
@property (nonatomic , strong)  UIButton *governmentBtn; // 政务




@end

@implementation ResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资源库";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = NO;
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    [self initView];
}

- (void)initView
{
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 64, self.view.mj_w, Height) withIcon:@"e-12" withTitle:@"找导师"]];
    self.teacherBtn = [self createBtnWithFrame:CGRectMake(0, 64, self.view.mj_w, Height) wihtAction:@selector(lookForTeacherAction) andTarget:self];
    [self.view addSubview:self.teacherBtn];
    
//
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 64 + Height, self.view.mj_w, Height) withIcon:@"z2" withTitle:@"找资金"]];
    self.moneyBtn = [self createBtnWithFrame:CGRectMake(0, 64 + Height, self.view.mj_w, Height) wihtAction:@selector(lookForMoneyAction) andTarget:self];
    [self.view addSubview:self.moneyBtn];

    
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 64 + Height *2, self.view.mj_w, Height) withIcon:@"z3" withTitle:@"找场地"]];
    self.placeBtn = [self createBtnWithFrame:CGRectMake(0, 64 + Height * 2, self.view.mj_w, Height) wihtAction:@selector(lookForPlaceAction) andTarget:self];
    [self.view addSubview:self.placeBtn];

    
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 64 + Height * 3, self.view.mj_w, Height) withIcon:@"z4" withTitle:@"找营销"]];
    self.marketBtn = [self createBtnWithFrame:CGRectMake(0, 64 + Height * 3, self.view.mj_w, Height) wihtAction:@selector(lookForMarketBtnAction) andTarget:self];
    [self.view addSubview:self.marketBtn];

//
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 64 + Height * 4, self.view.mj_w, Height) withIcon:@"z5" withTitle:@"找法务"]];
    self.judgeBtn = [self createBtnWithFrame:CGRectMake(0, 64 + Height * 4, self.view.mj_w, Height) wihtAction:@selector(lookForJudgeBtnAction) andTarget:self];
    [self.view addSubview:self.judgeBtn];
    
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 64 + Height * 5, self.view.mj_w, Height) withIcon:@"z1" withTitle:@"找政务"]];
    self.governmentBtn = [self createBtnWithFrame:CGRectMake(0, 64 + Height * 5, self.view.mj_w, Height) wihtAction:@selector(lookForgovernmentBtnAction) andTarget:self];
    [self.view addSubview:self.governmentBtn];

   
    
    
}

/**
 *  找导师
 */
- (void)lookForTeacherAction
{
    ForTeacherViewController *techerVC = [[ForTeacherViewController alloc]init];
    [self.navigationController pushViewController:techerVC animated:YES];
}

/**
 * 找资金
 */
- (void)lookForMoneyAction
{
    ForMoneyViewController *moneyVC = [[ForMoneyViewController alloc]init];
    [self.navigationController pushViewController:moneyVC animated:YES];
    
}

/**
 *  找场地
 */
- (void)lookForPlaceAction
{
    ForPlaceViewController *placeVC = [[ForPlaceViewController alloc]init];
    [self.navigationController pushViewController:placeVC animated:YES];
}

/**
 * 找营销
 */
- (void)lookForMarketBtnAction
{
    MarketingViewController *marketVC = [[MarketingViewController alloc] init];
    [self.navigationController pushViewController:marketVC animated:YES];
}
/**
 * 找法务
 */
- (void)lookForJudgeBtnAction
{
    LegalViewController *legalVC = [[LegalViewController alloc] init];
    [self.navigationController pushViewController:legalVC animated:YES];
}

/**
 * 找政务
 */
- (void)lookForgovernmentBtnAction
{
    GovernmentAffairsViewController *goverVC = [[GovernmentAffairsViewController alloc] init];
    [self.navigationController pushViewController:goverVC animated:YES];
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];

}

- (UIButton *)createBtnWithFrame:(CGRect)frame wihtAction:(SEL)action andTarget:(id)target
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (UIView *)createViewWithFrame:(CGRect)frame withIcon:(NSString *)icon withTitle:(NSString *)title
{
    
    UIView *views = [[UIView alloc] initWithFrame:frame];
    views.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icone = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, ImgH, ImgH)];
    icone.image = [UIImage imageNamed:icon];
    
    UIImageView *ims = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.mj_w - 23, 19.5, 7, 11)];
    ims.image = [UIImage imageNamed:@"arrow"];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40, Height - 1, self.view.mj_w - 43, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(43, 15, self.view.mj_w - 100, 20)];
    lblText.text = title;
    lblText.font = [UIFont systemFontOfSize:16.0f];
    lblText.textColor = [UIColor blackColor];
    
    [views addSubview:icone];
    [views addSubview:ims];
    [views addSubview:line];
    [views addSubview:lblText];
    return views;
    
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
