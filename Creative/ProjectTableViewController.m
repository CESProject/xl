//
//  ProjectTableViewController.m
//  Creative
//
//  Created by Mr Wei on 16/2/28.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "SelectResultViewController.h"
#import "ShearchRoadCell.h"
#import "placeModel.h"
#import "SQLiteBase.h"
#import "Result.h"

@interface ProjectTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *roadTableView;


    
}

@property (nonatomic , strong) SQLiteBase *searchSqlite;

@property (nonatomic , strong) NSMutableArray *sqliteArr;

@property (nonatomic , strong) UIButton *phaseCOlBtn;
@property (nonatomic , strong) UIButton *tenderBtn ; // 项目投资
@property (nonatomic , copy) NSString *tendePhaserStr;
@property (nonatomic , copy) NSString *tenderStr;
@property (nonatomic , strong) UIButton *COLLBtn; // 合伙人
@property (nonatomic , copy) NSString *COLLStr;
@property (nonatomic , strong) UIButton *moneyBtn; // 现有资金
@property (nonatomic , copy) NSString *moneyStr;
@property (nonatomic , strong) UIButton *personBtn; // 参与人数
@property (nonatomic , copy) NSString *personStr;
@property (nonatomic , strong) NSArray *moneyArr;
@property (nonatomic , strong) NSArray *personTypeArr;
@property (nonatomic , strong) NSArray *personNumArr;
@property (nonatomic , strong) NSArray *tenderArr; // 项目投资
@property (nonatomic , strong) NSArray *projectJieArr;
@property (nonatomic , strong) NSArray *zhongJieArr;
@property (nonatomic , strong) NSArray *shapeArr;
@property (nonatomic , copy) NSString *hangStr; // 互联网
@property (nonatomic , strong) NSArray *hangArr; //   行业
@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@property (nonatomic , copy) NSString *shapeStr; // 合作，外包
@property (nonatomic , copy) NSString *phaseStr;



@end

@implementation ProjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"筛选搜索器";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(deleAllDateAction) withTitle:@"清空"];
    
    self.shapeStr = @"";
    self.placeId = @"";
    self.placeNmae = @"";
    self.hangStr = @"";
    self.tendePhaserStr = @"";
    self.moneyStr = @"";
    self.tenderStr = @"";
    self.personStr = @"";
    self.COLLStr = @"";
    self.phaseStr = @"";
    
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ProjectList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
    
    
    roadTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    roadTableView.delegate = self;
    roadTableView.dataSource = self;
    roadTableView.rowHeight = 40;
    roadTableView.backgroundColor = [UIColor whiteColor];
    roadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:roadTableView];
    
}

- (void)deleAllDateAction
{
    self.shapeStr = @"";
    self.placeId = @"";
    self.placeNmae = @"";
    self.hangStr = @"";
    self.tendePhaserStr = @"";
    self.moneyStr = @"";
    self.tenderStr = @"";
    self.personStr = @"";
    self.COLLStr = @"";
    self.phaseStr = @"";
    
    [self.searchSqlite deleteAllDataFromTableName:@"ProjectList"];
    
        [self.sqliteArr removeAllObjects];
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
   
    [roadTableView reloadData];
    
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
    if (plmodel.cityId)
    {
        self.placeId = plmodel.cityId;
    }
    if (plmodel.strType)
    {
        self.shapeStr = plmodel.strType;
    }
    if (plmodel.partnerType)
    {
        self.COLLStr = plmodel.partnerType;
    }
    if (plmodel.teamNum)
    {
        self.personStr = plmodel.teamNum;
    }
    if (plmodel.strMoneyType )
    {
        self.tenderStr = plmodel.strMoneyType ;
    }
    if (plmodel.existingFundsType)
    {
        self.moneyStr = plmodel.existingFundsType;
    }
    if ( plmodel.cooperationStage) {
        self.tendePhaserStr = plmodel.cooperationStage;
    }
    if (plmodel.theme)
    {
        self.phaseStr = plmodel.theme;
    }
    
    
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
        [self.searchSqlite  deletaOneDataFromSearchTableName:@"ProjectList" withModel:plmodel];
        
            [self.sqliteArr removeAllObjects];
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
        [roadTableView reloadData];
    }
    [roadTableView reloadData];
}

