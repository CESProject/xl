//
//  AchievementViewController.m
//  Creative
//
//  Created by Mr Wei on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
// ************ 成果 **********

#import "AchievementViewController.h"
#import "UIView+MJExtension.h"
#import "UIImageView+WebCache.h"
#import "common.h"

@interface AchievementViewController ()

@property (nonatomic , weak)UIImageView *iconImage;

@property(nonatomic,weak)UILabel *nameLab;
@property(nonatomic,weak)UILabel *lblCon;
@property(nonatomic,weak)UILabel *lblDate;
@property(nonatomic,weak)UIImageView *im;

@property(nonatomic,assign)BOOL isHide;
@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,weak)UIImageView *imClock;


@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,copy)NSString *strCon;
@property(nonatomic,copy)NSString *strDate;
@property(nonatomic,copy)NSString *strImg;
@property(nonatomic,copy)NSString *strd;

@end

@implementation AchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titl;
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)"];
    
    UIWebView *webview = [[UIWebView alloc] init];
    webview.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    [webview loadHTMLString:self.contentStr baseURL:nil];
    [self.view addSubview:webview];
    

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
