//
//  ServiceDetailViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ServiceDetailViewController.h"

@interface ServiceDetailViewController ()

@end

@implementation ServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GRAYCOLOR;
    self.title = @"服务能力";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, DEF_SCREEN_WIDTH-20, DEF_SCREEN_HEIGHT/3)];
    [img sd_setImageWithURL:[NSURL URLWithString:self.incubat.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    [view addSubview:img];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, [img bottom]+5, 80, 20)];
    lab.text = @"服务类型：";
    lab.font = [UIFont systemFontOfSize:15];
//    lab.backgroundColor = [UIColor yellowColor];
    [view addSubview:lab];
    
    UILabel *serLab = [[UILabel alloc] initWithFrame:CGRectMake([lab right]+5, lab.mj_y, 100, 20)];
    serLab.textAlignment = NSTextAlignmentLeft;
    serLab.text = self.incubat.typeName;
    serLab.font = [UIFont systemFontOfSize:14];
    serLab.textColor = [UIColor lightGrayColor];
    [view addSubview:serLab];
    
    CGSize siz = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, self.incubat.content, 13);
    UILabel *contLab = [[UILabel alloc] initWithFrame:CGRectMake(lab.mj_x, [lab bottom]+20, DEF_SCREEN_WIDTH-20, siz.height)];
    contLab.textColor = [UIColor lightGrayColor];
    contLab.numberOfLines = 0;
    contLab.font = [UIFont systemFontOfSize:13];
    contLab.text = self.incubat.content;
    [view addSubview:contLab];
    view.frame = CGRectMake(0, 65, DEF_SCREEN_WIDTH, img.mj_h+lab.mj_h+siz.height+60);
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
