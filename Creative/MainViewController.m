//
//  MainViewController.m
//  Creative
//
//  Created by huahongbo on 15/12/28.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "MainViewController.h"
#import "RoadshowViewController.h"
#import "DCPicScrollView.h"
#import "UIView+MHCommon.h"
#import "Result.h"
#import "NSObject+MJKeyValue.h"
#import "common.h"
#import "Digestion.h"
#import "AppDelegate.h"
#import "moveModel.h"
#import "SearchViewController.h"
#import "CheckSearchController.h"
#import "AppDelegate.h"
#import "MainTableViewCell.h"
#import "ThreeDetailViewController.h"
#import "SearchRoadView.h"
#import "SelectResultViewController.h"
#import "placeModel.h"
#import "SQLiteBase.h"
#import "RegionViewController.h"
#import "RoadTableViewController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,SearchRoadDelegate>
{
    UITableView *myTableVIew;
    NSMutableArray *NumArr;
    NSMutableArray *lunboArr;
}
@property(nonatomic , assign)NSUInteger currentPostPage;
@property(nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic , strong) NSMutableArray *picArray;
@property (nonatomic , strong) UIView *moveView;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;

@property (strong, nonatomic) UIView *searchView;
@property (nonatomic , strong) SQLiteBase *searchSqlite;

@end

@implementation MainViewController
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
        //        _searchView.alpha = 0.5;
        
        /*
         //        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.mj_h /5 *2, self.view.mj_w, 50)];
         //        sectionView.backgroundColor = [UIColor whiteColor];
         //        sectionView.alpha = 1.0;
         //
         //
         //        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
         //        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
         //        [cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
         //        [cancleBtn setFrame:CGRectMake(10, 10, 50, 30)];
         //        cancleBtn.tintColor = [UIColor grayColor];
         //
         //        [sectionView addSubview:cancleBtn];
         //
         //        UIButton *alterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
         //        [alterBtn setTitle:@"重置" forState:UIControlStateNormal];
         //        [alterBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
         //        [alterBtn setFrame:CGRectMake(sectionView.mj_w /2 - 30 , 10, 50, 30)];
         //        alterBtn.tintColor = [UIColor grayColor];
         //
         //        [sectionView addSubview:alterBtn];
         //
         //
         //        UIButton *surerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
         //        [surerBtn setTitle:@"确定" forState:UIControlStateNormal];
         //        [surerBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
         //        [surerBtn setFrame:CGRectMake(sectionView.mj_w  - 60 , 10, 50, 30)];
         //        surerBtn.tintColor = [UIColor grayColor];
         //
         //        [sectionView addSubview:surerBtn];
         //
         //        [_searchView addSubview:sectionView];
         //
         //        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y, self.view.mj_w, 0.5)];
         //        line.backgroundColor = [UIColor lightGrayColor];
         //        [_searchView addSubview:line];
         //
         //        UIView *saveView = [[UIView alloc]initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + 1, self.view.mj_w, 50)];
         //        saveView.backgroundColor = [UIColor whiteColor];
         //        saveView.alpha = 1.0;
         //
         //        [_searchView addSubview:saveView];
         */
        
        self.searchRoadView = [[SearchRoadView alloc]initWithFrame:CGRectMake(0, self.view.mj_h / 5 *2, self.view.mj_w , self.view.mj_h /5 *3)];
        [self.searchRoadView.surerBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.searchRoadView.chaBtn addTarget:self action:@selector(chaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.searchRoadView.delegate = self;
        [_searchView addSubview:self.searchRoadView];
    }
    return _searchView;
}

