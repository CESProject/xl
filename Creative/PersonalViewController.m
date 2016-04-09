//
//  PersonalViewController.m
//  Creative
//
//  Created by huahongbo on 16/2/22.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PersonalViewController.h"
#import "NewsViewController.h"
@interface PersonalViewController ()
{
    int relation;
}
@property(nonatomic,strong)UIButton *addBtn;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    
    [self initView];
}
- (void)initView
{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.mj_w, DEF_SCREEN_HEIGHT/3)];
    titleView.backgroundColor = GREENCOLOR;
    [self.view addSubview:titleView];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.mj_w / 2 - 40, 40, 80, 80)];
    [iconImage sd_setImageWithURL:[NSURL URLWithString:self.obj.userInfo.imageUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
    iconImage.layer.cornerRadius = iconImage.frame.size.height/2;
    iconImage.clipsToBounds = YES;
    [titleView addSubview:iconImage];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-80, [iconImage bottom]+10, 80, 20)];
    titLab.textAlignment = NSTextAlignmentRight;
    titLab.font = [UIFont systemFontOfSize:14];
    titLab.text = @"发起人 :";
    [titleView addSubview:titLab];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake([titLab right]+5, titLab.mj_y, 100, 20)];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.text = self.obj.userInfo.loginName;
    [titleView addSubview:nameLab];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame =CGRectMake(20,[titleView bottom]+40, DEF_SCREEN_WIDTH-40, 40);
    self.addBtn.backgroundColor = [UIColor blackColor];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.addBtn setImage:[UIImage imageNamed:@"gz"] forState:0];
    //    [addBtn setTitle:self.gzTitl forState:0];
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.clipsToBounds = YES;
    self.addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    self.addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.view addSubview:self.addBtn];
    
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame =CGRectMake(self.addBtn.mj_x, [self.addBtn bottom]+20, self.addBtn.mj_w, self.addBtn.mj_h);
    msgBtn.layer.borderColor= UIColorFromHex(0x333333).CGColor;
    msgBtn.layer.borderWidth = 1;
    msgBtn.layer.cornerRadius = 5;
    msgBtn.clipsToBounds = YES;
    msgBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [msgBtn setTitleColor:UIColorFromHex(0x333333) forState:0];
    [msgBtn setImage:[UIImage imageNamed:@"sixin"] forState:0];
    [msgBtn setTitle:@"私信" forState:0];
    msgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    msgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [msgBtn addTarget:self action:@selector(msgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:msgBtn];
    
    [self reloadGuanZhuState];
}
- (void)reloadGuanZhuState
{
//    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUGUANZHU params:@{@"otherUserId":self.obj.userInfo.roadId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            NSString *rela =result[@"obj"][@"isRelation"];
            relation = [rela intValue];
            if ([result[@"code"] isEqualToString:@"10000"]) {
                if ([rela isEqualToString:@"1"]) {
                [self.addBtn setTitle:@"关注" forState:0];
                }else
                    {
                        [self.addBtn setTitle:@"取消关注" forState:0];
                    }
            }
        }
    }];
}
- (void)addBtnClick:(UIButton *)btn
{
    if (relation%2==1)
    {
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,self.obj.userInfo.roadId];
        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [btn setTitle:@"取消关注" forState:0];
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
            NSLog(@"===%@",self.obj.userInfo.roadId);
        }];
    }else
    {
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,self.obj.userInfo.roadId];
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [btn setTitle:@"关注" forState:0];
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }
    relation ++;
}

- (void)msgBtnClick
{
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    newsVC.userInfoId = self.obj.userInfo.roadId;
    [self.navigationController pushViewController:newsVC animated:YES];
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
