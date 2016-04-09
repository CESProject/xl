//
//  DeliveryViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/20.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "DeliveryViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "DeliverTabCell.h"
@interface DeliveryViewController ()
{
    UITableView *myTableVIew;
//    NSArray *titleArr;
//    NSString *tpeop;
//    NSString *tphone;
//    NSString *ttitle;
//    NSString *tdescribe;
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *titleTF;
    UITextField *msTF;
}
@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =DEF_RGB_COLOR(222, 222, 222);
    self.title = @"投递项目";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(deliverClick) title:@"投递"];
    self.navigationItem.rightBarButtonItem =so;
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
                self.edgesForExtendedLayout=UIRectEdgeNone;
        //        self.navigationController.navigationBar.translucent = NO;
    }
    [self creatView];

}
- (void)deliverClick
{
    [myTableVIew reloadData];
    [[HttpManager defaultManager] postRequestToUrl:DEF_TOUDIXIANGMU params:@{@"investmentId":self.zijinId,@"linkman":nameTF.text? nameTF.text:@"",@"cellphone":phoneTF.text? phoneTF.text:@"",@"title":titleTF.text? titleTF.text:@"",@"description":msTF.text? msTF.text:@"",@"attachmentId":@""} complete:^(BOOL successed, NSDictionary *result) {
        if (successed) {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [MBProgressHUD showSuccess:@"投递成功" toView:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else
            {
               [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            }
        }
    }];
}
- (void)creatView
{
    nameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 30)];
    nameTF.backgroundColor = [UIColor whiteColor];
    nameTF.placeholder = @"联系人";
    [self.view addSubview:nameTF];
    
    phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(0, [nameTF bottom]+1, DEF_SCREEN_WIDTH, 30)];
    phoneTF.backgroundColor = [UIColor whiteColor];
    phoneTF.placeholder = @"手机号";
    [self.view addSubview:phoneTF];
    
    titleTF = [[UITextField alloc] initWithFrame:CGRectMake(0, [phoneTF bottom]+1, DEF_SCREEN_WIDTH, 30)];
    titleTF.backgroundColor = [UIColor whiteColor];
    titleTF.placeholder = @"项目标题";
    [self.view addSubview:titleTF];
    
    msTF = [[UITextField alloc] initWithFrame:CGRectMake(0, [titleTF bottom]+1, DEF_SCREEN_WIDTH, 30)];
    msTF.backgroundColor = [UIColor whiteColor];
    msTF.placeholder = @"项目描述";
    [self.view addSubview:msTF];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, [msTF bottom]+20, DEF_SCREEN_WIDTH, 30);
//    [btn setTitle:@"上传商业计划书" forState:0];
//    [btn setBackgroundColor:[UIColor whiteColor]];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//    [btn addTarget:self action:@selector(toudiClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
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
