//
//  MyProjectViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MyProjectViewController.h"
#import "ProjectTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "ProjectTendViewController.h"
#import "PartnerViewController.h"
#import "Result.h"
@interface MyProjectViewController ()

@property (nonatomic , strong) NSMutableArray *ProModelArr;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (nonatomic , assign) NSInteger scrollNum;
@end

@implementation MyProjectViewController
-(NSMutableArray *)ProModelArr
{
    if (_ProModelArr == nil) {
        _ProModelArr = [NSMutableArray array];
    }
    return _ProModelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"项目";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.scrollNum = 0;
    self.currentPage = 1;
    self.releaseView = [UIView new];
    self.participateView = [UIView new];
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    
    label1.text = @"我参与的项目";
    label2.text = @"我发布的项目";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), self.view.height) itemArray:@[label1,label2] contentArray:@[self.releaseView,self.participateView]];
    self.wjScroll.delegate = self;
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView];
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0,110,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT ) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 91;
    myTableVIew.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self.view addSubview:self.wjScroll];
    [self.view addSubview:myTableVIew];
    [self headerRefreshing];
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    myTableVIew.header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    myTableVIew.footer = refreshFooter;
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.scrollNum == 0)
    {
        dic = @{@"creater":@"1",@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)};
    }else
    {
        dic = @{@"creater":@"2",@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)};
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_WDFBCJXIANGMU params:dic complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            [myTableVIew.header endRefreshing];
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.ProModelArr removeAllObjects];
                [weakSelf.ProModelArr addObjectsFromArray:data.content];
                [myTableVIew reloadData];
            }
        }
    }];
}
//上拉加载
- (void)footerRereshing
{
    _currentPage ++;
    if (self.currentPage > self.totalPage) {
        _currentPage --;
        [myTableVIew.footer noticeNoMoreData];
        return;
    }
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.scrollNum == 0)
    {
        dic = @{@"creater":@"1",@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)};
    }else
    {
        dic = @{@"creater":@"2",@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)};
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_WDFBCJXIANGMU params:dic complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.ProModelArr addObjectsFromArray:data.content];
                [myTableVIew reloadData];
                [myTableVIew.footer endRefreshing];
            }
        }
        [myTableVIew.footer endRefreshing];
    }];
}
- (void)loadWJSliderViewDidIndex:(NSInteger)index
{
    self.scrollNum = index;
    if (self.scrollNum == 0) {
        [self headerRefreshing];
        [myTableVIew reloadData];
    }
    else if(self.scrollNum == 1)
    {
        [self headerRefreshing];
        [myTableVIew reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ProModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectTableViewCell *cell = [ProjectTableViewCell cellWithTabelView:tableView];
    ListFriend *listF = self.ProModelArr[indexPath.row];
    cell.titleLab.text = listF.name;
    cell.classLab.text = listF.peName;
    cell.domainLab.text =listF.typeName;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
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
    ListFriend *listF = self.ProModelArr[indexPath.row];
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
