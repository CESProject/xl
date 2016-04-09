//
//  ProjectViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectTableViewCell.h"
#import "SearchViewController.h"
#import "CheckSearchController.h"
#import "AppDelegate.h"
#import "ListFriend.h"
#import "Result.h"

#import "Digestion.h"
//#import "ProjectModel.h"
#import "MJExtension.h"
#import "common.h"

#import "ProjectDetailViewController.h"
#import "ProjectTendViewController.h"
#import "PartnerViewController.h"
#import "ProjectSearchViewController.h"
#import "SelectResultViewController.h"
#import "placeModel.h"
#import "SQLiteBase.h"
#import "ProjectTableViewController.h"
#import "RegionViewController.h"

@interface ProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectSearchViewDelegate>
{
    UITableView *myTableVIew;
}
@property (nonatomic , strong) NSMutableArray *ProModelArr;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property(nonatomic,strong)MBProgressHUD *hud;


@property (strong, nonatomic) UIView *searchView;

@property (nonatomic , strong) NSArray *shapeArr;
@property (nonatomic , strong) NSArray *moneyArr;
@property (nonatomic , strong) NSArray *personTypeArr;
@property (nonatomic , strong) NSArray *personNumArr;
@property (nonatomic , strong) NSArray *tenderArr; // 项目投资
@property (nonatomic , strong) NSArray *projectJieArr;
@property (nonatomic , strong) NSArray *zhongJieArr;
@property (nonatomic , strong) NSArray *hangArr;


@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;


@end

