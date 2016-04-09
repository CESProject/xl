//
//  ForPlaceViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ForPlaceViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "ResourceSearchrViewController.h"
#import "CDSelectViewController.h"
#import "PlaceTableViewCell.h"
#import "PublishViewController.h"
#import "ForPlaDetailViewController.h"
#import "SearchViewController.h"
#import "Result.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "RegionViewController.h"
#import "SelectResultViewController.h"
#import "PlaceTableViewController.h"
#define ImgH    30
#define Height  30
#define LineH   0.5
#define LineW   self.view.mj_w - 33

@interface ForPlaceViewController ()<UITableViewDataSource,UITableViewDelegate,PlaceSearchViewDelegate>
{
    UITableView *myTableVIew;
    
}


@property (nonatomic , strong) UIButton *addBtn;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;

@property (nonatomic , strong) Result *dates;
@property(nonatomic,strong)MBProgressHUD *hud;

@property (strong, nonatomic) UIView *searchView;
@property (nonatomic , strong) SQLiteBase *searchSqlite;


@end

@implementation ForPlaceViewController

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
    
        
        self.searchRoadView = [[PlaceSearchView alloc]initWithFrame:CGRectMake(0, self.view.mj_h / 5 *2, self.view.mj_w , self.view.mj_h /5 *3)];
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
    PlaceTableViewController *roadVc = [[PlaceTableViewController alloc]init];
    
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
            if ([self.searchRoadView.hangStr isEqualToString:self.searchRoadView.hangArr[i]])
            {
                if (i < 10)
                {
                    NSString *str1 = [NSString stringWithFormat:@"0%d",i];
                    placeSearch.directionType = str1;
                    
                }
                else
                {
                    NSString *str2 = [NSString stringWithFormat:@"%d",i];
                    placeSearch.directionType = str2;
                    
                }
            }
        }
        
        [self.searchSqlite createWithSearchTableName:@"ForPlaceList" withModel:placeSearch];
    }
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.searchRoadView.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.searchRoadView.placeId forKey:@"cityId"]; // 城市id
    }
    for (int i = 0; i < self.searchRoadView.hangArr.count; i++) {
        if ([self.searchRoadView.hangStr isEqualToString:self.searchRoadView.hangArr[i]])
        {
            if (![self.searchRoadView.hangStr isEqualToString:@"全部"])
            {
                NSString *str2 = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str2 forKey:@"areaType"];//场地类型
            }
        }
    }
    WEAKSELF;
    [self.searchView removeFromSuperview];
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAOPLACE params:dic complete:^(BOOL successed, NSDictionary *result) {
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                //                selectVC.resUrl = weakSelf.selectUrl;
                selectVC.resUrl = DEF_ZHAOPLACE;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
//                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.leftBtn.currentTitle?weakSelf.leftBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
    }];
}

- (void)passViewControl
{
    [self.searchView removeFromSuperview];
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 5;
    [self.navigationController pushViewController:regionVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找场地";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"numberOfInformObjectspl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForPlaceList"];
    
    self.hud = [common createHud];
    [self initView];
    
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

- (void)headerRefreshing
{
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_ZHAOPLACE params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            //
            Result *data = [Result objectWithKeyValues:result[@"lists"]];
            weakSelf.totalPage = data.totalPages;
            [weakSelf.cellNumArr addObjectsFromArray:data.content];
            
            [myTableVIew reloadData];
        }
        [myTableVIew.header endRefreshing];
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAOPLACE params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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

- (void)initView
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_w, 35)];
    titleView.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:[self createViewWithFrame:CGRectMake(30, 10, self.view.mj_w, Height) withIcon:@"e-1" withTitle:@"发布需求"]];
    self.addBtn = [self createBtnWithFrame:CGRectMake(0, 5, self.view.mj_w, Height) wihtAction:@selector(addBtnAction) andTarget:self];
    [titleView addSubview:self.addBtn];
    [self.view addSubview:titleView];
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, titleView.mj_y + titleView.mj_h + 10,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame) - titleView.mj_h - titleView.mj_y - 10) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 90;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
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

#pragma mark - UIButton Seclct Action
- (void)addBtnAction
{
    PublishViewController *publishVC = [[PublishViewController alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchClick
{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.searchUrl = DEF_ZCDGJZSEARCH;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)selecterClick
{
//    CDSelectViewController *resouSearVC = [[CDSelectViewController alloc]init];
//    [self.navigationController pushViewController:resouSearVC animated:YES];
    
    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
}

- (UIButton *)createBtnWithFrame:(CGRect)frame wihtAction:(SEL)action andTarget:(id)target
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
    
}
- (UIView *)createViewWithFrame:(CGRect)frame withIcon:(NSString *)icon withTitle:(NSString *)title
{
    
    UIView *views = [[UIView alloc] initWithFrame:frame];
    views.backgroundColor = [UIColor whiteColor];
    UIImageView *icone = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 80, 0, ImgH, ImgH)];
    icone.image = [UIImage imageNamed:icon];
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(icone.mj_x + icone.mj_w, 5,  100, 20)];
    lblText.text = title;
    lblText.font = [UIFont systemFontOfSize:16.0f];
    lblText.textColor = [UIColor blackColor];
    
    [views addSubview:icone];
    [views addSubview:lblText];
    return views;
    
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
