//
//  ZZJViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/27.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ZZJViewController.h"
#import "MoneyTableViewCell.h"
#import "ForMoeDetailViewController.h"
@interface ZZJViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZZJViewController
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
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForMoeDetailViewController *moneVC = [[ForMoeDetailViewController alloc]init];
    MoneyContent *money=[self.cellNumArr objectAtIndex:indexPath.row];
    moneVC.moneyCont = money;
    [self.navigationController pushViewController:moneVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyTableViewCell *cell = [MoneyTableViewCell cellWithTabelView:tableView];
    MoneyContent *money=[self.cellNumArr objectAtIndex:indexPath.row];
    cell.titleLab.text = money.title;
    cell.dateLab.text = [common sectionStrByCreateTime:money.shelfDate];
    cell.moneyConLab.text = [NSString stringWithFormat:@"%d万",money.investmentAmount];
    cell.typeConLab.text = money.fundTypeName?money.fundTypeName:@"";
    NSMutableString *result = [NSMutableString string];
    for (InvestmentTradeList *inves in money.investmentTradeList)
    {
        [result appendFormat:@"%@ ",inves.name];
    }
    cell.guildConLab.text = result;
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
