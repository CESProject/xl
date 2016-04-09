//
//  CheckSearchController.m
//  Creative
//
//  Created by Mr Wei on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//  ************  筛选   *******************

#import "CheckSearchController.h"
#import "UIBarButtonItem+Extension.h"
#import "RegionViewController.h"
#import "SelectViewController.h"
#import "UIView+MJExtension.h"
#import "SelectResultViewController.h"
#import "common.h"
#import "Result.h"
#import "SQLiteBase.h"
#import "placeModel.h"
#import "ShearchRoadCell.h"
#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11

@interface CheckSearchController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *roadTableView;
    NSArray *arr;
    UIAlertView *customAlertView;
}
//@property (nonatomic , strong) CheckSearchView *checkView;

@property (nonatomic , strong) UILabel *natureLab;// 性质
@property (nonatomic , strong) UILabel *leftLab;// 方向
@property (nonatomic , strong) UILabel *placeLab;// 地方
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UIView *line5;
@property (nonatomic , strong) UIButton *sureBtn;  // 确认
@property (nonatomic , strong) UIButton *cancleBtn; // 保存
@property (nonatomic , strong) UIButton *leftBtn; // 方向添加按钮
@property (nonatomic , strong) UIButton *placeBtn; // 地方添加按钮
//@property (nonatomic , strong) UIButton *placeBtn1; // 地方添加按钮

@property (nonatomic , strong) UIButton *upBtn; // 性质添加按钮
@property (nonatomic , strong) UIButton *downBtn;
@property (nonatomic , strong) UIButton *allBtn;

@property(nonatomic,weak)UICollectionView *col;
@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@property (nonatomic , strong) NSArray *hangArr; //   行业
@property (nonatomic , copy) NSString *hangStr;

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property(nonatomic,assign)long long sqliteSearch;
@property (nonatomic , strong) NSMutableArray *sqliteArr;


@end

@implementation CheckSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"筛选";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(alterAction) withTitle:@"重置"];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"numberOfInformObjects" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatesSel:) name:@"selectNature" object:nil];
    self.hangStr = @"";
    self.placeId = @"";
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"SearchList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"SearchList"] mutableCopy];
    
    [self createSubviews];
}