@implementation ProjectViewController
-(NSMutableArray *)ProModelArr
{
    if (_ProModelArr == nil) {
        _ProModelArr = [NSMutableArray array];
    }
    return _ProModelArr;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
        _searchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        self.searchRoadView = [[ProjectSearchView alloc]initWithFrame:CGRectMake(0, self.view.mj_h / 5 *2, self.view.mj_w , self.view.mj_h /5 *3)];
        [self.searchRoadView.surerBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.searchRoadView.chaBtn addTarget:self action:@selector(chaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.searchRoadView.delegate = self;
        [_searchView addSubview:self.searchRoadView];
    }
    return _searchView;
}

- (void)chaBtnAction:(UIButton *)sender
{
    [self.searchView removeFromSuperview];
    ProjectTableViewController *roadVc = [[ProjectTableViewController alloc]init];
    [self.navigationController pushViewController:roadVc animated:YES];
}


- (void)sureBtnAction
{
    if (self.searchRoadView.saveBtn.selected)
    {
        placeModel *placeSearch = [placeModel new];
        placeSearch.sqlLine = self.searchRoadView.saveText.text;
        if (self.searchRoadView.shapeStr)
        {
            placeSearch.strType = self.searchRoadView.shapeStr;
        }
        if (self.searchRoadView.placeId)
        {
            placeSearch.cityId = self.searchRoadView.placeId;
        }
        if (self.searchRoadView.placeNmae)
        {
            placeSearch.cityName = self.searchRoadView.placeNmae;
        }
        if (self.searchRoadView.TypeStr) {
            
            placeSearch.partnerType = self.searchRoadView.TypeStr;
        }
        if (self.searchRoadView.NumStr)
        {
            placeSearch.teamNum = self.searchRoadView.NumStr;
        }
        if (self.searchRoadView.MoneStr)
        {
            placeSearch.strMoneyType = self.searchRoadView.MoneStr;
        }
        if (self.searchRoadView.MoneStr)
        {
            placeSearch.existingFundsType = self.searchRoadView.MoneStr;
        }
        if (!self.searchRoadView.PaStr || [self.searchRoadView.PaStr isEqualToString:@""])
        {
            if (self.searchRoadView.zjStr)
            {
                placeSearch.theme = self.searchRoadView.zjStr;
            }
        }
        else
        {
            placeSearch.cooperationStage = self.searchRoadView.PaStr;
            
        }
//        if (self.searchRoadView.shapeStr) {
//             placeSearch.cooperationStage = self.searchRoadView.shapeStr;
//        }
        
        [self.searchSqlite createWithSearchTableName:@"ProjectList" withModel:placeSearch];
    }
    
    [self.searchView removeFromSuperview];
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 项目类型
    for (int i = 0; i < self.shapeArr.count; i ++) {
        if ([self.searchRoadView.shapeStr isEqualToString:self.shapeArr[i]])
        {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"type"];
        }
    }
    /// 地区 ID
    if ([self.searchRoadView.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.searchRoadView.placeId forKey:@"cityId"]; // 城市id
    }
    /// 项目方向
    if (self.searchRoadView.hangStr)
    {
        for (int i = 0; i < self.hangArr.count; i++)
        {
            if ([self.searchRoadView.hangStr isEqualToString:self.hangArr[i]])
            {
                if (![self.searchRoadView.hangStr isEqualToString:@"全部"]) {
                    if (i - 1 < 10)
                    {
                    NSString *str1 = [NSString stringWithFormat:@"0%d",i-1];
                    [dic setObject:str1 forKey:@"directionType"];
                }
                else
                {
                    NSString *str2 = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str2 forKey:@"directionType"];
                }
                }
            }
        }
    }
    
    //    项目阶段
    if (self.searchRoadView.PaStr)
    {
        /// 项目阶段（合作）
        for (int i = 0; i < self.projectJieArr.count; i ++)
        {
            if ([self.searchRoadView.PaStr isEqualToString:self.projectJieArr[i]])
            {
                if (![self.searchRoadView.PaStr isEqualToString:@"全部"])
                {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"cooperationStage"];
                }
            }
        }
        
    }
    
    if (self.searchRoadView.MoneStr) {
        for (int i = 0; i < self.moneyArr.count; i ++)
        {
            if ([self.searchRoadView.MoneStr isEqualToString:self.moneyArr[i]])
            {
                if (![self.searchRoadView.MoneStr isEqualToString:@"全部"])
                {
                   
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"existingFundsType"];
                }
            }
        }
    }
    if (self.searchRoadView.TenStr)
    {
        for (int i = 0; i < self.tenderArr.count; i ++)
        {
            if ([self.searchRoadView.TenStr isEqualToString:self.tenderArr[i]])
            {
                if (![self.searchRoadView.TenStr isEqualToString:@"全部"])
                {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"initMoneyType"];
                }
            }
        }
    }
   
    if (self.searchRoadView.NumStr) {
        for (int i = 0; i < self.personNumArr.count; i ++)
        {
            if ([self.searchRoadView.NumStr isEqualToString:self.personNumArr[i]])
            {
                if (![self.searchRoadView.NumStr isEqualToString:@"全部"])
                {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"teamNum"];
                }
            }
        }
    }
    
    if (self.searchRoadView.TypeStr)
    {
        for (int i = 0; i < self.personTypeArr.count; i ++)
        {
            if ([self.searchRoadView.TypeStr isEqualToString:self.personTypeArr[i]])
            {
                if (![self.searchRoadView.TypeStr isEqualToString:@"全部"])
                {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"partnerType"];
                }
            }
        }
    }
    

   
    if (self.searchRoadView.zjStr)
    {
        /// 项目阶段（众筹）
        for (int i = 0; i < self.zhongJieArr.count; i ++)
        {
            if ([self.self.searchRoadView.zjStr isEqualToString:self.zhongJieArr[i]])
            {
                if (![self.searchRoadView.zjStr isEqualToString:@"全部"])
                {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"cooperationStage"];
                }
            }
        }
    }
    
    
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_XMGJZSEARCHYI params:dic complete:^(BOOL successed, NSDictionary *result) {
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                selectVC.resUrl = DEF_XMGJZSEARCHYI;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
//                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.shapeBtn.currentTitle?weakSelf.shapeBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
    }];
}

- (void)passViewControl
{
    [self.searchView removeFromSuperview];
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 2;
    [self.navigationController pushViewController:regionVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPage = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"项目汇";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"prjectOfInformObjects" object:nil];
    
    self.hud = [common createHud];
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 91;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    
//    [self loadTableViewData];
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ProjectList"];
//    self.sqliteArr = [NSMutableArray array];
//    
//    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
    
    [self headerRefreshing];
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    myTableVIew.header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    myTableVIew.footer = refreshFooter;
    
}

