//
//  HDCheckViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/29.
//  Copyright © 2016年 王文静. All rights reserved.
//
#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11
#import "HDCheckViewController.h"
#import "SQLiteBase.h"
#import "ShearchRoadCell.h"
#import "Result.h"
#import "SelectResultViewController.h"
#import "placeModel.h"
#import "SelectViewController.h"
@interface HDCheckViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *hdTableView;
    UIAlertView *customAlertView;
}
@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property(nonatomic,assign)long long sqliteSearch;
@property (nonatomic , strong) NSMutableArray *sqliteArr;
@property (nonatomic , strong) UIButton *sureBtn;  // 确认
@property (nonatomic , strong) UIButton *saveBtn; // 保存
@property (nonatomic , strong) UIButton *typeBtn; // 分类添加按钮
@property (nonatomic , copy) NSString *typeStr;
@property (nonatomic , strong) UIButton *noMoneyBtn; // 免费添加按钮
@property (nonatomic , strong) UIButton *moneyBtn; // 费用添加按钮
@property (nonatomic , copy) NSString *YNmoney;
@property (nonatomic , strong) UIButton *timeBtn; // 时间添加按钮
@property (nonatomic , copy) NSString *timeStr;
@property (nonatomic , strong) NSArray *typeArr;  //分类
@property (nonatomic , strong) NSArray *timeArr;  //时间
@end

