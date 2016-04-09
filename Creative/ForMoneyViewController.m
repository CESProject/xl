//
//  ForMoneyViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ForMoneyViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "ResouSearchController.h"
#import "MoneyTableViewCell.h"
#import "ForMoeDetailViewController.h"
#import "MoneyModel.h"
#import "SearchViewController.h"
#import "ResourceMoneyController.h"
#import "common.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "SelectResultViewController.h"
#import "Result.h"
#import "RegionViewController.h"
#import "AddMorePlaceController.h"
#import "MoneyTableViewController.h"

#define ImgH    30
#define Height  30
#define LineH   0.5
#define LineW   self.view.mj_w - 33

@interface ForMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,MoneySearchViewDelegate>
{
    UITableView *myTableVIew;
    
}

@property (nonatomic , strong) UIButton *addBtn;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property (strong , nonatomic) MBProgressHUD *hud;

@property (strong, nonatomic) UIView *searchView;


@property (nonatomic , strong) NSArray *hangArr;
//@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , strong) NSArray *identityArr;
//@property (nonatomic , strong) NSString *identityStr;
@property (nonatomic , strong) NSArray *ageArr;
//@property (nonatomic , copy) NSString *ageStr;

@property (nonatomic , strong) NSMutableString *tags;
@property (nonatomic , strong) NSMutableString *placeIDs;

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;

@property (nonatomic , strong) NSArray *arrPlace;
@property (nonatomic , strong) NSArray *arrResult;

@end

@implementation ForMoneyViewController
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
        
        self.searchRoadView = [[MoneySearchView alloc]initWithFrame:CGRectMake(0, self.view.mj_h / 5 *2, self.view.mj_w , self.view.mj_h /5 *3)];
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
    MoneyTableViewController *roadVc = [[MoneyTableViewController alloc]init];
    [self.navigationController pushViewController:roadVc animated:YES];
}



- (void)passViewControl
{
    [self.searchView removeFromSuperview];
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 4;
    [self.navigationController pushViewController:regionVC animated:YES];
}

- (void)passViewMorePlaceControlDic:(NSMutableDictionary *)dic andArr:(NSMutableArray *)arr
{
    [self.searchView removeFromSuperview];
    AddMorePlaceController *morePlVc = [[AddMorePlaceController alloc]init];
    morePlVc.passVc = 4;
    morePlVc.dicCheck = [dic mutableCopy];
    //    morePlVc.arrTransmit = [arr mutableCopy];
    NSLog(@"%@",morePlVc.reDicCheck);
    
    [self.navigationController pushViewController:morePlVc animated:YES];
}

