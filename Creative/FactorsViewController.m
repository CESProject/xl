//
//  FactorsViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/10.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "FactorsViewController.h"
#import "Factors.h"
#import "Facto.h"
#import "LoadingSiteViewController.h"
@interface FactorsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
    NSArray *titleArr;
}
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation FactorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"校企合作";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_FUHUAQIXIAOQIHEZUO params:@{@"loginId":self.incubat.incubId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            NSLog(@"=========%@",result);
//            [myTableVIew.header endRefreshing];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Factors *factors = [Factors objectWithKeyValues:result[@"lists"]];
                titleArr =factors.content;
                [myTableVIew reloadData];
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
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
//    cell.selectionStyle = 0;
    Facto *fac = titleArr[indexPath.row];
    cell.textLabel.text = fac.academyName;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Facto *fac = titleArr[indexPath.row];
    LoadingSiteViewController *loadVC = [[LoadingSiteViewController alloc] init];
    loadVC.tit = @"校企合作";
    loadVC.conUrl = [NSString stringWithFormat:@"%@?id=%@",DEF_XIAOQIHEZUO,fac.factId];
    [self.navigationController pushViewController:loadVC animated:YES];
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
