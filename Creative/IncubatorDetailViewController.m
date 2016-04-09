//
//  IncubatorDetailViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "IncubatorDetailViewController.h"
#import "IncubDetailViewController.h"
#import "StaffingViewController.h"
#import "ThreeViewController.h"
#import "ConditionsViewController.h"
#import "ContactViewController.h"
#import "LabelModel.h"
#import "FactorsViewController.h"
#import "ServiceViewController.h"
#import "MentorViewController.h"
@interface IncubatorDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
    NSMutableArray *nameArr;
    NSArray *imgArr;
}
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)incubXx *incubx;
@end

@implementation IncubatorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.incubat.companyName;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    nameArr = [NSMutableArray arrayWithCapacity:0];
    [self loadDetailData];
    self.hud = [common createHud];
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.backgroundColor = GRAYCOLOR;
    //    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
}
- (void)loadDetailData
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_FUHUAQIBQ params:@{@"userId":self.incubat.incubId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            [myTableVIew.header endRefreshing];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                LabelModel *labMod = [LabelModel objectWithKeyValues:result];
                NSMutableArray *oneArr = [NSMutableArray array];
                NSMutableArray *twoArr = [NSMutableArray array];
                NSMutableArray *threArr = [NSMutableArray array];
                for (LabModel *labM in labMod.objList)
                {
                    labM.iconName = [NSString stringWithFormat:@"e-%d", labM.labId - 63];
//                    NSLog(@"-------->%d",labM.labId);
                    if (labM.labId>=64&&labM.labId<=67) {
                        [oneArr addObject:labM];
                    }else if (labM.labId>=68&&labM.labId<=71)
                    {
                        [twoArr addObject:labM];
                    }else if (labM.labId>=72&&labM.labId<=74)
                    {
                        [threArr addObject:labM];
                    }
                }
                if (oneArr.count>0)
                {
                    [nameArr addObject:oneArr];
                    [self loadjibenDetailData];
                }
                if (twoArr.count>0) {
                    [nameArr addObject:twoArr];
                }
                if (threArr.count>0) {
                    [nameArr addObject:threArr];
                }
                [myTableVIew reloadData];
            }else
            {
                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            }
        }
        [weakSelf.hud hide:YES];
    }];

}
- (void)loadjibenDetailData
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_FUHUAQIJICHUXX params:@{@"id":self.incubat.incubId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSLog(@"-------->%@",result);
                incubXx *incubx = [incubXx objectWithKeyValues:result[@"obj"]];
                self.incubx = incubx;
            }else
            {
                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            }
        }
        [weakSelf.hud hide:YES];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = nameArr[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    LabModel *labm = nameArr[indexPath.section][indexPath.row];
    cell.imageView.transform = CGAffineTransformMakeScale(0.6, 0.6);
    cell.textLabel.text = labm.tagDesc;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:labm.iconName];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LabModel *labm = nameArr[indexPath.section][indexPath.row];
    if (labm.labId==64) {
        //基本信息
        IncubDetailViewController *incVC = [[IncubDetailViewController alloc] init];
        incVC.incubat = self.incubat;
        incVC.incubx = self.incubx;
        [self.navigationController pushViewController:incVC animated:YES];
    }else if (labm.labId==65)
    {
        //面积 基金 企业
        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
        threeVC.incubx = self.incubx;
        [self.navigationController pushViewController:threeVC animated:YES];
    }else if (labm.labId==66)
    {
        //人员
        StaffingViewController *staVC = [[StaffingViewController alloc] init];
        staVC.incubx = self.incubx;
        [self.navigationController pushViewController:staVC animated:YES];
    }else if (labm.labId==67)
    {
        //
    }else if (labm.labId==68)
    {
        //入孵条件
        ConditionsViewController *threeVC = [[ConditionsViewController alloc] init];
        [self.navigationController pushViewController:threeVC animated:YES];
    }else if (labm.labId==69)
    {
        //项目
    }else if (labm.labId==70)
    {
        //活动
    }else if (labm.labId==71)
    {
        //服务
        ServiceViewController *serVC = [[ServiceViewController alloc] init];
        serVC.incubat = self.incubat;
        [self.navigationController pushViewController:serVC animated:YES];
    }else if (labm.labId==72)
    {
        //校企合作
        FactorsViewController *factVC = [[FactorsViewController alloc] init];
        factVC.incubat = self.incubat;
        [self.navigationController pushViewController:factVC animated:YES];
    }else if (labm.labId==73)
    {
        //导师信息
        MentorViewController *mentVC = [[MentorViewController alloc] init];
        mentVC.incubat = self.incubat;
        [self.navigationController pushViewController:mentVC animated:YES];
    }else if (labm.labId==74)
    {
        //联系方式
        ContactViewController *conVC = [[ContactViewController alloc] init];
        conVC.incubat = self.incubat;
        [self.navigationController pushViewController:conVC animated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return nameArr.count;
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