- (void)sureBtnAction
{
    self.searchRoadView.surerBtn.enabled = NO;
    [self.searchView removeFromSuperview];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.hangArr.count; i ++)
    {
        if ([self.searchRoadView.hangStr isEqualToString:self.hangArr[i]])
        {
            if (![self.searchRoadView.hangStr isEqualToString:@"全部"])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"fundType"];//资金类型
            }
        }
    }
    
    if (!self.searchRoadView.placeNmae || [self.searchRoadView.placeNmae isEqualToString:@""] ||[self.searchRoadView.placeNmae isEqualToString:@"全部"])
    {
        
    }
    else
    {
        [dic setObject:self.searchRoadView.placeNmae forKey:@"areaName"];// 所在区域
    }
    
    if ([self.searchRoadView.sendDicId allValues].count)
    {
        self.searchRoadView.Idtags = [NSMutableString string];
        for (int i = 0; i < [self.searchRoadView.sendDicId allValues].count; i ++)
        {
            if (i == [self.searchRoadView.sendDicId allValues].count - 1)
            {
                [self.searchRoadView.Idtags appendFormat:@"%@",[self.searchRoadView.sendDicId allValues][i]];
            }
            else
            {
                [self.searchRoadView.Idtags appendFormat:@"%@,",[self.searchRoadView.sendDicId allValues][i]];
            }
        }
        //        [dic setObject:self.searchRoadView.Idtags forKey:@"investmentTrade"];//投资行业
    }
    
    if (!self.searchRoadView.Idtags || [self.searchRoadView.Idtags isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject:self.searchRoadView.Idtags forKey:@"investmentTrade"];//投资行业
    }
    
    
    if (self.searchRoadView.placeIdArr.count)
    {
        self.searchRoadView.placeIDs = [NSMutableString string];
        for (int i = 0; i < self.searchRoadView.placeIdArr.count; i ++)
        {
            if (i == self.searchRoadView.placeIdArr.count - 1) {
                [self.searchRoadView.placeIDs appendFormat:@"%@",self.searchRoadView.placeIdArr[i]];
            }
            else
            {
                [self.searchRoadView.placeIDs appendFormat:@"%@,",self.searchRoadView.placeIdArr[i]];
            }
        }
    }
    if (!self.searchRoadView.placeIDs || [self.searchRoadView.placeIDs isEqualToString:@""])
    {
        
    }
    else{
        [dic setObject:self.searchRoadView.placeIDs forKey:@"investmentArea"];//投资地区
    }
    
    // 投资地区名称
    //    if (self.searchRoadView.placeNmaeArr.count)
    //    {
    //        self.searchRoadView.placeNames = [NSMutableString string];
    //        for (int i = 0; i < self.searchRoadView.placeNmaeArr.count; i ++)
    //        {
    //            if (i == self.searchRoadView.placeNmaeArr.count - 1) {
    //                [self.searchRoadView.placeNames appendFormat:@"%@",self.searchRoadView.placeIdArr[i]];
    //            }
    //            else
    //            {
    //                [self.searchRoadView.placeNames appendFormat:@"%@,",self.searchRoadView.placeIdArr[i]];
    //            }
    //        }
    //    }
    //    if (!self.searchRoadView.placeNames || [self.searchRoadView.placeNames isEqualToString:@""])
    //    {
    //
    //    }
    //    else{
    //        [dic setObject:self.searchRoadView.placeNames forKey:@"investmentAreaName"];//投资地区
    //    }
    
    
    
    for (int i = 0; i < self.ageArr.count; i ++)
    {
        if ([self.searchRoadView.ageStr isEqualToString:self.ageArr[i]])
        {
            if (![self.searchRoadView.ageStr isEqualToString:@"全部"])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"amountOfMoney"];//投资金额
            }
            
        }
    }
    
    
    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_ZZJGJZSEARCH params:dic complete:^(BOOL successed, NSDictionary *result) {
        //
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
        {
            //            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                selectVC.resUrl = DEF_ZZJGJZSEARCH;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                //                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.guildBtn.currentTitle?weakSelf.guildBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部" ,weakSelf.tenderPlaBtn.currentTitle?weakSelf.tenderPlaBtn.currentTitle:@"全部",nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
        self.searchRoadView.surerBtn.enabled = YES;
    }];
    
     if (self.searchRoadView.saveBtn.selected)
    {
        placeModel *placeSearch = [placeModel new];
        placeSearch.sqlLine = self.searchRoadView.saveText.text; // 保存名称
        placeSearch.cityId = self.searchRoadView.placeIDs; // 投资行业
        placeSearch.cityName = self.searchRoadView.placeNmae; // 所在地区
        placeSearch.directTypeName = self.searchRoadView.hangStr; // 资金类型
        placeSearch.ageType = self.searchRoadView.ageStr; // 投资金额
        placeSearch.name = self.searchRoadView.Idtags;;

        
        for (int i = 0; i < self.hangArr.count; i++)
        {
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
        [self.searchSqlite createWithSearchTableName:@"ForMoneyList" withModel:placeSearch];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找资金";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"updateCol" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ageResouceNature:) name:@"ageResouceNature" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    
    self.hud = [common createHud];
    
    [self initView];
    [self headerRefreshing];
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    myTableVIew.header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    myTableVIew.footer = refreshFooter;
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForMoneyList"];
    
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

- (void)ageResouceNature:(NSNotification *)not
{
    
    self.searchRoadView.selectCityCodeArrMore = [NSMutableArray array];
    self.searchRoadView.selectCityArrMore = [NSMutableArray array];
    
    if ([not.userInfo[@"arr"] isKindOfClass:[NSArray class]])
    {
        NSMutableString *str = [NSMutableString string];
        self.searchRoadView.placeIDs = [NSMutableString string];
        self.arrResult = [NSArray arrayWithArray:not.userInfo[@"arr"]];
        [self.searchRoadView.selectCityArrMore addObjectsFromArray:not.userInfo[@"diquName"]];
        
        [self.searchRoadView.selectCityCodeArrMore addObjectsFromArray:not.userInfo[@"arr"]];
        for (int i = 0; i < self.searchRoadView.selectCityArrMore.count; i ++)
        {
            NSString *str = [ NSString stringWithFormat:@"%@",self.searchRoadView.selectCityArrMore[i]];
            self.searchRoadView.dicCheckMore[str] = @"YES";
        }
        self.arrPlace = [not.userInfo[@"diquName"] copy];
        for (int i = 0; i < self.arrPlace.count; i ++)
        {
            Result *result = self.arrResult[i];
            if (i == self.arrPlace.count - 1)
            {
                [str appendFormat:@"%@",self.arrPlace[i]];
                [ self.searchRoadView.placeIDs appendFormat:@"%@",result.diquCode];
            }
            else
            {
                [str appendFormat:@"%@,",self.arrPlace[i]];
                [ self.searchRoadView.placeIDs appendFormat:@"%@,",result.diquCode];
            }
        }
    }
    else
    {
        self.searchRoadView.placeIDs = [NSMutableString string];
        [self.searchRoadView.placeIDs appendFormat:@"%@",not.userInfo[@"systemCode"]];
    }
    
    NSLog(@"%ld , %ld",self.searchRoadView.selectCityCodeArrMore.count ,self.searchRoadView.selectCityArrMore.count);
    
    [self.searchRoadView.selectCityArrMore addObject:@"查看更多城市"];
    [self.searchRoadView.selectCityCodeArrMore addObject:@""];
    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
    [self.searchRoadView.ageTableview reloadData];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    //    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_w, 30)];
    //    [titleView addSubview:[self createViewWithFrame:CGRectMake(0, 0, self.view.mj_w, Height) withIcon:@"common" withTitle:@"我要发布资金"]];
    //    self.addBtn = [self createBtnWithFrame:CGRectMake(0, 0, self.view.mj_w, Height) wihtAction:@selector(addBtnAction) andTarget:self];
    //    [titleView addSubview:self.addBtn];
    //    [self.view addSubview:titleView];
    
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 140;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    [self.hud show:YES];
    self.currentPage = 1;
    [myTableVIew.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAOZIJIN params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
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
        [self.hud hide:YES];
    }];
    
}
//上拉加载
- (void)footerRereshing
{
    [self.hud show:YES];
    _currentPage ++;
    if (self.currentPage > self.totalPage) {
        _currentPage --;
        [myTableVIew.footer noticeNoMoreData];
        return;
    }
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAOZIJIN params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            //            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                MoneyModel *data = [MoneyModel objectWithKeyValues:result[@"lists"]];
                self.totalPage = data.totalPages;
                [self.cellNumArr addObjectsFromArray:data.content];
                
                [myTableVIew reloadData];
                
            }
            [myTableVIew.footer endRefreshing];
        }else
        {
            [myTableVIew.footer endRefreshing];
        }
        [self.hud hide:YES];
    }];
    
}

