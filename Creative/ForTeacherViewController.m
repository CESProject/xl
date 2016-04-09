//
//  ForTeacherViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ForTeacherViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "TeacherTableViewCell.h"
#import "Result.h"
#import "SearchViewController.h"
#import "MineViewController.h"
#import "NewsViewController.h"
#import "BecTeacViewController.h"
#import "ResouSearchController.h"
#import "BasicViewController.h"
#import "RegionViewController.h"
#import "SelectResultViewController.h"
#import "placeModel.h"
#import "SQLiteBase.h"
#import "TeacTableViewController.h"

#define ImgH    30
#define Height  30
#define LineH   0.5
#define LineW   self.view.mj_w - 33

@interface ForTeacherViewController ()<UITableViewDataSource,UITableViewDelegate,TeacherTableViewCellDelegate,TeacherSearchViewDelegate>
{
    UITableView *myTableVIew;
}

@property (nonatomic , strong) UIButton *addBtn;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property(nonatomic,strong)MBProgressHUD *hud;


@property (strong, nonatomic) UIView *searchView;
@property (nonatomic , strong) NSArray *hangArr;
//@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , strong) NSArray *identityArr;
//@property (nonatomic , strong) NSString *identityStr;
@property (nonatomic , strong) NSArray *ageArr;
//@property (nonatomic , copy) NSString *ageStr;

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;

@end

@implementation ForTeacherViewController
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
        
        self.searchRoadView = [[TeacherSearchView alloc]initWithFrame:CGRectMake(0, self.view.mj_h / 5 *2, self.view.mj_w , self.view.mj_h /5 *3)];
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
    TeacTableViewController *teacTabVc = [[TeacTableViewController alloc]init];
    [self.navigationController pushViewController:teacTabVc animated:YES];
}

- (void)sureBtnAction
{
    self.searchRoadView.surerBtn.enabled = NO;
    
    if (self.searchRoadView.saveBtn.selected)
    {
        placeModel *placeSearch = [placeModel new];
        placeSearch.cityId = self.searchRoadView.placeId;
        placeSearch.cityName = self.searchRoadView.placeNmae;
        placeSearch.sqlLine = self.searchRoadView.saveText.text;
        placeSearch.directTypeName = self.searchRoadView.hangStr;
        placeSearch.ageType = self.searchRoadView.ageStr;
        placeSearch.name = self.searchRoadView.identityStr;
        for (int i = 0; i < self.hangArr.count; i++) {
            if ([self.searchRoadView.hangStr isEqualToString:self.hangArr[i]])
            {
                if (i < 10)
                {
                    NSString *str1 = [NSString stringWithFormat:@"0%d",i];
                    placeSearch.directionType = str1;
                    
                }
                else
                {
                    NSString *str2 = [NSString stringWithFormat:@"%d",i];
                    placeSearch.directionType = str2;//路演方向类别
                    
                }
            }
        }
        
        [self.searchSqlite createWithSearchTableName:@"ForTeacherList" withModel:placeSearch];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (!self.searchRoadView.placeId || [self.searchRoadView.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.searchRoadView.placeId forKey:@"cityId"]; // 城市id
    }
    for (int i = 0; i < self.hangArr.count; i ++)
    {
        if ([self.searchRoadView.hangStr isEqualToString:self.hangArr[i]])
        {
            if (![self.searchRoadView.hangStr isEqualToString:@"全部"])
            {
                if (i - 1 < 10)
                {
                    NSString *str = [NSString stringWithFormat:@"0%d",i - 1];
                    [dic setObject:str forKey:@"type"];
                }
                else
                {
                    NSString *str2 = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str2 forKey:@"type"];//路演方向类别
                }
            }
        }
    }
    for (int i = 0; i < self.identityArr.count; i ++)
    {
        if ([self.searchRoadView.identityStr isEqualToString:self.identityArr[i]])
        {
            if (![self.searchRoadView.identityStr isEqualToString:@"全部"])
            {
            NSString *str = [NSString stringWithFormat:@"%d",i -1];
            [dic setObject:str forKey:@"personType"];
            }
        }
    }
    for (int i = 0; i < self.ageArr.count; i ++ )
    {
        if ([self.searchRoadView.ageStr isEqualToString:self.ageArr[i]])
        {
            if (![self.searchRoadView.ageStr isEqualToString:@"全部"])
            {
            NSString *str = [NSString stringWithFormat:@"%d",i - 1];
            [dic setObject:str forKey:@"age"];
            }
        }
    }
    [self.searchView removeFromSuperview];
    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_ZDSGJZSEARCH params:dic complete:^(BOOL successed, NSDictionary *result) {
        //
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
        {
            Result *dat = [Result objectWithKeyValues:result[@"lists"]];
            SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
            //                selectVC.resUrl = weakSelf.selectUrl;
            selectVC.resUrl = DEF_ZDSGJZSEARCH;
            selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
//            selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.guildBtn.currentTitle?weakSelf.guildBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部" ,weakSelf.identityBtn.currentTitle?weakSelf.identityBtn.currentTitle:@"全部",nil];
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
        }
        self.searchRoadView.surerBtn.enabled = YES;
    }];
    
}


