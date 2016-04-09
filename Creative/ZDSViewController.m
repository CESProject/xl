//
//  ZDSViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/27.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ZDSViewController.h"
#import "TeacherTableViewCell.h"
#import "Result.h"
#import "MineViewController.h"
#import "NewsViewController.h"
@interface ZDSViewController ()<UITableViewDataSource,UITableViewDelegate,TeacherTableViewCellDelegate>

@end
@implementation ZDSViewController
-(NSMutableArray *)cellNumArr
{
    if (_cellNumArr == nil) {
        _cellNumArr = [NSMutableArray array];
    }
    return _cellNumArr;
}
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
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MineViewController *mine = [[MineViewController alloc] init];
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    mine.listFriend = listF;
    mine.btnTit = cell.addBtn.currentTitle;
    [self.navigationController pushViewController:mine animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [TeacherTableViewCell cellWithTabelView:tableView];
    cell.delegate = self;
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.imageUrl] placeholderImage:nil];
    cell.nameText.text = listF.userName;
    if (listF.isRelation==0) {
        [cell.addBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        [cell.addBtn setImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    }else
    {
        [cell.addBtn setTitle:@"关注  " forState:UIControlStateNormal];
        [cell.addBtn setImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    }
    
    return cell;
}
- (void)deliverdDelier:(TeacherTableViewCell *)teachCell
{
    NSIndexPath *inde = [self.tableview indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
    if (listF.isRelation==0)
    {
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,listF.roadId];
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [teachCell.addBtn setTitle:@"关注  " forState:0];
                    listF.isRelation = 1;
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }else
    {
        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,listF.roadId];
        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [teachCell.addBtn setTitle:@"取消关注" forState:0];
                    listF.isRelation = 0;
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }
    
}
- (void)deliverSiXin:(TeacherTableViewCell *)teachCell
{
    NSIndexPath *inde = [self.tableview indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.userInfoId = listF.roadId;
    [self.navigationController pushViewController:newsVC animated:YES];
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
