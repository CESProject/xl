//
//  ThreeViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/10.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
    NSArray *titleArr;
    NSArray *contArr;
}
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"面积,基金,企业情况";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    titleArr = @[@"企业最长孵化时间(月)",@"孵化面积(平方米)",@"在孵化企业使用面积(平方米)",@"孵化容量(工位数)",@"基金规模(万元)",@"在孵化企业数量(家)",@"毕业企业数量(家)"];
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.backgroundColor = GRAYCOLOR;
    //    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
}
-(void)setIncubx:(incubXx *)incubx
{
    _incubx = incubx;
//    NSLog(@"-------%@",incubx);
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",contArr[indexPath.row]];
    
    if (indexPath.row==0) {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",[common checkStrValue:self.incubx.maxHatchDuration]];
    }else if (indexPath.row==1)
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%0.f",self.incubx.hatchTotalArea];
    }else if (indexPath.row==2)
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%0.f",self.incubx.utilizationArea];
    }else if (indexPath.row==3)
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",[common checkStrValue:self.incubx.hatchContainer]];
    }else if (indexPath.row==4)
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%0.f",self.incubx.hatchFund];
    }else if (indexPath.row==5)
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",[common checkStrValue:self.incubx.hatchEnterpriseNum]];
    }else if (indexPath.row==6)
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",[common checkStrValue:self.incubx.graduationEnterpriseNum]];
    }
    
    return cell;
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
