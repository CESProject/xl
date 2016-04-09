//
//  ResMoneyViewController.m
//  Creative
//
//  Created by huahongbo on 16/2/1.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResMoneyViewController.h"
#import "ForMoeDetailViewController.h"
#import "MoneyTableViewCell.h"
#import "MoneyModel.h"
@interface ResMoneyViewController ()
{
    UITableView *myTableVIew;
    NSString *num;
}
@property (nonatomic , assign) NSInteger scrollNum;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@end

@implementation ResMoneyViewController
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
    self.deliveryMonView = [UIView new];
    self.releaseMonView = [UIView new];

    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    label1.text = @"我投递的资金";
    label2.text = @"我发布的资金";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.height) itemArray:@[label1,label2] contentArray:@[self.deliveryMonView,self.releaseMonView]];
    self.wjScroll.delegate = self;
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView];
    [self.view addSubview:self.wjScroll];

    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 50,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 140;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    if (self.scrollNum == 0)
    {
        num = @"2";
    }else
    {
        num = @"1";
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_WDZJLB params:@{@"choice":num,@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            [myTableVIew.header endRefreshing];
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                MoneyModel *data = [MoneyModel objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.cellNumArr removeAllObjects];
                [weakSelf.cellNumArr addObjectsFromArray:data.content];
                
                [myTableVIew reloadData];
            }
            
        }else
        {
            [myTableVIew.header endRefreshing];
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
    if (self.scrollNum == 0)
    {
        num = @"2";
    }else
    {
        num = @"1";
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_WDZJLB params:@{@"choice":num,@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                MoneyModel *data = [MoneyModel objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.cellNumArr addObjectsFromArray:data.content];
                
                [myTableVIew reloadData];
                
            }
            [myTableVIew.footer endRefreshing];
        }else
        {
            [myTableVIew.footer endRefreshing];
        }
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
    cell.typeConLab.text = money.fundTypeName;
    NSMutableString *result = [NSMutableString string];
    for (InvestmentTradeList *inves in money.investmentTradeList)
    {
        [result appendFormat:@"%@ ",inves.name];
    }
    cell.guildConLab.text = result;
    return cell;
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
