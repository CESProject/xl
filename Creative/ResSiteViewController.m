//
//  ResSiteViewController.m
//  Creative
//
//  Created by huahongbo on 16/2/1.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResSiteViewController.h"
#import "Result.h"
#import "PlaceTableViewCell.h"
#import "ForPlaDetailViewController.h"
@interface ResSiteViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
}
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property (nonatomic , strong) Result *dates;
@end

@implementation ResSiteViewController
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
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.mj_w, 20)];
    titLab.text = @"我询价的场地";
    titLab.textColor = [UIColor lightGrayColor];
    titLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titLab];
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, [titLab bottom],DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT-titLab.mj_h-titLab.mj_y) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 90;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    
    [self headerRefreshing];
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    myTableVIew.header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    myTableVIew.footer = refreshFooter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)headerRefreshing
{
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_WXJDCD params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            //
            Result *data = [Result objectWithKeyValues:result[@"lists"]];
            weakSelf.totalPage = data.totalPages;
            [weakSelf.cellNumArr addObjectsFromArray:data.content];
            
            [myTableVIew reloadData];
        }
        [myTableVIew.header endRefreshing];
        
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_WXJDCD params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
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
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listModel.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        
    }
    return cell;
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
