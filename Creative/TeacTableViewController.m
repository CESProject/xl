//
//  TeacTableViewController.m
//  Creative
//
//  Created by Mr Wei on 16/2/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "TeacTableViewController.h"

#import "ShearchRoadCell.h"
#import "placeModel.h"
#import "Result.h"
#import "SQLiteBase.h"
#import "SelectResultViewController.h"

@interface TeacTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
}


@property (nonatomic , strong) NSArray *hangArr;
@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , strong) NSArray *identityArr;
@property (nonatomic , strong) NSString *identityStr;
@property (nonatomic , strong) NSArray *ageArr;
@property (nonatomic , copy) NSString *ageStr;

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;

@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@end

@implementation TeacTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找导师搜索器";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(deleAllDateAction) withTitle:@"清空"];
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForTeacherList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
    
    
    self.placeId = @"";
    self.hangStr = @"";
    self.ageStr = @"";
    self.identityStr = @"";
    
    
    myTableVIew = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.rowHeight = 120;
    myTableVIew.backgroundColor = [UIColor whiteColor];
    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleAllDateAction
{
    self.placeId = @"";
    self.hangStr = @"";
    self.ageStr = @"";
    self.identityStr = @"";
    
    [self.searchSqlite deleteAllDataFromTableName:@"ForTeacherList"];
   
        [self.sqliteArr removeAllObjects];
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
   
    [myTableVIew reloadData];
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
    self.ageStr = plmodel.ageType;
    self.identityStr = plmodel.name;
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
        [self.searchSqlite  deletaOneDataFromSearchTableName:@"ForTeacherList" withModel:plmodel];
        
            [self.sqliteArr removeAllObjects];
       
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
        [myTableVIew reloadData];
    }
    [myTableVIew reloadData];
}


- (void)sureBtnAction
{

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (!self.placeId || [self.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.placeId forKey:@"cityId"]; // 城市id
    }
    
    for (int i = 0; i < self.hangArr.count; i ++)
    {
        if ([self.hangStr isEqualToString:self.hangArr[i]])
        {
            if (![self.hangStr isEqualToString:@"全部"])
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
        if ([self.identityStr isEqualToString:self.identityArr[i]])
        {
            if (![self.identityStr isEqualToString:@"全部"])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i -1];
                [dic setObject:str forKey:@"personType"];
            }
        }
    }
    
    for (int i = 0; i < self.ageArr.count; i ++ )
    {
        if ([self.ageStr isEqualToString:self.ageArr[i]])
        {
            if (![self.ageStr isEqualToString:@"全部"])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"age"];
            }
        }
    }
    
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
    }];
    
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
