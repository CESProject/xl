//
//  MoneyTableViewController.m
//  Creative
//
//  Created by Mr Wei on 16/2/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MoneyTableViewController.h"
#import "SQLiteBase.h"
#import "ShearchRoadCell.h"
#import "placeModel.h"
#import "Result.h"
#import "SelectResultViewController.h"

@interface MoneyTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hdTableView;
}

@property (nonatomic , strong) UILabel *guildLab;// 行业
@property (nonatomic , strong) UILabel *areaLab;// 区域
@property (nonatomic , strong) UILabel *tenderHanLab;// 身份
@property (nonatomic , strong) NSArray *identityArr; // 身份

@property (nonatomic , strong) UILabel *tenderPlaLab;
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UIView *line5;
@property (nonatomic , strong) UIView *line7;
@property (nonatomic , strong) UIView *line8;
@property (nonatomic , strong) UIButton *sureBtn;  // 确认
@property (nonatomic , strong) UIButton *cancleBtn; // 保存
@property (nonatomic , strong) UIButton *tenderBtn;

@property (nonatomic , strong) NSArray *hangArr; //   行业
@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , strong) UIButton *guildBtn;
@property (nonatomic , strong) UIButton *placeBtn; //
@property (nonatomic , strong) UIButton *identityBtn; // 区域添加按钮
@property (nonatomic , copy) NSString *identityStr;
@property (nonatomic , strong) UIButton *tenderPlaBtn; //
@property (nonatomic , copy) NSString *tenderPlStr;
@property (nonatomic , strong) UIScrollView *btnSc;
@property (nonatomic , strong) NSArray *ageArr;
@property (nonatomic , copy) NSString *ageStr;

@property (nonatomic , strong) UILabel *tenderMonLab;
@property (nonatomic , strong) UIView *line6;

@property(nonatomic,weak)UICollectionView *col;
@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;
@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;

@property (nonatomic , strong) UIScrollView *sc;
@property (nonatomic , strong) UIView *downSectionView;
@property (nonatomic , strong) NSArray *arr;

@property (nonatomic , strong) NSArray *arrPlace;
@property (nonatomic , strong) NSArray *arrResult;

@property (nonatomic , strong) NSArray *arrTag;
@property (nonatomic , strong) NSMutableString *tags;

@property (nonatomic , strong) NSMutableString *placeIDs;

@end

@implementation MoneyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找资金搜索器";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(deleAllDateAction) withTitle:@"清空"];
    
    
    self.identityStr = @"";
    self.tenderPlStr = @"";
    
    self.hangStr = @"";
    self.placeNmae = @"";
    self.placeId = @"";
    self.identityStr = @"";
    self.ageStr = @"";
    
   
    
    hdTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    hdTableView.delegate = self;
    hdTableView.dataSource = self;
    hdTableView.rowHeight = 40;
    hdTableView.backgroundColor = [UIColor whiteColor];
    hdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hdTableView];
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];

    
    self.sqliteArr = [ NSMutableArray arrayWithArray:[self.searchSqlite searchAllDataFromSearchTableName:@"ForMoneyList"]];
    [hdTableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleAllDateAction
{
    self.identityStr = @"";
    self.tenderPlStr = @"";
    
    self.hangStr = @"";
    self.placeNmae = @"";
    self.placeId = @"";
    self.identityStr = @"";
    self.ageStr = @"";
    [self.searchSqlite deleteAllDataFromTableName:@"ForMoneyList"];
    
        [self.sqliteArr removeAllObjects];
         self.sqliteArr = [ NSMutableArray arrayWithArray:[self.searchSqlite searchAllDataFromSearchTableName:@"ForMoneyList"]];
    
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
    
    
    self.placeIDs = [NSMutableString stringWithFormat:@"%@", plmodel.cityId] ;
    self.placeNmae = plmodel.cityName;
    self.hangStr = plmodel.directTypeName  ;
    self.ageStr = plmodel.ageType  ;
    self.tags = [NSMutableString stringWithFormat:@"%@", plmodel.name]  ;
    
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
        [self.searchSqlite  deletaOneDataFromSearchTableName:@"ForMoneyList" withModel:plmodel];
      
            [self.sqliteArr removeAllObjects];
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForMoneyList"] mutableCopy];
        [hdTableView reloadData];
    }
    [hdTableView reloadData];
}

- (void)sureBtnAction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < self.hangArr.count; i ++)
    {
        if ([self.hangStr isEqualToString:self.hangArr[i]])
        {
            if (![self.hangStr isEqualToString:@"全部"])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"fundType"];//资金类型
            }
        }
    }
    
    
    if (!self.tags || [self.tags isEqualToString:@""]) {
        
    }
    else
    {
        [dic setObject:self.tags forKey:@"investmentTrade"];//投资行业
    }
    if (!self.placeIDs || [self.placeIDs isEqualToString:@""]) {
        
    }
    else
    {
        [dic setObject:self.placeIDs forKey:@"investmentArea"];//投资地区
        //        [dic setObject:self.tenderPlaBtn.titleLabel.text forKey:@"investmentAreaName"];//投资地区
    }
    
    for (int i = 0; i < self.ageArr.count; i ++)
    {
        if ([self.ageStr isEqualToString:self.ageArr[i]])
        {
            if (![self.ageStr isEqualToString:@"全部"])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                [dic setObject:str forKey:@"amountOfMoney"];//投资金额
            }
            
        }
    }
   
    
    if (!self.placeNmae || [self.placeNmae isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject:self.placeNmae forKey:@"areaName"];// 所在区域
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
    }];
    
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
