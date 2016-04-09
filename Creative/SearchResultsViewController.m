//
//  SearchResultsViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/4.
//  Copyright © 2016年 王文静. All rights reserved.
//
#define BUTTONWIDTH (DEF_SCREEN_WIDTH-40)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-40)/11
#import "SearchResultsViewController.h"
#import "ThreeDetailViewController.h"
#import "MainTableViewCell.h"
#import "Result.h"

@interface SearchResultsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *luyanArr;
}
@end

@implementation SearchResultsViewController

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
    MainTableViewCell *cell = [MainTableViewCell cellWithTabelView:tableView];
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    cell.titleLab.text = listF.name;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    cell.classLab.text =[common checkStrValue:listF.typeName] ;
    cell.detailLab.text = listF.briefDescription;
    if (listF.praiseCount!=0) {
        cell.praiseNumLab.text = [NSString stringWithFormat:@"%d",listF.praiseCount];
        [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
    }else
    {
        cell.praiseNumLab.text =@"";
        [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEF_SCREEN_WIDTH/5+21;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeDetailViewController *three = [[ThreeDetailViewController alloc] init];
    three.listFriend = [self.cellNumArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:three animated:YES];
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
