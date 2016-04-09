//
//  ServiceViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/14.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceCell.h"
#import "ServiceDetailViewController.h"

#import "Incubator.h"
@interface ServiceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
}
@property (nonatomic , strong) NSMutableArray *dataArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@end

@implementation ServiceViewController
//-(NSMutableArray *)ProModelArr
//{
//    if (_dataArr == nil) {
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"服务";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.hud = [common createHud];
    _dataArr = [NSMutableArray array];
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 91;
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
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_FUHUAQIFUWULIEBIAO params:@{@"createBy":self.incubat.incubId,@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            [myTableVIew.header endRefreshing];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                NSLog(@"=====--->%@",result);
                Incubator *data = [Incubator objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.dataArr addObjectsFromArray:data.content];
                [myTableVIew reloadData];
            }else
            {
                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            }
        }
        [weakSelf.hud hide:YES];
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
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_FUHUAQIFUWULIEBIAO params:@{@"createBy":self.incubat.incubId,@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Incubator *data = [Incubator objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.dataArr addObjectsFromArray:data.content];
                [myTableVIew reloadData];
                [myTableVIew.footer endRefreshing];
            }
        }else
        {
            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        }
        [myTableVIew.footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    ServiceCell *cell = [ServiceCell cellWithTabelView:tableView];
   Incubat *incub = self.dataArr[indexPath.row];
    cell.titleLab.text = incub.typeName;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:incub.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    cell.detailLab.text = incub.content;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEF_SCREEN_WIDTH/5+21;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Incubat *incub = self.dataArr[indexPath.row];
    ServiceDetailViewController *serVC = [[ServiceDetailViewController alloc] init];
    serVC.incubat = incub;
    [self.navigationController pushViewController:serVC animated:YES];
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
