//
//  ResourceSearchrViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//
#define BUTTONWIDTH (DEF_SCREEN_WIDTH-40)/4
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-40)/11
#import "ResourceSearchrViewController.h"
#import "Result.h"
#import "TeacherTableViewCell.h"
@interface ResourceSearchrViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *ziyuanArr;
}
@end

@implementation ResourceSearchrViewController

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
    
    self.titleArr = [[NSMutableArray alloc] initWithObjects:@"11",@"22",@"33",@"hehe", nil];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    self.tableview = tableview;
    
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
    [self.view addSubview:tableview];
    [self addHeadView];
    ziyuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    if (self.cellNumArr.count!=0)
    {
        for (NSDictionary *dic in self.cellNumArr)
        {
            Result *result = [[Result alloc] init];
            result.luyanID = [dic objectForKey:@"id"];
            result.categoryId = [dic objectForKey:@"categoryId"];
            result.name = [dic objectForKey:@"userName"];
            result.iconImag = [dic objectForKey:@"imageUrl"];
            [ziyuanArr addObject:result];
        }
        [self.tableview reloadData];
    }

    
}
- (UIView *)addHeadView
{
    if (!self.tableview.tableHeaderView)
    {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, BUTTONHEIGHT+20);
        view.backgroundColor =DEF_RGB_COLOR(247, 247, 247);
        [self.view addSubview:view];
        
        for (int i=0; i<4; i++)
        {
            UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [Btn setTitle:self.titleArr[i] forState:UIControlStateNormal];//设置title
            [Btn setImage:[UIImage imageNamed:@"delet"] forState:0];
            [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            Btn.imageEdgeInsets = UIEdgeInsetsMake(5, 50, 5, 5);
            Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 45);
            Btn.tag = i;
            [Btn addTarget:self action:@selector(searchResulBtn:) forControlEvents:UIControlEventTouchUpInside];
            [Btn setFrame:CGRectMake(10 +(i%4)*(BUTTONWIDTH + 5), 10, BUTTONWIDTH, BUTTONHEIGHT)];
            [Btn setBackgroundColor:[UIColor whiteColor]];
            [view addSubview:Btn];
        }
        //        view.hidden = YES;
        self.tableview.tableHeaderView = view;
    }
    
    return self.tableview.tableHeaderView;
}
- (void)searchResulBtn:(UIButton *)btn
{
    [btn removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [TeacherTableViewCell cellWithTabelView:tableView];
//    Result *result = [ziyuanArr objectAtIndex:indexPath.row];
//    cell.nameText.text = result.name;
//    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:result.iconImag] placeholderImage:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AchievementViewController *achVC = [[AchievementViewController alloc] init];
//    [self.navigationController pushViewController:achVC animated:YES];
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
