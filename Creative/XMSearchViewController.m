//
//  XMSearchViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "XMSearchViewController.h"
#import "Result.h"
#import "ProjectTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "ProjectTendViewController.h"
#import "PartnerViewController.h"
@interface XMSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
}
@end
@implementation XMSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索结果";
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"back"];
    self.navigationItem.leftBarButtonItems = @[back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    self.tableview = tableview;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
    [self.view addSubview:tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellNumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectTableViewCell *cell = [ProjectTableViewCell cellWithTabelView:tableView];
    if (self.cellNumArr.count!=0)
    {
        ListFriend *listF = self.cellNumArr[indexPath.row];
        cell.titleLab.text = listF.name;
        cell.classLab.text = listF.peName;
        cell.domainLab.text =listF.typeName;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:nil];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListFriend *listF = self.cellNumArr[indexPath.row];
    if ([listF.type isEqualToString:@"0"]) {
        // 投标
        ProjectTendViewController *prejectTendVC = [[ProjectTendViewController alloc]init];
        prejectTendVC.listFd = listF;
        [self.navigationController pushViewController:prejectTendVC animated:YES];
    }
    else if ([listF.type isEqualToString:@"1"])
    {
        // 合作
        PartnerViewController *partnerVc = [[PartnerViewController alloc]init];
        partnerVc.listFd = listF;
        [self.navigationController pushViewController:partnerVc animated:YES];
    }
    else
    {
        // 支持
        ProjectDetailViewController *projectVC = [[ProjectDetailViewController alloc]init];
        if ([listF.type isEqualToString:@"2"])
        {
            projectVC.YNtwo = YES;
        }
        else
        {
            projectVC.YNtwo = NO;
        }
        projectVC.listFried = listF;
        [self.navigationController pushViewController:projectVC animated:YES];
    }
}
- (void)backClick
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
