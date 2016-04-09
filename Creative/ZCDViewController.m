//
//  ZCDViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/27.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ZCDViewController.h"
#import "PlaceTableViewCell.h"
#import "ForPlaDetailViewController.h"
@interface ZCDViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZCDViewController

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForPlaDetailViewController *placeVC = [[ForPlaDetailViewController alloc]init];
    placeVC.listFri = [self.cellNumArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:placeVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceTableViewCell *cell = [PlaceTableViewCell cellWithTabelView:tableView];
    ListFriend *listModel = [self.cellNumArr objectAtIndex:indexPath.row];
    cell.titleLab.text = listModel.name;
    cell.addressLab.text = listModel.address;
    if (listModel.image) {
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listModel.image.absoluteImagePath] placeholderImage:nil];
        
    }
    return cell;
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
