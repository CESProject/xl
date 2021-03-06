//
//  GovernmentAffairsViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "GovernmentAffairsViewController.h"
#import "GovernDetailViewController.h"
@interface GovernmentAffairsViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
}
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation GovernmentAffairsViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [webView reload];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找政务";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.hud = [common createHud];
    webView = [common creatWebViewUrlName:DEF_ZHAOZHENGWU control:self frame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    webView.delegate = self;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.hud show:YES];
    NSString *urlStr =request.URL.absoluteString;
    if ([urlStr containsString:@"?userId="])
    {
        GovernDetailViewController *goverVC  =[[GovernDetailViewController alloc] init];
        goverVC.goverDet = urlStr;
        [self.navigationController pushViewController:goverVC animated:YES];
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.hud hide:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.hud hide:YES];
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
