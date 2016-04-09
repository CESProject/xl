//
//  PersonalCenterViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "AppDelegate.h"
#import "MyRoadViewController.h"
#import "MyProjectViewController.h"
#import "MyActivityViewController.h"
#import "MyResourceViewController.h"
#import "ResourcesViewController.h"
@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
    NSArray *persArr;
}
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.backgroundColor = DEF_RGB_COLOR(229, 229, 229);
//    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    
    NSArray *arr1 = @[@"课程",@"训练",@"测评"];
    NSArray *arr2 = @[@"约会"];
    NSArray *arr3 = @[@"路演",@"活动",@"项目",@"预约"];
    NSArray *arr4 = @[@"资源库",@"知识库",@"人脉",@"订单",@"消息"];
    persArr = @[arr1,arr2,arr3,arr4];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = persArr[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0.01;
    }else
    {
        return 11;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray *arr = persArr[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return persArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
    }else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            MyRoadViewController *roadVC = [[MyRoadViewController alloc] init];
            [self.navigationController pushViewController:roadVC animated:YES];
        }else if (indexPath.row==1)
        {
            MyActivityViewController *myactVC = [[MyActivityViewController alloc] init];
            [self.navigationController pushViewController:myactVC animated:YES];
        }else if (indexPath.row==2)
        {
            MyProjectViewController *myproVC = [[MyProjectViewController alloc] init];
            [self.navigationController pushViewController:myproVC animated:YES];
        }
    }else if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
            ResourcesViewController *resVC = [[ResourcesViewController alloc] init];
            [self.navigationController pushViewController:resVC animated:YES];
        }else if (indexPath.row==1)
        {
            
        }else if (indexPath.row==2)
        {
            MyResourceViewController *myresVC = [[MyResourceViewController alloc] init];
            [self.navigationController pushViewController:myresVC animated:YES];
        }
    }
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
