//
//  SmallSecretaryViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "SmallSecretaryViewController.h"
#import "AppDelegate.h"
#import "KeHuViewController.h"
@interface SmallSecretaryViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation SmallSecretaryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"小秘书";
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.hud = [common createHud];
    [self.hud hide:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.hud show:YES];
     NSString *urlStr =request.URL.absoluteString;
    if ([urlStr isEqualToString:DEF_XIAOMISHU])
    {
        return YES;
    }else
    {
        KeHuViewController *khVC = [[KeHuViewController alloc] init];
        khVC.urlCont = request.URL.absoluteString;
        [self.navigationController pushViewController:khVC animated:NO];
        return NO;
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.hud hide:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self.hud hide:YES];
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
    self.title = @"小秘书";
    UIWebView *web =[common creatWebViewUrlName:DEF_XIAOMISHU control:self frame:CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64)];
    web.delegate = self;
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
