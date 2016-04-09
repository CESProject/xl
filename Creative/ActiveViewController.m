//
//  ActiveViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//  ************* 活动  *****************

#import "ActiveViewController.h"
#import "AppDelegate.h"
#import "HDCheckViewController.h"
#import "SearchViewController.h"
#import "ActiveTableViewCell.h"
#import "ActiveDeatailViewController.h"
#import "Result.h"
#import "common.h"
#import "Digestion.h"
#import "moveModel.h"
#import "DCPicScrollView.h"
#import "SelectResultViewController.h"
#import "placeModel.h"
#import "SQLiteBase.h"
#import "ActiveTableViewController.h"


@interface ActiveViewController ()<UITableViewDataSource,UITableViewDelegate,SearchActiviteDelegate>
{
    UITableView *myTableVIew;
    NSMutableArray *lunboArr;
}

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;


@property (nonatomic , strong) NSMutableArray *picArray;

@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
//@property (nonatomic , strong) UIView *moveView;
@property(nonatomic,strong)MBProgressHUD *hud;

@property (strong, nonatomic) UIView *searchView;

@property (nonatomic , strong) NSArray *typeArr;  //分类
@property (nonatomic , strong) NSString *typeStr;
@property (nonatomic , strong) NSArray *timeArr;  //时间
@property (nonatomic , strong) NSString *timeStr;
@property (nonatomic , strong) NSArray *isfreeArr;
@property (nonatomic , strong) NSString *freeStr;


@end

@implementation ActiveViewController

-(NSMutableArray *)cellNumArr
{
    if (_cellNumArr == nil) {
        _cellNumArr = [NSMutableArray array];
    }
    return _cellNumArr;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
        _searchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        self.searchActiView = [[SearchActiviteView alloc]initWithFrame:CGRectMake(0, self.view.mj_h / 5 *2, self.view.mj_w , self.view.mj_h /5 *3)];
        [self.searchActiView.surerBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.searchActiView.chaBtn addTarget:self action:@selector(chaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.searchActiView.delegate = self;
        [_searchView addSubview:self.searchActiView];
    }
    return _searchView;
}

- (void)sureBtnAction
{
    if (self.searchActiView.saveBtn.selected)
    {
        placeModel *placeSearch = [placeModel new];
        placeSearch.sqlLine = self.searchActiView.saveText.text;
        placeSearch.isFree = self.searchActiView.freeStr;
        
        placeSearch.strType = self.searchActiView.typeStr;
//        placeSearch.timeType = self.searchActiView.timeStr;
        placeSearch.startTime = self.searchActiView.textField.text;
        placeSearch.endTime = self.searchActiView.textField1.text;
        
        [self.searchSqlite createWithSearchTableName:@"ActiviteList" withModel:placeSearch];
    }
    
    self.searchActiView.surerBtn.enabled = NO;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"2" forKey:@"status"];//路演状态
    // 选择时间
//    for (int i = 0; i < self.timeArr.count; i ++ ) {
//        if ([self.searchActiView.timeStr isEqualToString:self.timeArr[i]])
//        {
//            if (i == 0) {
//                
//            }else
//            {
//            NSString *str = [NSString stringWithFormat:@"%d",i - 1];
//            [dic setObject:str forKey:@"timeType"];
//            }
//        }
//    }
    if (!self.searchActiView.textField.text || [self.searchActiView.textField.text isEqualToString:@""])
    {
        
    }
    else
    {
       [dic setObject:self.searchActiView.textField.text forKey:@"startTime"];
    }
    if (!self.searchActiView.textField1.text || [self.searchActiView.textField1.text isEqualToString:@""])
    {
    
    }
    else
    {
      [dic setObject:self.searchActiView.textField1.text forKey:@"endTime"];  
    }
    
    for (int i = 0; i < self.typeArr.count; i ++) {
        if ([self.searchActiView.typeStr isEqualToString:self.typeArr[i]]) {
            if (i == 0) {
                
            }else
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"type"];
            }
            
        }
    }
    for (int i = 0; i < self.isfreeArr.count; i ++) {
        if ([self.searchActiView.freeStr isEqualToString:self.isfreeArr[i]])
        {
            if (i == 0)
            {
                
            }
            else
            {
            NSString *str = [NSString stringWithFormat:@"%d",i - 1];
            [dic setObject:str forKey:@"isFree"];
            }
        }
    }
    [self.searchView removeFromSuperview];
    
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ACTIVE params:dic complete:^(BOOL successed, NSDictionary *result) {
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                selectVC.resUrl = DEF_ACTIVE;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
//                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.typeBtn.currentTitle?weakSelf.typeBtn.currentTitle:@"全部",weakSelf.moneyBtn.currentTitle?weakSelf.moneyBtn.currentTitle:@"全部",weakSelf.timeBtn.currentTitle?weakSelf.timeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
        self.searchActiView.surerBtn.enabled = YES;
    }];
}

- (void)chaBtnAction:(UIButton *)sender
{
    [self.searchView removeFromSuperview];
    ActiveTableViewController *roadVc = [[ActiveTableViewController alloc]init];
    [self.navigationController pushViewController:roadVc animated:YES];
}

