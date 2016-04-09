//
//  PlaceTableViewController.m
//  Creative
//
//  Created by Mr Wei on 16/2/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "SelectResultViewController.h"
#import "ShearchRoadCell.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "Result.h"

@interface PlaceTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hdTableView;
}
@property (nonatomic , strong) NSArray *hangArr; //   行业
@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;

@end

@implementation PlaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找场地搜索器";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(deleAllDateAction) withTitle:@"清空"];
    
    
    self.placeNmae = @"";
    self.placeId = @"";
    self.hangStr = @"";
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForPlaceList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForPlaceList"] mutableCopy];
    
    hdTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    hdTableView.delegate = self;
    hdTableView.dataSource = self;
    hdTableView.rowHeight = 40;
    hdTableView.backgroundColor = [UIColor whiteColor];
    hdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hdTableView];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleAllDateAction
{
    self.placeNmae = @"";
    self.placeId = @"";
    self.hangStr = @"";
    
    [self.searchSqlite deleteAllDataFromTableName:@"ForPlaceList"];
    
    [self.sqliteArr removeAllObjects];
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForPlaceList"] mutableCopy];
    [hdTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sqliteArr.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShearchRoadCell *cell = [ShearchRoadCell cellWithTabelView:tableView];
    if (self.sqliteArr.count != 0)
    {
        placeModel *plmodel = [placeModel new];
        plmodel = self.sqliteArr[indexPath.row];
        
        cell.typeLab.text = plmodel.sqlLine;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    placeModel *plmodel = [placeModel new];
    plmodel = self.sqliteArr[indexPath.row];
    self.placeId = plmodel.cityId;
    self.hangStr = plmodel.directTypeName;
    [self sureBtnAction];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
}

//删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        placeModel *plmodel = [placeModel new];
        plmodel = self.sqliteArr[indexPath.row];
        [self.searchSqlite  deletaOneDataFromSearchTableName:@"ForPlaceList" withModel:plmodel];
        
        [self.sqliteArr removeAllObjects];
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForPlaceList"] mutableCopy];
        [hdTableView reloadData];
    }
    [hdTableView reloadData];
}

- (void)sureBtnAction
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.placeId forKey:@"cityId"]; // 城市id
    }
    for (int i = 0; i < self.hangArr.count; i++)
    {
        if ([self.hangStr isEqualToString:self.hangArr[i]])
        {
            if (![self.hangStr isEqualToString:@"全部"])
            {
                NSString *str2 = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str2 forKey:@"areaType"];//场地类型
            }
        }
    }
    WEAKSELF;
    //    self.selectUrl
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

- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"全部",@"五星酒店",@"四星酒店",@"三星酒店",@"酒吧咖啡",@"餐厅",@"会议中心",@"培训中心",@"广场超市",@"剧院",@"会所",@"度假村",@"体育馆",@"文化古建",@"赛车试驾"];
        //     0：五星酒店；1：四星酒店；2：三星酒店；3：酒吧咖啡；4：餐厅；5：会议中心；6：培训中心；7：广场超市；8：剧院；9：会所；10：度假村；11：体育馆；12：文化古建；13:赛车试驾
    }
    return _hangArr;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
