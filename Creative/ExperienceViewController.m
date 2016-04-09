//
//  ExperienceViewController.m
//  Creative
//
//  Created by MacBook on 16/3/8.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ExperienceViewController.h"
#import "AppDelegate.h"
#import "DCPicScrollView.h"
#import "ThreeDetailViewController.h"
#import "Digestion.h"
#import "moveModel.h"
#import "ExperienceDetailViewController.h"
#import "TableViewCell.h"
#import "TheViewUsedToShowTime.h"
#import "SearchViewController.h"
@interface ExperienceViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *myTableVIew;
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) UITableView *baseTableView;
@property(nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic, strong) NSMutableArray *ImageArray;
@property (nonatomic, strong) NSMutableArray *CellArray;
@property (assign, nonatomic) NSInteger totalPage;
@property (assign, nonatomic) NSInteger currentPage;


@end

@implementation ExperienceViewController

- (NSMutableArray *)CellArray{
    if (!_CellArray) {
        _CellArray = [NSMutableArray array];
    }
    return _CellArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    //表头视图
    [self AFNetLoad];
    [MBProgressHUD showMessage:@"努力加载中......" toView:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshAction) name:@"refresh" object:nil];
    // 下啦加载
    UIRefreshControl *refershController = [[UIRefreshControl alloc]init];
    refershController.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中....."];
    refershController.tintColor = [UIColor grayColor];
    [refershController addTarget:self action:@selector(RefreshActionll:) forControlEvents:(UIControlEventValueChanged)];
    [self.baseTableView addSubview:refershController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}
//下拉加载提示框
- (void)RefreshActionll:(UIRefreshControl *)refreshController{
    [refreshController endRefreshing];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已没有资源可供加载" preferredStyle:(UIAlertControllerStyleAlert)];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
        [UIView animateWithDuration:2 animations:^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
   
                                          
}
- (void)RefreshAction{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//导航条设置
- (void)createNavigationBar{
    
    self.title = @"创新创业体验";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *searchButton = [UIBarButtonItem itemWithTarget:self action:@selector(searchButtonAction) image:@"search"];
    self.navigationItem.rightBarButtonItem = searchButton;
    self.navigationController.navigationBar.translucent = NO;
    
    [self dataForTableView];
    
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.rowHeight = DEF_SCREEN_WIDTH / 3 + DEF_SCREEN_WIDTH /10;
//    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.baseTableView];
    
    [self initView];
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.baseTableView.footer = refreshFooter;

}
//右按钮点击事件
- (void)searchButtonAction{
    
    SearchViewController *search = [[SearchViewController alloc] init];
    search.searchUrl = DER_JIANSUOYUEHUI;
    [self.navigationController pushViewController:search animated:YES];
    
}

//左按钮点击事件
- (void)initView
{
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

    [self addHeadView];

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
    [[HttpManager defaultManager] postRequestToUrl:DER_JIANSUOYUEHUI params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            //            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.CellArray addObjectsFromArray:data.content];
                WQLog(@"%ld",data.content.count);
                [self.baseTableView reloadData];
                [self.baseTableView.footer endRefreshing];
                [weakSelf.hud hide:YES];
            }
            [weakSelf.hud hide:YES];
        }
        [self.baseTableView.footer endRefreshing];
    }];
}

#pragma -------------列表数据网络请求－－－－－－－

- (void)dataForTableView{
    self.currentPage = 1;
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DER_JIANSUOYUEHUI params:@{@"pageSize":@(10),@"pageNumber":@(self.currentPage)}  complete:^(BOOL successed, NSDictionary *result) {
        
        // 判断数据是否请求成功
        if (successed) {
            //json数据返回成功就是1000，否则就是1001
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                
                Result *data = [Result objectWithKeyValues:result[@"lists"]];
                weakSelf.totalPage = data.totalPages;
                [weakSelf.CellArray removeAllObjects];
                [weakSelf.CellArray addObjectsFromArray:data.content];
                WQLog(@"%@",data.introduction);
                WQLog(@"%@",weakSelf.CellArray);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
                [self.baseTableView reloadData];
                
            }
       
        }
        
    }];
}



- (void)openOrCloseLeftList
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

- (void)AFNetLoad
{
    self.ImageArray = [NSMutableArray array];
    
    WEAKSELF;
    [[HttpManager defaultManager] getRequestToUrl:DEF_GJZSEARCH params:nil complete:^(BOOL successed, NSDictionary *result) {
        WQLog(@"%@",result.allValues);
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [self.ImageArray removeAllObjects];
                [Digestion replacefmoveModelKey];
                [Digestion replacefobjlistModelKey];
                [Digestion replacefimageDicModelKey];
                moveModel *movemodel = [moveModel objectWithKeyValues:result];
                for (NSDictionary *imageDic in movemodel.objList)
                {
                    [ weakSelf.ImageArray addObject:imageDic[@"image"][@"absoluteImagePath"]];
//                    Result *result = [[Result alloc] init];
//                    result.luyanID = [imageDic objectForKey:@"businessId"];
//                    [lunboArr addObject:result];
                }
                [weakSelf.hud hide:YES];
              
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
//    [self.view addSubview:aView];
    // 轮播图
    DCPicScrollView  *picView = [[DCPicScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, aView.mj_h) WithImageNames:self.ImageArray];
    
    
    picView.placeImage = [UIImage imageNamed:@"picf.png"];
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("你点到我了😳index:%zd\n",index);
        
        ExperienceDetailViewController *DetailController = [[ExperienceDetailViewController alloc]init];
        [self.navigationController pushViewController:DetailController animated:YES];
               
    }];
    picView.AutoScrollDelay = 2.5f;
    [aView addSubview:picView];
    self.baseTableView.tableHeaderView = aView;
}

#pragma TableView 代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (!self.CellArray.count) {
        return 0;
    }
    
    return  self.CellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *string = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        
    }
    
    cell.listFrienddd = [self.CellArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExperienceDetailViewController *experienceDatailController = [[ExperienceDetailViewController alloc]init];
    experienceDatailController.listFriend = [self.CellArray objectAtIndex:indexPath.row];
    experienceDatailController.title = experienceDatailController.listFriend.title;
    [self.navigationController pushViewController:experienceDatailController animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