- (void)updateCol:(NSNotification *)not
{
    self.searchRoadView.selectCityArr = [NSMutableArray array];
    self.searchRoadView.selectCityCodeArr = [NSMutableArray array];
    
    self.searchRoadView.placeNmae = not.userInfo[@"arr"];
    self.searchRoadView.placeId = not.userInfo[@"systemCode"];
    [self.searchRoadView.selectCityArr addObject:not.userInfo[@"arr"]];
    [self.searchRoadView.selectCityCodeArr addObject:not.userInfo[@"systemCode"]];
    [self.searchRoadView.mytableview reloadData];
    
    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_PROJECTLIST params:@{@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
                WQLog(@"%@",weakSelf.ProModelArr);
                [myTableVIew reloadData];
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_PROJECTLIST params:@{@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)searchClick
{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.searchUrl = DEF_XMGJZSEARCH;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)selecterClick
{
//    ProjectSearchViewController *chevVC = [[ProjectSearchViewController alloc] init];
//    chevVC.selectUrl = DEF_PROJECTLIST;
//    [self.navigationController pushViewController:chevVC animated:YES];

    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
}


- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"全部",@"互联网", @"移动互联网",@"电信及增值",@"传媒娱乐", @"能源", @"医疗健康", @"旅游" ,@"游戏", @"金融", @"教育", @"房地产", @"物流仓库", @"农林牧渔", @"住宿餐饮", @"商品服务" ,@"消费品", @"文体艺术" ,@"加工制造", @"节能环保", @"其他" ,@"IT"];
        //        00：互联网；01:移动互联网；02：IT;03:电信及增值；04：传媒娱乐；05：能源；06：医疗健康；07：旅行；08：游戏；09：金融；10：教育；11：房地产；12：物流仓库；13：农林牧渔；14：住宿餐饮；15：商品服务；16：消费品；17：文体艺术；18：加工制造；19:节能环保；20：其他；
    }
    return _hangArr;
}

- (NSArray *)moneyArr
{
    if (!_moneyArr) {
        _moneyArr = @[@"全部",@"50万以下",@"50~100万",@"100~200万",@"200~500万",@"500~1000万",@"1000万以上"];
        //        0:50万以下；1:50~100万；2:100~200万；3:200~500万；4：500~1000万；5：1000万以上
    }
    return _moneyArr;
}

- (NSArray *)personTypeArr
{
    if (!_personTypeArr) {
        _personTypeArr = @[@"全部",@"技术合伙人",@"营销合伙人",@"产品合伙人",@"运营合伙人",@"设计合伙人",@"其他合伙人"];
        //0：技术合伙人；1:营销合伙人；2：产品合伙人；3：运营合伙人；4：设计合伙人；5：其他合伙人
    }
    return _personTypeArr;
}
- (NSArray *)personNumArr
{
    if (!_personNumArr) {
        _personNumArr = @[@"全部",@"5人以下",@"5~10人",@"10~20人",@"20~50人",@"50人以上"];
        //        	5人以下 5~10人 10~20人 20~50人 50人以上
    }
    return _personNumArr;
}

- (NSArray *)tenderArr
{
    if (!_tenderArr) {
        _tenderArr = @[@"全部",@"等待投资",@"个人出资",@"天使投资",@"A  轮",@"B  轮",@"C  轮"];
        //        等待投资 个人出资 天使投资 A轮 B轮 C轮
        
    }
    return _tenderArr;
}
- (NSArray *)projectJieArr
{
    if (!_projectJieArr) {
        _projectJieArr = @[@"全部",@"有个好主意",@"产品开发中",@"上线运营"];
        //有个好主意 产品开发中 上线运营
    }
    return _projectJieArr;
}
- (NSArray *)zhongJieArr
{
    if (!_zhongJieArr) {
        _zhongJieArr = @[@"全部",@"概念阶段",@"研发中",@"已正式发布",@"已经盈利"];
        //概念阶段 研发中 已正式发布 已经盈利
    }
    return _zhongJieArr;
}

- (NSArray *)shapeArr
{
    if (!_shapeArr) {
        _shapeArr = @[@"全 部",@"外  包",@"合  作",@"股权众筹",@"奖励众筹"];
    }
    return _shapeArr;
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