- (void)sureBtnAction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 项目类型
    if (self.shapeStr) {
        for (int i = 0; i < self.shapeArr.count; i ++) {
            if ([self.shapeStr isEqualToString:self.shapeArr[i]])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"type"];
            }
        }
    }
    
    /// 地区 ID
    if ([self.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.placeId forKey:@"cityId"]; // 城市id
    }
    /// 项目方向
    if ( self.shapeStr) {
        for (int i = 0; i < self.hangArr.count; i++) {
            if ([self.hangStr isEqualToString:self.hangArr[i]])
            {
                if (![self.hangStr isEqualToString:@"全部"]) {
                    if (i - 1 < 10)
                    {
                        NSString *str1 = [NSString stringWithFormat:@"0%d",i - 1];
                        [dic setObject:str1 forKey:@"directionType"];
                    }
                    else
                    {
                        NSString *str2 = [NSString stringWithFormat:@"%d",i -1];
                        [dic setObject:str2 forKey:@"directionType"];
                    }
                }
            }
        }
    }
    
    
    if (self.moneyStr) {
        for (int i = 0; i < self.moneyArr.count; i ++)
        {
            if ([self.moneyStr isEqualToString:self.moneyArr[i]])
            {
                if (![self.moneyStr isEqualToString:@"全部"])
                {
                    NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str forKey:@"existingFundsType"];
                }
            }
        }
    }
    if (self.tenderStr) {
        for (int i = 0 ; i < self.tenderArr.count; i ++)
        {
            if ([self.tenderStr isEqualToString:self.tenderArr[i]])
            {
                if (![self.tenderStr isEqualToString:@"全部"])
                {
                    NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str forKey:@"initMoneyType"];
                }
            }
        }
    }
    if (self.personStr) {
        for (int i = 0; i < self.personNumArr.count; i ++)
        {
            if ([self.personStr isEqualToString:self.personNumArr[i]])
            {
                if (![self.personStr isEqualToString:@"全部"])
                {
                    NSString *str = [NSString stringWithFormat:@"%d",i -1];
                    [dic setObject:str forKey:@"teamNum"];
                }
            }
        }
    }
    
    if (self.COLLStr) {
        for (int i = 0; i < self.personTypeArr.count; i ++)
        {
            if ([self.COLLStr isEqualToString:self.personTypeArr[i]])
            {
                if (![self.COLLStr isEqualToString:@"全部"])
                {
                    NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str forKey:@"partnerType"];
                }
            }
        }
    }
    
    if (self.phaseStr)
    {
        /// 项目阶段（众筹）
        for (int i = 0; i < self.zhongJieArr.count; i ++) {
            if ([self.phaseStr isEqualToString:self.zhongJieArr[i]])
            {
                if (![self.phaseStr isEqualToString:@"全部"])
                {
                    NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str forKey:@"cooperationStage"];
                }
            }
        }
    }
    
    //    项目阶段
    if (self.tendePhaserStr) {
        /// 项目阶段（合作）
        for (int i = 0; i < self.projectJieArr.count; i ++)
        {
            if ([self.tendePhaserStr isEqualToString:self.projectJieArr[i]])
            {
                if (![self.tendePhaserStr isEqualToString:@"全部"])
                {
                    NSString *str = [NSString stringWithFormat:@"%d",i - 1];
                    [dic setObject:str forKey:@"cooperationStage"];
                }
            }
        }
    }
    
    
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_XMGJZSEARCHYI params:dic complete:^(BOOL successed, NSDictionary *result) {
        //        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                selectVC.resUrl = DEF_XMGJZSEARCHYI;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                //                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.shapeBtn.currentTitle?weakSelf.shapeBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
        
    }];
}


- (NSArray *)shapeArr
{
    if (!_shapeArr) {
        _shapeArr = @[@"全 部",@"外  包",@"合  作",@"股权众筹",@"奖励众筹"];
    }
    return _shapeArr;
}
- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"全部",@"互联网",@"移动互联网",@"IT",@"电信及增值",@"传媒娱乐",@"能源",@"医疗健康",@"旅行",@"游戏",@"金融",@"教育",@"房地产",@"物流仓库",@"农林牧渔",@"住宿餐饮",@"商品服务",@"消费品",@"文体艺术",@"加工制造",@"节能环保",@"其他"];
        //        00：互联网；01:移动互联网；02：IT;03:电信及增值；04：传媒娱乐；05：能源；06：医疗健康；07：旅行；08：游戏；09：金融；10：教育；11：房地产；12：物流仓库；13：农林牧渔；14：住宿餐饮；15：商品服务；16：消费品；17：文体艺术；18：加工制造；19:节能环保；20：其他；
    }
    return _hangArr;
}
- (NSArray *)moneyArr
{
    if (!_moneyArr) {
        _moneyArr = @[@"全部",@"50万以下",@"50~100万",@"100~200万",@"200~500万",@"500~1000万",@"1000万以上"];
        //        0:50万以下；1:50~100万；2:100~200万；3:200~500万；4：500~1000万；5：1000万以上
    }
    return _moneyArr;
}

- (NSArray *)personTypeArr
{
    if (!_personTypeArr) {
        _personTypeArr = @[@"全部",@"技术合伙人",@"营销合伙人",@"产品合伙人",@"运营合伙人",@"设计合伙人",@"其他合伙人"];
        //0：技术合伙人；1:营销合伙人；2：产品合伙人；3：运营合伙人；4：设计合伙人；5：其他合伙人
    }
    return _personTypeArr;
}
- (NSArray *)personNumArr
{
    if (!_personNumArr) {
        _personNumArr = @[@"全部",@"5人以下",@"5~10人",@"10~20人",@"20~50人",@"50人以上"];
        //        	5人以下 5~10人 10~20人 20~50人 50人以上
    }
    return _personNumArr;
}

- (NSArray *)tenderArr
{
    if (!_tenderArr) {
        _tenderArr = @[@"全部",@"等待投资",@"个人出资",@"天使投资",@"A  轮",@"B  轮",@"C  轮"];
        //        等待投资 个人出资 天使投资 A轮 B轮 C轮
        
    }
    return _tenderArr;
}
- (NSArray *)projectJieArr
{
    if (!_projectJieArr) {
        _projectJieArr = @[@"全部",@"有个好主意",@"产品开发中",@"上线运营"];
        //有个好主意 产品开发中 上线运营
    }
    return _projectJieArr;
}
- (NSArray *)zhongJieArr
{
    if (!_zhongJieArr) {
        _zhongJieArr = @[@"全部",@"概念阶段",@"研发中",@"已正式发布",@"已经盈利"];
        //概念阶段 研发中 已正式发布 已经盈利
    }
    return _zhongJieArr;
}


@end