- (void)passViewControl
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"活动";
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    self.automaticallyAdjustsScrollViewInsets = NO; // 防止轮播图的下移

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.hud = [common createHud];
    
    self.picArray = [NSMutableArray array];
    lunboArr = [NSMutableArray array];
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ActiviteList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
    
    [self initView];
    [self AFNetLoad];
    
    [self headerRefreshing];
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    myTableVIew.header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    myTableVIew.footer = refreshFooter;
    
}


- (void)keyboardShow:(NSNotification *)not
{
    
    //    NSDictionary *dict = not.userInfo;
    //    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardH = keyboardFrame.size.height;
    self.searchActiView.frame = CGRectMake(0, 20, self.view.mj_w , self.view.mj_h /5 *3);
    
}
- (void)keyboardHide:(NSNotification *)not
{
    
    //    NSDictionary *dict = not.userInfo;
    //    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardH = keyboardFrame.size.height;
    self.searchActiView.frame = CGRectMake(0, self.view.mj_h / 5 *2 , self.view.mj_w , self.view.mj_h /5 *3);
}

#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ACTIVE params:@{@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ACTIVE params:@{@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.cellNumArr addObjectsFromArray:data.content];
                [myTableVIew reloadData];
                [myTableVIew.footer endRefreshing];
            }
        }
        [myTableVIew.footer endRefreshing];
    }];
}
- (void)AFNetLoad
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] getRequestToUrl:DEF_GJZSEARCH params:@{@"superCategoryId":@(8)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            [Digestion replacefmoveModelKey];
            [Digestion replacefobjlistModelKey];
            [Digestion replacefimageDicModelKey];
            
            moveModel *movemodel = [moveModel objectWithKeyValues:result];
            for (NSDictionary *imageDic in movemodel.objList)
            {
                [ weakSelf.picArray addObject:imageDic[@"image"][@"absoluteImagePath"]];
                
                Result *result = [[Result alloc] init];
                result.luyanID = [imageDic objectForKey:@"businessId"];
                [lunboArr addObject:result];
            }
            [weakSelf.hud hide:YES];
            
            [weakSelf addHeadView];
        }
        [weakSelf.hud hide:YES];
    }];
}
- (void)addHeadView
{
    UIView *aView = [[UIView alloc] init];
    aView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT/3);
    [self.view addSubview:aView];
    // 轮播图
    DCPicScrollView  *picView = [[DCPicScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,aView.mj_h) WithImageNames:self.picArray];
    
    //    picView.titleData = arr1;
    picView.placeImage = [UIImage imageNamed:@"picf.png"];
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
//        printf("你点到我了😳index:%zd\n",index);
        ActiveDeatailViewController *activeVC = [[ActiveDeatailViewController alloc]init];
        ListFriend *activeM = [self.cellNumArr objectAtIndex:index];
        activeVC.listFriend = activeM;
        [self.navigationController pushViewController:activeVC animated:YES];
        
    }];
    picView.AutoScrollDelay = 2.5f;
    [aView addSubview:picView];
    myTableVIew.tableHeaderView = aView;
}

- (void)initView
{
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
//    UIView *moveView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_w / 7 *3 + 10)];
//    moveView.backgroundColor =  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    self.moveView = moveView;
//    [self.view addSubview:moveView];
    
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 65,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT-65 ) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 130;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
//    [self AFNetLoad];
//    myTableVIew.tableHeaderView = moveView;
    [self addHeadView];
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
    search.searchUrl = DEF_HDGJZSEARCH;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)selecterClick
{
//    HDCheckViewController *chevVC = [[HDCheckViewController alloc] init];
//    chevVC.selectUrl = DEF_ACTIVE;
//    [self.navigationController pushViewController:chevVC animated:YES];
    
    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
}

#pragma mark - tableview Delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cellNumArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveTableViewCell *cell = [ActiveTableViewCell cellWithTabelView:tableView];
    ListFriend *activeM = [self.cellNumArr objectAtIndex:indexPath.row];
    cell.titleLab.text = activeM.theme;
    cell.dateLab.text = [common sectionStrByCreateTime:activeM.createDate];
    cell.addressLab.text = activeM.address;
    cell.unitLab.text = activeM.sponsor;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:activeM.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveDeatailViewController *acthree = [[ActiveDeatailViewController alloc]init];
    ListFriend *activeM = [self.cellNumArr objectAtIndex:indexPath.row];
    acthree.listFriend = activeM;
    [self.navigationController pushViewController:acthree animated:YES];
}


- (NSArray *)typeArr
{
    if (!_typeArr) {
        _typeArr = @[@"全部",@"大赛",@"座谈会",@"培训会",@"户外活动",@"其他",@"路演"];
        //        0:大赛；1：座谈会；2：培训会；3：户外活动；4：其他；5：路演
    }
    return _typeArr;
}
- (NSArray *)timeArr
{
    if (!_timeArr) {
        _timeArr = @[@"不限",@"今天",@"近三天",@"近一周",@"近一个月"];
        //        1：今天 2：近三天 3：近一周 4： 近一个月
    }
    return _timeArr;
}

- (NSArray *)isfreeArr
{
    if (!_isfreeArr) {
        _isfreeArr = @[@"不限",@"免费",@"收费"];
        
    }
    return _isfreeArr;
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