@implementation HDCheckViewController
- (NSArray *)typeArr
{
    if (!_typeArr) {
        _typeArr = @[@"大赛",@"座谈会",@"培训会",@"户外活动",@"其他",@"路演"];
        //        0:大赛；1：座谈会；2：培训会；3：户外活动；4：其他；5：路演
    }
    return _typeArr;
}
- (NSArray *)timeArr
{
    if (!_timeArr) {
        _timeArr = @[@"今天",@"近三天",@"近一周",@"近一个月"];
        //        1：今天 2：近三天 3：近一周 4： 近一个月
    }
    return _timeArr;
}
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
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ActiviteList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
    
    [self createSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatesSel:) name:@"selectNature" object:nil];
    self.typeStr = @"";
    self.timeStr = @"";
    self.YNmoney = @"0";
}
- (void)updatesSel:(NSNotification *)not
{
    for (NSString *t in self.typeArr)
    {
        if ([not.userInfo[@"nature"] isEqualToString:t])
        {
            //            [self.typeBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.typeBtn setBackgroundColor:[UIColor orangeColor]];
            [self.typeBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
            [self.typeBtn setTitleColor:[UIColor whiteColor] forState:0];
            self.typeStr = not.userInfo[@"nature"];
            return;
        }
    }
    for(NSString *ti in self.timeArr)
    {
        if ([not.userInfo[@"nature"] isEqualToString:ti])
        {
            //            [self.timeBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.timeBtn setBackgroundColor:[UIColor orangeColor]];
            [self.timeBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
            [self.timeBtn setTitleColor:[UIColor whiteColor] forState:0];
            self.timeStr = not.userInfo[@"nature"];
            return;
        }
    }
}
- (void)createSubviews
{
    UILabel *typeLab = [[UILabel alloc]initWithFrame:CGRectMake(0,65, 80, 40)];
    typeLab.text = @"分类";
    typeLab.textAlignment = NSTextAlignmentCenter;
    typeLab.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:typeLab];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0,typeLab.mj_h + typeLab.mj_y, self.view.mj_w, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0,[line1 bottom], 80, 40)];
    moneyLab.text = @"费用";
    moneyLab.textAlignment = NSTextAlignmentCenter;
    moneyLab.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:moneyLab];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, [moneyLab bottom], self.view.mj_w, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.mj_y+line2.mj_h,  80, 40)];
    timeLab.text = @"时间";
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:timeLab];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, timeLab.mj_h + timeLab.mj_y, self.view.mj_w, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line3];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(moneyLab.mj_w, 0, 1, self.view.mj_h - 150)];
    line4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line4];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.mj_h - 150, self.view.mj_w, 1)];
    line5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line5];
    
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
    [self.view addSubview:sureBtn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBtn setFrame:CGRectMake(sureBtn.mj_w +sureBtn.mj_x +20, self.view.mj_h - 140, (self.view.frame.size.width - 60)/2, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 4;
    saveBtn.layer.borderWidth = 1;
    saveBtn.tintColor = GREENCOLOR;
    saveBtn.layer.borderColor = GREENCOLOR.CGColor;
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.saveBtn = saveBtn;
    [self.view addSubview:saveBtn];
    
    
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [typeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [typeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [typeBtn setTitle:@"分类" forState:UIControlStateNormal];
    typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    typeBtn.layer.cornerRadius = 5;
    typeBtn.clipsToBounds = YES;
    typeBtn.layer.borderWidth = 1;
    typeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [typeBtn addTarget:self action:@selector(typeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [typeBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, typeLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
    self.typeBtn = typeBtn;
    [self.view addSubview:typeBtn];
    
    UIButton *noMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noMoneyBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, moneyLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
    //    [noMoneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [noMoneyBtn addTarget:self action:@selector(noMoneyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [noMoneyBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    noMoneyBtn.layer.cornerRadius = 5;
    noMoneyBtn.clipsToBounds = YES;
    noMoneyBtn.layer.borderWidth = 1;
    noMoneyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [noMoneyBtn setTitle:@"免费" forState:UIControlStateNormal];
    noMoneyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [noMoneyBtn setBackgroundColor:[UIColor orangeColor]];
    self.noMoneyBtn = noMoneyBtn;
    [self.view addSubview:noMoneyBtn];
    
    UIButton *moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moneyBtn setFrame:CGRectMake([noMoneyBtn right]+10, moneyLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
    //    [moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [moneyBtn addTarget:self action:@selector(moneyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [moneyBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    moneyBtn.layer.cornerRadius = 5;
    moneyBtn.clipsToBounds = YES;
    moneyBtn.layer.borderWidth = 1;
    moneyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [moneyBtn setTitle:@"收费" forState:UIControlStateNormal];
    moneyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [moneyBtn setBackgroundColor:[UIColor orangeColor]];
    self.moneyBtn = moneyBtn;
    [self.view addSubview:moneyBtn];
    
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [timeBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, timeLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
    //    [timeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [timeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [timeBtn setTitle:@"时间" forState:UIControlStateNormal];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [timeBtn addTarget:self action:@selector(timeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.layer.cornerRadius = 5;
    timeBtn.clipsToBounds = YES;
    timeBtn.layer.borderWidth = 1;
    timeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.timeBtn = timeBtn;
    [self.view addSubview:timeBtn];
    
    hdTableView = [[UITableView alloc]initWithFrame:CGRectMake(timeBtn.mj_x, [line3 bottom] + 10, self.view.mj_w - timeBtn.mj_x - 10, self.view.mj_h - 180 -line3.mj_y) style:UITableViewStylePlain];
    hdTableView.delegate = self;
    hdTableView.dataSource = self;
    hdTableView.rowHeight = 40;
    hdTableView.backgroundColor = [UIColor whiteColor];
    hdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hdTableView];
}
- (void)sureBtnAction
{
    self.sureBtn.enabled = NO;
    if ([self.typeBtn.currentTitle isEqualToString:@""]) {
        [self.typeBtn setTitle:@"全部" forState:0];
        self.typeStr = @"全部";
    }
    if ([self.moneyBtn.currentTitle isEqualToString:@""]) {
        [self.moneyBtn setTitle:@"全部" forState:0];
    }
    if ([self.timeBtn.currentTitle isEqualToString:@""]) {
        [self.timeBtn setTitle:@"全部" forState:0];
        self.timeStr = @"全部";
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"2" forKey:@"status"];//路演状态
    for (int i = 0; i < self.timeArr.count; i ++ ) {
        if ([self.timeStr isEqualToString:self.timeArr[i]])
        {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"timeType"];
        }
    }
    
    for (int i = 0; i < self.typeArr.count; i ++) {
        if ([self.typeStr isEqualToString:self.typeArr[i]]) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"type"];
        }
    }
    
    [dic setObject:self.YNmoney forKey:@"isFree"];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:self.selectUrl params:dic complete:^(BOOL successed, NSDictionary *result) {
//        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                SelectResultViewController *selectVC = [[SelectResultViewController alloc] init];
                selectVC.resUrl = weakSelf.selectUrl;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.typeBtn.currentTitle?weakSelf.typeBtn.currentTitle:@"全部",weakSelf.moneyBtn.currentTitle?weakSelf.moneyBtn.currentTitle:@"全部",weakSelf.timeBtn.currentTitle?weakSelf.timeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
        self.sureBtn.enabled = YES;
    }];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveBtnAction
{
    if ([self.typeStr isEqualToString:@""] && [self.timeStr isEqualToString:@""]&&[self.YNmoney isEqualToString:@""])
    {
        showAlertView(@"条件不能同时为空");
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
                placeSearch.sqlLine = textField.text;
                placeSearch.isFree = self.YNmoney;
                //            for (int i = 0; i < self.typeArr.count; i++) {
                //                if ([self.typeStr isEqualToString:self.typeArr[i]])
                //                {
                
                //                        NSString *str = [NSString stringWithFormat:@"%d",i];
                placeSearch.strType = self.typeStr;
                //                }
                //            }
                //            for (int i = 0; i < self.timeArr.count; i ++) {
                //                if ([self.timeStr isEqualToString:self.timeArr[i]]) {
                //            NSString *str = [NSString stringWithFormat:@"%d",i];
                
                placeSearch.timeType = self.timeStr;
                
                //                }
                //            }
                
                [self.searchSqlite createWithSearchTableName:@"ActiviteList" withModel:placeSearch];
                if (self.sqliteArr.count != 0)
                {
                    [self.sqliteArr removeAllObjects];
                }
                
                self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
                [hdTableView reloadData];
                
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
- (void)typeBtnClick
{
    SelectViewController *selectVC = [[SelectViewController alloc] init];
    selectVC.numArray = [NSMutableArray arrayWithArray:self.typeArr];
    [self.navigationController pushViewController:selectVC animated:YES];
}
- (void)noMoneyBtnAction:(UIButton *)btn
{
    self.YNmoney = @"0";
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.moneyBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
}
- (void)moneyBtnAction:(UIButton *)btn
{
    self.YNmoney = @"1";
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.noMoneyBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.noMoneyBtn setBackgroundColor:[UIColor whiteColor]];
}
- (void)timeBtnAction
{
    SelectViewController *selectVC = [[SelectViewController alloc] init];
    selectVC.numArray = [NSMutableArray arrayWithArray:self.timeArr];
    [self.navigationController pushViewController:selectVC animated:YES];
}

/**
 * 重置
 */
- (void)alterAction
{
    //    self.placeNmae = @"";
    //    self.placeId = @"";
    //    self.hangStr = @"";
    
    
    [self.typeBtn setTitle:@"分类" forState:UIControlStateNormal];
    //    [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.typeBtn setBackgroundColor:[UIColor whiteColor]];
    self.typeStr = @"";
    
    //    [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.timeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.timeBtn setTitle:@"时间" forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    self.timeStr = @"";
    
    [self.noMoneyBtn setBackgroundColor:[UIColor orangeColor]];
    [self.noMoneyBtn setTitleColor:[UIColor whiteColor] forState:0];
    self.YNmoney = @"0";
    [self.moneyBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
    
    //    [self.moneyBtn setTitle:@"" forState:UIControlStateNormal];
    //    [self.moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    //    [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
    //    self.hangStr = @"";
    
    [self.searchSqlite deleteAllDataFromTableName:@"ActiviteList"];
    if (self.sqliteArr.count != 0)
    {
        [self.sqliteArr removeAllObjects];
    }
    [hdTableView reloadData];
    
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
    
    cell.typeLab.text = plmodel.sqlLine;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    placeModel *plmodel = [placeModel new];
    plmodel = self.sqliteArr[indexPath.row];
    self.timeStr = plmodel.timeType;
    self.typeStr = plmodel.strType;
    self.YNmoney = plmodel.isFree;
    [self sureBtnAction];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1)
    {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        
        placeModel *placeSearch = [placeModel new];
        placeSearch.sqlLine = nameField.text;
        placeSearch.isFree = self.YNmoney;
        //            for (int i = 0; i < self.typeArr.count; i++) {
        //                if ([self.typeStr isEqualToString:self.typeArr[i]])
        //                {
        
        //                        NSString *str = [NSString stringWithFormat:@"%d",i];
        placeSearch.strType = self.typeStr;
        //                }
        //            }
        //            for (int i = 0; i < self.timeArr.count; i ++) {
        //                if ([self.timeStr isEqualToString:self.timeArr[i]]) {
        //            NSString *str = [NSString stringWithFormat:@"%d",i];
        
        placeSearch.timeType = self.timeStr;
        
        //                }
        //            }
        
        [self.searchSqlite createWithSearchTableName:@"ActiviteList" withModel:placeSearch];
        if (self.sqliteArr.count != 0)
        {
            [self.sqliteArr removeAllObjects];
        }
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ActiviteList"] mutableCopy];
        [hdTableView reloadData];
        
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