- (void)passViewControl
{
    [self.searchView removeFromSuperview];
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 0;
    [self.navigationController pushViewController:regionVC animated:YES];
}
- (void)chaBtnAction:(UIButton *)sender
{
    [self.searchView removeFromSuperview];
    RoadTableViewController *roadVc = [[RoadTableViewController alloc]init];
    [self.navigationController pushViewController:roadVc animated:YES];
}
- (void)sureBtnAction
{
    
    if (self.searchRoadView.saveBtn.selected) {
        
        placeModel *placeSearch = [placeModel new];
        placeSearch.cityId = self.searchRoadView.placeId;
        placeSearch.cityName = self.searchRoadView.placeNmae;
        placeSearch.sqlLine = self.searchRoadView.saveText.text;
        placeSearch.directTypeName = self.searchRoadView.hangStr;
        for (int i = 0; i < self.searchRoadView.hangArr.count; i++) {
            //            if (![self.searchRoadView.hangStr isEqualToString:@"全部"]) {
            //
            //            }
            if ([self.searchRoadView.hangStr isEqualToString:self.searchRoadView.hangArr[i]])
            {
                if (i < 10)
                {
                    NSString *str1 = [NSString stringWithFormat:@"0%d",i];
                    placeSearch.directionType = str1;//路演方向类别
                }
                else
                {
                    NSString *str2 = [NSString stringWithFormat:@"%d",i];
                    placeSearch.directionType = str2;//路演方向类别
                    
                }
            }
        }
        [self.searchSqlite createWithSearchTableName:@"SearchList" withModel:placeSearch];
        
        
    }
    
    [self.searchView removeFromSuperview];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.searchRoadView.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.searchRoadView.placeId forKey:@"cityId"]; // 城市id
    }
    [dic setObject:@"2" forKey:@"status"];//路演状态
    for (int i = 0; i < self.searchRoadView.hangArr.count; i++) {
        if ([self.searchRoadView.hangStr isEqualToString:self.searchRoadView.hangArr[i]])
        {
            if (![self.searchRoadView.hangStr isEqualToString:@"全部"]) {
                if (i - 1 < 10)
                {
                    NSString *str1 = [NSString stringWithFormat:@"0%d",i - 1];
                    [dic setObject:str1 forKey:@"directionType"];//路演方向类别
                }
                else
                {
                    NSString *str2 = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str2 forKey:@"directionType"];//路演方向类别
                }
            }
            
            
        }
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_LUYANGJZSEARCH params:dic complete:^(BOOL successed, NSDictionary *result) {
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        WQLog(@"%@",dic);
        WQLog(@"%@",result);
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                selectVC.resUrl = DEF_LUYANGJZSEARCH;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                WQLog(@"%@",selectVC.cellNumArr);
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.self.title = @"主界面";
    self.currentPage = 1;
    self.picArray = [NSMutableArray array];
    NumArr = [NSMutableArray array];
    lunboArr = [NSMutableArray array];
    self.currentPostPage = 1;
    self.title = @"路演";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    self.automaticallyAdjustsScrollViewInsets = NO; // 防止轮播图的下移
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"numberOfInformObjects" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"SearchList"];
    
    self.hud = [common createHud];
    
    [self initView];
    
    
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
    [self AFNetLoad];
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_LUYANGJZSEARCH params:@{@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result)
     {
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
                 [weakSelf.hud hide:YES];
             }
             [weakSelf.hud hide:YES];
         }
     }];
}
//上拉加载
- (void)footerRereshing
{
    _currentPage ++;
    if (self.currentPage > self.totalPage)
    {
        _currentPage --;
        [myTableVIew.footer noticeNoMoreData];
        return;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_LUYANGJZSEARCH params:@{@"status":@"2",@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
                [weakSelf.hud hide:YES];
            }
            [weakSelf.hud hide:YES];
        }
        [myTableVIew.footer endRefreshing];
    }];
}
- (void)searchClick
{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.searchUrl = DEF_LUYANSHOUYE;
    [self.navigationController pushViewController:search animated:YES];
    
    
}
- (void)selecterClick
{
    //    CheckSearchController *chevVC = [[CheckSearchController alloc] init];
    //    chevVC.selectUrl = DEF_LUYANSHOUYE;
    //    [self.navigationController pushViewController:chevVC animated:YES];
    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
}


- (void)AFNetLoad
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] getRequestToUrl:DEF_GJZSEARCH params:nil complete:^(BOOL successed, NSDictionary *result) {
        WQLog(@"%@",result.allValues);
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [self.picArray removeAllObjects];
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
                
                //                [weakSelf loadMoveView];
                [weakSelf addHeadView];
            }
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
    DCPicScrollView  *picView = [[DCPicScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, aView.mj_h) WithImageNames:self.picArray];
    
    //    picView.titleData = arr1;
    picView.placeImage = [UIImage imageNamed:@"picf.png"];
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("你点到我了😳index:%zd\n",index);
        ThreeDetailViewController *three = [[ThreeDetailViewController alloc]init];
        three.listFriend = [self.cellNumArr objectAtIndex:index];
        [self.navigationController pushViewController:three animated:YES];
        
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
    
    
    //    UIView *moveView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    //    self.moveView = moveView;
    //    [self.view addSubview:moveView];
    
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0,65,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT-65) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 90;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:myTableVIew];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    [self headerRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellNumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell *cell = [MainTableViewCell cellWithTabelView:tableView];
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    cell.titleLab.text = listF.name;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    cell.classLab.text =[common checkStrValue:listF.typeName] ;
    cell.detailLab.text = listF.briefDescription;
    if (listF.praiseCount!=0)
    {
        cell.praiseNumLab.text = [NSString stringWithFormat:@"%d",listF.praiseCount];
        [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
    }
    else
    {
        cell.praiseNumLab.text =@"";
        [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
    }
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
    
    ThreeDetailViewController *three = [[ThreeDetailViewController alloc]init];
    three.listFriend = [self.cellNumArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:three animated:YES];
}


- (void)keyboardShow:(NSNotification *)not
{
    
    //    NSDictionary *dict = not.userInfo;
    //    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardH = keyboardFrame.size.height;
    self.searchRoadView.frame = CGRectMake(0, 20, self.view.mj_w , self.view.mj_h /5 *3);
    
}
- (void)keyboardHide:(NSNotification *)not
{
    
    //    NSDictionary *dict = not.userInfo;
    //    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardH = keyboardFrame.size.height;
    self.searchRoadView.frame = CGRectMake(0, self.view.mj_h / 5 *2 , self.view.mj_w , self.view.mj_h /5 *3);
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
