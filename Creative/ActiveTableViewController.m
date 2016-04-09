//
//  ActiveTableViewController.m
//  Creative
//
//  Created by Mr Wei on 16/2/24.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ActiveTableViewController.h"
#import "ShearchRoadCell.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "Result.h"
#import "SelectResultViewController.h"

@interface ActiveTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hdTableView;
}
@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;

@property (nonatomic , strong) NSArray *typeArr;  //分类
@property (nonatomic , strong) NSString *typeStr;
@property (nonatomic , strong) NSArray *timeArr;  //时间
@property (nonatomic , strong) NSString *timeStr;
@property (nonatomic , strong) NSArray *isfreeArr;
@property (nonatomic , strong) NSString *freeStr;
@property (nonatomic , strong) NSString *startTime;
@property (nonatomic , strong) NSString *endTime;

@end

@implementation ActiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"活动搜索器";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(deleAllDateAction) withTitle:@"清空"];
    
    self.timeStr = @"";
    self.typeStr = @"";
    self.freeStr = @"";
    self.endTime = @"";
    self.startTime = @"";
    
    hdTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    hdTableView.delegate = self;
    hdTableView.dataSource = self;
    hdTableView.rowHeight = 40;
    hdTableView.backgroundColor = [UIColor whiteColor];
    hdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hdTableView];
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ActiviteList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
}

- (void)deleAllDateAction
{
    self.timeStr = @"";
    self.typeStr = @"";
    self.freeStr = @"";
    self.endTime = @"";
    self.startTime = @"";
    
    [self.searchSqlite deleteAllDataFromTableName:@"ActiviteList"];
    
        [self.sqliteArr removeAllObjects];
     self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
    
    [hdTableView reloadData];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if (self.sqliteArr.count != 0) {
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
//    self.timeStr = plmodel.timeType;
    self.endTime = plmodel.endTime;
    self.startTime = plmodel.startTime;
    self.typeStr = plmodel.strType;
    self.freeStr = plmodel.isFree;
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
        [self.searchSqlite  deletaOneDataFromSearchTableName:@"ActiviteList" withModel:plmodel];
        
            [self.sqliteArr removeAllObjects];
        

        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
        [hdTableView reloadData];
    }
    [hdTableView reloadData];
}

- (void)sureBtnAction
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"2" forKey:@"status"];//路演状态
//    for (int i = 0; i < self.timeArr.count; i ++ ) {
//        if ([self.timeStr isEqualToString:self.timeArr[i]])
//        {
//            if (i == 0) {
//                
//            }else
//            {
//                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
//                [dic setObject:str forKey:@"timeType"];
//            }
//        }
//    }

    
    if (!self.startTime || [self.startTime isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject:self.startTime forKey:@"startTime"];
    }
    if (!self.endTime || [self.endTime isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject:self.endTime forKey:@"endTime"];
    }
    for (int i = 0; i < self.typeArr.count; i ++) {
        if ([self.typeStr isEqualToString:self.typeArr[i]]) {
            if (i == 0) {
                
            }else
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"type"];
            }
            
        }
    }
    for (int i = 0; i < self.isfreeArr.count; i ++) {
        if ([self.freeStr isEqualToString:self.isfreeArr[i]]) {
            if (i == 0) {
                
            }else
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"isFree"];
            }
        }
    }
    
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
    }];
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
        _timeArr = @[@"全部",@"今天",@"近三天",@"近一周",@"近一个月"];
        //        1：今天 2：近三天 3：近一周 4： 近一个月
    }
    return _timeArr;
}

- (NSArray *)isfreeArr
{
    if (!_isfreeArr) {
        _isfreeArr = @[@"全部",@"免费",@"收费"];
        
    }
    return _isfreeArr;
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
