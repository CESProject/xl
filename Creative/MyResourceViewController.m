//
//  MyResourceViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/31.
//  Copyright © 2016年 王文静. All rights reserved.
//*************  我的人脉  ****************

#import "MyResourceViewController.h"
#import "Result.h"
#import "MineViewController.h"
#import "NewsViewController.h"
@interface MyResourceViewController ()

@property(nonatomic,weak)UIScrollView *sc;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (nonatomic , assign) NSInteger scrollNum;
@property (nonatomic,copy)NSString *requestUrl;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MyResourceViewController
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
    self.title = @"我的人脉";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h - 64 )];
//    sc.backgroundColor = [UIColor whiteColor];
    
    self.detalView = [UIView new];
    self.commentsView = [UIView new];
    self.resulsView = [UIView new];
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    UILabel *label3 = [UILabel new];
    
    label1.text = @"我关注的";
    label2.text = @"关注我的";
    label3.text = @"互为关注";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    label3.textAlignment = NSTextAlignmentCenter;
    
    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), self.view.height - 64) itemArray:@[label1,label2,label3] contentArray:@[self.detalView,self.commentsView,self.resulsView]];
    self.wjScroll.delegate = self;
    [self.view addSubview:self.wjScroll];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView];
//    sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + 50);
//    [self.view addSubview:sc];
//    self.sc = sc;
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0,110,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT-110 ) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 120;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    self.hud = [common createHud];
    [self headerRefreshing];
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    myTableVIew.header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    myTableVIew.footer = refreshFooter;
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    [self.hud show:YES];
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    if (self.scrollNum ==0) {
        self.requestUrl = DEF_WGZSYR;
    }else if (self.scrollNum ==1)
    {
        self.requestUrl = DEF_GZWSYR;
    }else if (self.scrollNum ==2)
    {
        self.requestUrl = DEF_XHGZ;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:self.requestUrl params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            [myTableVIew.header endRefreshing];
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.cellNumArr removeAllObjects];
                [weakSelf.cellNumArr addObjectsFromArray:data.content];
                
                [myTableVIew reloadData];
            }
            [weakSelf.hud hide:YES];
        }else
        {
            [myTableVIew.header endRefreshing];
            [weakSelf.hud hide:YES];
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
    if (self.scrollNum ==0) {
        self.requestUrl = DEF_WGZSYR;
    }else if (self.scrollNum ==1)
    {
        self.requestUrl = DEF_GZWSYR;
    }else if (self.scrollNum ==2)
    {
        self.requestUrl = DEF_XHGZ;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:self.requestUrl params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
    else if (self.scrollNum ==2)
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
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MineViewController *mine = [[MineViewController alloc] init];
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    mine.listFriend = listF;
    mine.imagUrl =listF.image.absoluteImagePath;
    mine.btnTit = cell.addBtn.currentTitle;
    [self.navigationController pushViewController:mine animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [TeacherTableViewCell cellWithTabelView:tableView];
    cell.delegate = self;
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    cell.nameText.text = listF.userName;
    if (listF.isRelation==2)
    {
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
    NSIndexPath *inde = [myTableVIew indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
//    if (listF.isRelation==2)
//    {
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,listF.roadId];
//        WEAKSELF;
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
//                    [teachCell.addBtn setTitle:@"关注  " forState:0];
//                    listF.isRelation = 1;
                    [self headerRefreshing];
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
//    }else
//    {
//        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,listF.roadId];
//        WEAKSELF;
//        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result) {
//            if (successed) {
//                if ([result[@"code"] isEqualToString:@"10000"]) {
//                    [teachCell.addBtn setTitle:@"取消关注" forState:0];
//                    listF.isRelation = 2;
//                }else
//                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
//                }
//            }
//        }];
//    }
//    
}
- (void)deliverSiXin:(TeacherTableViewCell *)teachCell
{
    NSIndexPath *inde = [myTableVIew indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.userInfoId = listF.roadId;
    [self.navigationController pushViewController:newsVC animated:YES];
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