- (void)passViewControl
{
    [self.searchView removeFromSuperview];
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 3;
    [self.navigationController pushViewController:regionVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找导师";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"numberOfResouceObjects" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForTeacherList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
    
    [self initView];
    self.hud = [common createHud];
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

- (void)searchClick
{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.searchUrl = DEF_ZDSGJZSEARCH;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)selecterClick
{
//        ResouSearchController *resouSearVC = [[ResouSearchController alloc]init];
//        [self.navigationController pushViewController:resouSearVC animated:YES];

//    CheckSearchController *chevVC = [[CheckSearchController alloc] init];
//    [self.navigationController pushViewController:chevVC animated:YES];
    
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAODAOSHI params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
        else
        {
            [myTableVIew.header endRefreshing];
        }
        [weakSelf.hud hide:YES];
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAODAOSHI params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
    
    [titleView addSubview:[self createViewWithFrame:CGRectMake(30, 5, self.view.mj_w, Height) withIcon:@"ds" withTitle:@"我要做导师"]];
    self.addBtn = [self createBtnWithFrame:CGRectMake(0, 5, self.view.mj_w, Height) wihtAction:@selector(addBtnAction) andTarget:self];
    [titleView addSubview:self.addBtn];
    [self.view addSubview:titleView];
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, titleView.mj_h + titleView.mj_y + 10,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame) - titleView.mj_h - titleView.mj_y - 10 ) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 120;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    
}

- (void)addBtnAction
{
    WEAKSELF;
     [[HttpManager defaultManager] postRequestToUrl:DEF_APPLYFOREXPERT params:nil complete:^(BOOL successed, NSDictionary *result) {
         if ([result isKindOfClass:[NSDictionary class]])
         {
//             [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
             if ([result[@"code"] isEqualToString:@"10000"])
             {
                 
             }
             else if ([result[@"code"] isEqualToString:@"10001"])
             {
                 NSLog(@"%@",result[@"code"]);
                 if ([result[@"msg"] isEqualToString:@"此信息的状态无法修改"])
                 {
                     showAlertView(@"正在等待审核");
                 }
                 else
                 {
                     [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                     BasicViewController *basVC = [[BasicViewController alloc]init];
                     basVC.passNum = 1;
                     [weakSelf.navigationController pushViewController:basVC animated:YES];
                 }
             }
         }
     }];
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MineViewController *mine = [[MineViewController alloc] init];
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    mine.listFriend = listF;
    mine.imagUrl = listF.imageUrl;
    mine.btnTit = cell.addBtn.currentTitle;
    [self.navigationController pushViewController:mine animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell *cell = [TeacherTableViewCell cellWithTabelView:tableView];
    cell.delegate = self;
    ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.imageUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
    cell.nameText.text = listF.userName;
    if (listF.isRelation==0) {
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
    if (listF.isRelation==0)
    {
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,listF.roadId];
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [teachCell.addBtn setTitle:@"关注  " forState:0];
                    listF.isRelation = 1;
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,listF.roadId];
        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result)
        {
            if (successed)
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [teachCell.addBtn setTitle:@"取消关注" forState:0];
                    listF.isRelation = 0;
                }
                else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }

}
- (void)deliverSiXin:(TeacherTableViewCell *)teachCell
{
    NSIndexPath *inde = [myTableVIew indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.userInfoId = listF.roadId;
    [self.navigationController pushViewController:newsVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"全部",@"互联网",@"移动互联网",@"IT",@"电信及增值",@"传媒娱乐",@"能源",@"医疗健康",@"旅行",@"游戏",@"金融",@"教育",@"房地产",@"物流仓库",@"农林牧渔",@"住宿餐饮",@"商品服务",@"消费品",@"文体艺术",@"加工制造",@"节能环保",@"其他"];
        //        00：互联网；01:移动互联网；02：IT;03:电信及增值；04：传媒娱乐；05：能源；06：医疗健康；07：旅行；08：游戏；09：金融；10：教育；11：房地产；12：物流仓库；13：农林牧渔；14：住宿餐饮；15：商品服务；16：消费品；17：文体艺术；18：加工制造；19:节能环保；20：其他；
    }
    return _hangArr;
}

- (NSArray *)identityArr
{
    if (!_identityArr) {
        _identityArr = @[ @"全部",@"学生",@"军人",@"其他",@"职场人",@"创业者",@"边工作边创业"];
        //        0:学生；1：军人；2：其他;3:职场人；4:创业者；5：边工作边创业
    }
    return _identityArr;
}
- (NSArray *)ageArr
{
    if (!_ageArr) {
        _ageArr = @[@"全部",@"20~30",@"30~40",@"40~50",@"50~60",@"60~70"];
        //        20~30 30~40 40~50 50~60 60~70
    }
    return _ageArr;
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