- (void)addBtnAction
{
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchClick
{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.searchUrl = DEF_ZZJGJZSEARCH;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)selecterClick
{
    //    ResourceMoneyController *resouSearVC = [[ResourceMoneyController alloc]init];
    //    [self.navigationController pushViewController:resouSearVC animated:YES];
    
    UIView *searchview = self.searchView;
    [[[UIApplication sharedApplication] keyWindow] addSubview: searchview];
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

- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"全部",@"个人资金",@"企业资金",@"天使投资",@"PE投资",@"小额贷款",@"典当公司",@"担保公司",@"金融租赁",@"投资公司",@"商业银行",@"基金公司",@"证券公司",@"物流仓库",@"信托公司",@"资产管理",@"其他资金"];
        // 不限 个人资金 企业资金 天使投资 PE投资 小额贷款 典当公司 担保公司 金融租赁 投资公司 商业银行 基金公司 证券公司 信托公司 资产管理 其他资金
    }
    return _hangArr;
}

- (NSArray *)identityArr
{
    if (!_identityArr) {
        _identityArr = @[ @"金融投资",@"房地产",@"能源",@"化学化工",@"节能环保",@"建筑建材",@"矿产冶金",@"基础设施",@"农林牧渔",@"国防军工",@"航空航天",@"电气设备",@"机械机电",@"交通运输",@"仓储物流",@"汽车汽配",@"纺织服装饰品",@"旅游商店",@"餐饮休闲娱乐",@"教育培训体育",@"文化传媒广告",@"批发零售",@"家电数码",@"家居日用",@"食品饮料烟草",@"医疗保健",@"生物医药",@"IT互联网",@"电子通信",@"海洋开发",@"商务贸易",@"家政服务",@"园林园艺",@"收藏品",@"行政事业机构",@"其他行业"];
        // 不限 金融投资 房地产 能源 化学化工 节能环保 建筑建材 矿产冶金  基础设施 农林牧渔 国防军工 航空航天  电气设备 机械机电 交通运输 仓储物流 汽车汽配 纺织服装饰品 旅游商店 餐饮休闲娱乐
        //教育培训体育 文化传媒广告 批发零售 家电数码 家居日用 食品饮料烟草 医疗保健 生物医药 IT互联网 电子通信 海洋开发 商务贸易 家政服务 园林园艺 收藏品 行政事业机构 其他行业
    }
    return _identityArr;
}

- (NSArray *)ageArr
{
    if (!_ageArr) {
        _ageArr = @[@"全部",@"1万~10万",@"10万~50万",@"50万~100万",@"100万~500万",@"500万~1000万",@"1000万~5000万",@"5000万~1亿",@"大于1亿"];
        //        1万~10万 10万~50万 50万~100万 100万~500万 500万~1000万 1000万~5000万 5000万~1亿 大于1亿
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
