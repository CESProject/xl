//
//  HDSearchViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "HDSearchViewController.h"
#import "ActiveTableViewCell.h"
#import "ActiveDeatailViewController.h"
#import "Result.h"
@interface HDSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation HDSearchViewController

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
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cellNumArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveTableViewCell *cell = [ActiveTableViewCell cellWithTabelView:tableView];
    ListFriend *activeM = [self.cellNumArr objectAtIndex:indexPath.row];
    cell.titleLab.text = activeM.theme;
    cell.dateLab.text = [common sectionStrByCreateTime:activeM.createDate];
    cell.addressLab.text = activeM.address;
    cell.unitLab.text = activeM.sponsor;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:activeM.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveDeatailViewController *acthree = [[ActiveDeatailViewController alloc]init];
    ListFriend *activeM = [self.cellNumArr objectAtIndex:indexPath.row];
    acthree.listFriend = activeM;
    [self.navigationController pushViewController:acthree animated:YES];
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