- (void)updateCol:(NSNotification *)not
{
    self.placeNmae = not.userInfo[@"arr"];
    //    self.placeId = not.userInfo[@"id"];
    self.placeId = not.userInfo[@"systemCode"];
    
    
    //    [self.placeBtn removeFromSuperview];
    //    [self.view addSubview:self.placeBtn1];
    [self.placeBtn setTitle:not.userInfo[@"arr"] forState:UIControlStateNormal];
    [self.placeBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor orangeColor]];
}
- (void)updatesSel:(NSNotification *)not
{
    [self.leftBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:[UIColor orangeColor]];
    [self.leftBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.hangStr = not.userInfo[@"nature"];
}
- (void)createSubviews
{
    UILabel *natureLab = [[UILabel alloc]initWithFrame:CGRectMake(0,65, 80, 40)];
    natureLab.text = @"性质";
    natureLab.textAlignment = NSTextAlignmentCenter;
    natureLab.font = [UIFont systemFontOfSize:17.0];
    self.natureLab = natureLab;
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0,natureLab.mj_h + natureLab.mj_y, self.view.mj_w, 1)];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0,65, 80, 40)];
    leftLab.text = @"方向";
    leftLab.textAlignment = NSTextAlignmentCenter;
    leftLab.font = [UIFont systemFontOfSize:17.0];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, leftLab.mj_h + leftLab.mj_y, self.view.mj_w, 1)];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 =line2;
    
    UILabel *placeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.mj_y+line2.mj_h,  80, 40)];
    placeLab.text = @"地区";
    placeLab.textAlignment = NSTextAlignmentCenter;
    placeLab.font = [UIFont systemFontOfSize:17.0];
    self.placeLab = placeLab;
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, placeLab.mj_h + placeLab.mj_y, self.view.mj_w, 1)];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(leftLab.mj_w, 0, 1, self.view.mj_h - 150)];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.mj_h - 150, self.view.mj_w, 1)];
    line5.backgroundColor = [UIColor grayColor];
    self.line5 = line5;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setFrame:CGRectMake(20, self.view.mj_h - 140, (self.view.frame.size.width - 60)/2, 30)];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 4;
    sureBtn.layer.borderWidth = 1;
    sureBtn.tintColor = GREENCOLOR;
    sureBtn.layer.borderColor = GREENCOLOR.CGColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.sureBtn = sureBtn;
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setFrame:CGRectMake(sureBtn.mj_w +sureBtn.mj_x +20, self.view.mj_h - 140, (self.view.frame.size.width - 60)/2, 30)];
    //    [cancleBtn setBackgroundColor:[UIColor grayColor]];
    [cancleBtn setTitle:@"保存" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.layer.cornerRadius = 4;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.tintColor = GREENCOLOR;
    cancleBtn.layer.borderColor = GREENCOLOR.CGColor;
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.cancleBtn = cancleBtn;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [leftBtn setTitle:@"方向" forState:UIControlStateNormal];//设置title
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    leftBtn.layer.borderColor = [UIColor grayColor].CGColor;
    leftBtn.layer.borderWidth = 1.0f;
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setBackgroundColor:[UIColor whiteColor]];
    leftBtn.layer.cornerRadius = 5;
    leftBtn.clipsToBounds = YES;
    [leftBtn addTarget:self action:@selector(natureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, leftLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
    self.leftBtn = leftBtn;
    
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, placeLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
//    [placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [placeBtn addTarget:self action:@selector(placeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [placeBtn setTitle:@"地区" forState:UIControlStateNormal];//设置title
    [placeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    placeBtn.layer.borderColor = [UIColor grayColor].CGColor;
    placeBtn.layer.borderWidth = 1.0f;
    placeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [placeBtn setBackgroundColor:[UIColor whiteColor]];
    placeBtn.layer.cornerRadius = 5;
    placeBtn.clipsToBounds = YES;
    self.placeBtn = placeBtn;
    
    
    [self.view addSubview:leftLab];
    [self.view addSubview:line2];
    [self.view addSubview:placeLab];
    [self.view addSubview:line3];
    [self.view addSubview:line4];
    [self.view addSubview:line5];
    [self.view addSubview:sureBtn];
    [self.view addSubview:cancleBtn];
    [self.view addSubview:leftBtn];
    [self.view addSubview:placeBtn];
    
    roadTableView = [[UITableView alloc]initWithFrame:CGRectMake(placeBtn.mj_x, placeLab.mj_y + placeLab.mj_h + 10, self.view.mj_w - placeBtn.mj_x - 10, self.view.mj_h - 180 - placeLab.mj_y - placeLab.mj_h) style:UITableViewStylePlain];
    roadTableView.delegate = self;
    roadTableView.dataSource = self;
    roadTableView.rowHeight = 40;
    roadTableView.backgroundColor = [UIColor whiteColor];
    roadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:roadTableView];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alterAction
{
    self.placeNmae = @"";
    self.placeId = @"";
    self.hangStr = @"";
    
    
//    [self.placeBtn setTitle:@"" forState:UIControlStateNormal];
//    [self.placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];

    [self.placeBtn setTitle:@"地区" forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor whiteColor]];
    
//    [self.leftBtn setTitle:@"" forState:UIControlStateNormal];
//    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];

     [self.leftBtn setTitle:@"方向" forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.searchSqlite deleteAllDataFromTableName:@"SearchList"];
    if (self.sqliteArr.count != 0)
    {
        [self.sqliteArr removeAllObjects];
    }
    [roadTableView reloadData];
    
}

- (void)placeBtnAction
{
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    [self.navigationController pushViewController:regionVC animated:YES];
}

- (void)natureBtnClick
{
    SelectViewController *seleVC = [[SelectViewController alloc] init];
    seleVC.numArray = [NSMutableArray arrayWithArray:self.hangArr];
    [self.navigationController pushViewController:seleVC animated:YES];
}
- (void)sureBtnAction
{
    if ([self.leftBtn.currentTitle isEqualToString:@""]) {
        [self.leftBtn setTitle:@"全部" forState:0];
    }
    if ([self.placeBtn.currentTitle isEqualToString:@""]) {
        [self.placeBtn setTitle:@"全部" forState:0];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.placeId forKey:@"cityId"]; // 城市id
    }
    [dic setObject:@"2" forKey:@"status"];//路演状态
    for (int i = 0; i < self.hangArr.count; i++) {
        if ([self.hangStr isEqualToString:self.hangArr[i]])
        {
            if (i < 10)
            {
                NSString *str1 = [NSString stringWithFormat:@"0%d",i];
                [dic setObject:str1 forKey:@"directionType"];//路演方向类别                
            }
            else
            {
                NSString *str2 = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str2 forKey:@"directionType"];//路演方向类别
            }
        }
    }
    WEAKSELF;

    [[HttpManager defaultManager] postRequestToUrl:DEF_LUYANGJZSEARCH params:dic complete:^(BOOL successed, NSDictionary *result) {
//        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                 selectVC.resUrl = DEF_LUYANGJZSEARCH;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.leftBtn.currentTitle?weakSelf.leftBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
    }];
}

- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"互联网",@"移动互联网",@"IT",@"电信及增值",@"传媒娱乐",@"能源",@"医疗健康",@"旅行",@"游戏",@"金融",@"教育",@"房地产",@"物流仓库",@"农林牧渔",@"住宿餐饮",@"商品服务",@"消费品",@"文体艺术",@"加工制造",@"节能环保",@"其他"];
        //        00：互联网；01:移动互联网；02：IT;03:电信及增值；04：传媒娱乐；05：能源；06：医疗健康；07：旅行；08：游戏；09：金融；10：教育；11：房地产；12：物流仓库；13：农林牧渔；14：住宿餐饮；15：商品服务；16：消费品；17：文体艺术；18：加工制造；19:节能环保；20：其他；
    }
    return _hangArr;
}
// 保存
- (void)cancleBtnAction
{
    if ([self.hangStr isEqualToString:@""] && [self.placeId isEqualToString:@""])
    {
        showAlertView(@"方向和地区不能同时为空");
    }
    else
    {
        if (isIOS7)
        {
            if (customAlertView==nil) {
                customAlertView = [[UIAlertView alloc] initWithTitle:@"请输入保存名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            }
            [customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
            
            UITextField *nameField = [customAlertView textFieldAtIndex:0];
            nameField.placeholder = @"请输入一个名称";
//            nameField.secureTextEntry = NO;
            [customAlertView show];
        }
        else
        {
            UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入保存名称" preferredStyle:UIAlertControllerStyleAlert];
            
            //添加Action
            
            UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                UITextField *textField = alterVC.textFields[0];
                
                placeModel *placeSearch = [placeModel new];
                placeSearch.cityId = self.placeId;
                placeSearch.cityName = self.placeBtn.titleLabel.text;
                placeSearch.sqlLine = textField.text;
                placeSearch.directTypeName = self.hangStr;
                for (int i = 0; i < self.hangArr.count; i++) {
                    if ([self.hangStr isEqualToString:self.hangArr[i]])
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
                if (self.sqliteArr.count != 0)
                {
                    [self.sqliteArr removeAllObjects];
                }
                
                self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"SearchList"] mutableCopy];
                [roadTableView reloadData];
                
                
                
            }];
            
            
            
            //放弃Action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            //添加UITextField
            [alterVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                
            }];
            
            //给alter视图添加Action操作
            [alterVC addAction:addAction];
            [alterVC addAction:cancelAction];
            [self presentViewController:alterVC animated:YES completion:nil];
        }
    }

}

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
    placeModel *plmodel = [placeModel new];
    plmodel = self.sqliteArr[indexPath.row];
    //    if ([plmodel.directTypeName isEqualToString:@"(null)"] || [plmodel.directTypeName isEqualToString:@""]) {
    //        plmodel.directTypeName = @"()";
    //    }
    //    if ([plmodel.cityName isEqualToString:@"(null)"]) {
    //        plmodel.cityName = @"()";
    //    }
    cell.typeLab.text = plmodel.sqlLine;
    //    cell.typeLab.text = plmodel.directTypeName;
    //    cell.placeLab.text = plmodel.cityName;
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1)
    {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        
        placeModel *placeSearch = [placeModel new];
        placeSearch.cityId = self.placeId;
        placeSearch.cityName = self.placeBtn.titleLabel.text;
        placeSearch.sqlLine = nameField.text;
        placeSearch.directTypeName = self.hangStr;
        for (int i = 0; i < self.hangArr.count; i++) {
            if ([self.hangStr isEqualToString:self.hangArr[i]])
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
        if (self.sqliteArr.count != 0)
        {
            [self.sqliteArr removeAllObjects];
        }
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"SearchList"] mutableCopy];
        [roadTableView reloadData];
        
    }
    
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
