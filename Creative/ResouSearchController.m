//
//  ResouSearchController.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResouSearchController.h"
#import "common.h"
#import "UIBarButtonItem+Extension.h"
#import "RegionViewController.h"
#import "SelectViewController.h"
#import "UIView+MJExtension.h"
#import "SearchResultsViewController.h"
#import "ResouceSelectController.h"
#import "placeModel.h"
#import "SQLiteBase.h"
#import "ShearchRoadCell.h"
#import "Result.h"
#import "SelectResultViewController.h"


#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11

@interface ResouSearchController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *roadTableView;
    NSArray *arr;
     UIAlertView *customAlertView;
}

@property (nonatomic , strong) UILabel *guildLab;// 行业
@property (nonatomic , strong) UILabel *areaLab;// 区域
@property (nonatomic , strong) UILabel *identityLab;// 身份
@property (nonatomic , strong) NSArray *identityArr; // 身份

@property (nonatomic , strong) UILabel *ageLab;
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UIView *line5;
@property (nonatomic , strong) UIView *line6;
@property (nonatomic , strong) UIView *line7;
@property (nonatomic , strong) UIButton *sureBtn;  // 确认
@property (nonatomic , strong) UIButton *cancleBtn; // 保存

@property (nonatomic , strong) NSArray *hangArr; //   行业
@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , strong) UIButton *guildBtn;
@property (nonatomic , strong) UIButton *placeBtn; //
@property (nonatomic , strong) UIButton *identityBtn; // 区域添加按钮
@property (nonatomic , copy) NSString *identityStr;
@property (nonatomic , strong) UIButton *ageBtn; //
@property (nonatomic , strong) NSArray *ageArr;
@property (nonatomic , copy) NSString *ageStr;


@property(nonatomic,weak)UICollectionView *col;
@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;
@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property (nonatomic , strong) NSMutableArray *sqliteArr;


@end

@implementation ResouSearchController

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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"numberOfResouceObjects" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatesSel:) name:@"selectResouceNature" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(identyResouceNature:) name:@"identyResouceNature" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ageResouceNature:) name:@"ageResouceNature" object:nil];
    
    self.hangStr = @"";
    self.placeNmae = @"";
    self.placeId = @"";
    self.identityStr = @"";
    self.ageStr = @"";
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForTeacherList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
    
    [self createSubviews];
}
#pragma mark - NSNotification
- (void)updatesSel:(NSNotification *)not
{
    //    [self.guildBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.guildBtn setBackgroundColor:[UIColor orangeColor]];
    [self.guildBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.guildBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.hangStr = not.userInfo[@"nature"];
}

- (void)updateCol:(NSNotification *)not
{
    
    self.placeNmae = not.userInfo[@"arr"];
    self.placeId = not.userInfo[@"systemCode"];
    //    [self.placeBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor orangeColor]];
    [self.placeBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.placeBtn setTitle:not.userInfo[@"arr"] forState:UIControlStateNormal];
    
    
}

- (void)identyResouceNature:(NSNotification *)not
{
    //    [self.identityBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.identityBtn setBackgroundColor:[UIColor orangeColor]];
    [self.identityBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    [self.identityBtn setTitleColor:[UIColor whiteColor] forState:0];
    self.identityStr = not.userInfo[@"nature"];
}
- (void)ageResouceNature:(NSNotification *)not
{
    //    [self.ageBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.ageBtn setBackgroundColor:[UIColor orangeColor]];
    [self.ageBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    [self.ageBtn setTitleColor:[UIColor whiteColor] forState:0];
    self.ageStr = not.userInfo[@"nature"];
}

- (void)createSubviews
{
    UILabel *guildLab = [[UILabel alloc]initWithFrame:CGRectMake(0,65, 80, 40)];
    guildLab.text = @"从事行业";
    guildLab.textAlignment = NSTextAlignmentCenter;
    guildLab.font = [UIFont systemFontOfSize:17.0];
    self.guildLab = guildLab;
    
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, guildLab.mj_h + guildLab.mj_y, self.view.mj_w, 1)];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UILabel *areaLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line1.mj_y+line1.mj_h,  80, 40)];
    areaLab.text = @"所在区域";
    areaLab.textAlignment = NSTextAlignmentCenter;
    areaLab.font = [UIFont systemFontOfSize:17.0];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, areaLab.mj_h + areaLab.mj_y, self.view.mj_w, 1)];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 =line2;
    
    UILabel *identityLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.mj_y+line2.mj_h,  80, 40)];
    identityLab.text = @"身  份";
    identityLab.textAlignment = NSTextAlignmentCenter;
    identityLab.font = [UIFont systemFontOfSize:17.0];
    self.identityLab = identityLab;
    
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, identityLab.mj_h + identityLab.mj_y, self.view.mj_w, 1)];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    UILabel *ageLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line3.mj_y+line3.mj_h,  80, 40)];
    ageLab.text = @"年  龄";
    ageLab.textAlignment = NSTextAlignmentCenter;
    ageLab.font = [UIFont systemFontOfSize:17.0];
    self.ageLab = ageLab;
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, ageLab.mj_h + ageLab.mj_y, self.view.mj_w, 1)];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(guildLab.mj_w, 0, 1, line4.mj_y )];
    line5.backgroundColor = [UIColor grayColor];
    self.line5 = line5;
    
    
   
    
    
    UIButton *guildBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [guildBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, guildLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    [guildBtn addTarget:self action:@selector(guildBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [guildBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [guildBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    guildBtn.layer.borderWidth = 1;
    guildBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [guildBtn setTitle:@"从事行业" forState:UIControlStateNormal];
    guildBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    guildBtn.layer.cornerRadius = 5;
    guildBtn.clipsToBounds = YES;
    self.guildBtn = guildBtn;
    
    
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, areaLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    //    [placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [placeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    placeBtn.layer.borderWidth = 1;
    placeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [placeBtn setTitle:@"所在区域" forState:UIControlStateNormal];
    placeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [placeBtn addTarget:self action:@selector(placeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    placeBtn.layer.cornerRadius = 5;
    placeBtn.clipsToBounds = YES;
    self.placeBtn = placeBtn;
    
    UIButton *identityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [identityBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, identityLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    //    [identityBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [identityBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    identityBtn.layer.borderWidth = 1;
    identityBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [identityBtn setTitle:@"身份" forState:UIControlStateNormal];
    identityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [identityBtn addTarget:self action:@selector(identityBtnAction) forControlEvents:UIControlEventTouchUpInside];
    identityBtn.layer.cornerRadius = 5;
    identityBtn.clipsToBounds = YES;
    self.identityBtn = identityBtn;
    
    UIButton *ageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ageBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, ageLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    [ageBtn addTarget:self action:@selector(ageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //    [ageBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [ageBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    ageBtn.layer.borderWidth = 1;
    ageBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [ageBtn setTitle:@"年龄" forState:UIControlStateNormal];
    ageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    ageBtn.layer.cornerRadius = 5;
    ageBtn.clipsToBounds = YES;
    self.ageBtn = ageBtn;
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setFrame:CGRectMake(20, self.view.mj_h - 80, (self.view.frame.size.width - 60)/2, 30)];
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
    [cancleBtn setFrame:CGRectMake(sureBtn.mj_w +sureBtn.mj_x +20, self.view.mj_h - 80, (self.view.frame.size.width - 60)/2, 30)];
    
    [cancleBtn setTitle:@"保存" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.layer.cornerRadius = 4;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.tintColor = GREENCOLOR;
    cancleBtn.layer.borderColor = GREENCOLOR.CGColor;
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.cancleBtn = cancleBtn;
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(line5.mj_x, line4.mj_y + line4.mj_h, 1, self.view.mj_h - 100 - line4.mj_y - line4.mj_h )];
    line6.backgroundColor = [UIColor grayColor];
    self.line6 = line6;
    
    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(0, line6.mj_y + line6.mj_h, self.view.mj_w, 1)];
    line7.backgroundColor = [UIColor grayColor];
    self.line7 = line7;
    
    [self.view addSubview:ageLab];
    [self.view addSubview:guildLab];
    [self.view addSubview:line1];
    [self.view addSubview:areaLab];
    [self.view addSubview:line2];
    [self.view addSubview:identityLab];
    [self.view addSubview:line3];
    [self.view addSubview:line4];
    [self.view addSubview:line5];
    [self.view addSubview:line6];
    [self.view addSubview:line7];
    [self.view addSubview:sureBtn];
    [self.view addSubview:cancleBtn];
    [self.view addSubview:guildBtn];
    [self.view addSubview:placeBtn];
    [self.view addSubview:identityBtn];
    [self.view addSubview:ageBtn];
    
    roadTableView = [[UITableView alloc]initWithFrame:CGRectMake(placeBtn.mj_x, ageLab.mj_y + ageLab.mj_h + 10, self.view.mj_w - placeBtn.mj_x - 10, self.view.mj_h - 120 - ageLab.mj_y - ageLab.mj_h ) style:UITableViewStylePlain];
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
    
    self.hangStr = @"";
    [self.guildBtn setTitle:@"从事行业" forState:UIControlStateNormal];
    //    [self.guildBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.guildBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.guildBtn setBackgroundColor:[UIColor whiteColor]];
    
    self.placeNmae = @"";
    self.placeId = @"";
    [self.placeBtn setTitle:@"所在区域" forState:UIControlStateNormal];
    //    [self.placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.placeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.placeBtn setBackgroundColor:[UIColor whiteColor]];
    
    self.identityStr = @"";
    [self.identityBtn setTitle:@"身份" forState:UIControlStateNormal];
    [self.identityBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    //    [self.identityBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.identityBtn setBackgroundColor:[UIColor whiteColor]];
    
    self.ageStr = @"";
    [self.ageBtn setTitle:@"年龄" forState:UIControlStateNormal];
    [self.ageBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    //    [self.ageBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.ageBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.searchSqlite deleteAllDataFromTableName:@"ForTeacherList"];
    if (self.sqliteArr.count != 0)
    {
        [self.sqliteArr removeAllObjects];
    }
    [roadTableView reloadData];
}

- (void)guildBtnAction:(UIButton *)sender
{
    SelectViewController *seleVC = [[SelectViewController alloc] init];
    seleVC.numArray = [NSMutableArray arrayWithArray:self.hangArr];
    seleVC.passVc = 3;
    [self.navigationController pushViewController:seleVC animated:YES];
}

- (void)placeBtnAction
{
    
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 3;
    [self.navigationController pushViewController:regionVC animated:YES];
}
- (void)identityBtnAction
{
    ResouceSelectController *resVc = [[ResouceSelectController alloc]init];
    resVc.passVc = 3;
    resVc.numArray = [NSMutableArray arrayWithArray:self.identityArr];
    [self.navigationController pushViewController:resVc animated:YES];
}
- (void)ageBtnAction
{
    ResouceSelectController *resVc = [[ResouceSelectController alloc]init];
    resVc.passVc = 2;
    resVc.numArray = [NSMutableArray arrayWithArray:self.ageArr];
    [self.navigationController pushViewController:resVc animated:YES];
}
- (void)natureBtnAction
{
    //    SelectViewController *seleVC = [[SelectViewController alloc] init];
    //    [self.navigationController pushViewController:seleVC animated:YES];
}

- (void)sureBtnAction
{
    self.sureBtn.enabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (!self.placeId || [self.placeId isEqualToString:@""])
    {
        
    }
    else
    {
        [dic setObject: self.placeId forKey:@"cityId"]; // 城市id
    }
    for (int i = 0; i < self.hangArr.count; i ++) {
        if ([self.hangStr isEqualToString:self.hangArr[i]]) {
            if (i < 10) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"type"];
            }
        }
    }
    for (int i = 0; i < self.identityArr.count; i ++) {
        if ([self.identityStr isEqualToString:self.identityArr[i]]) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"personType"];
        }
    }
    for (int i = 0; i < self.ageArr.count; i ++ ) {
        if ([self.ageStr isEqualToString:self.ageArr[i]]) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"age"];
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
            selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.guildBtn.currentTitle?weakSelf.guildBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部" ,weakSelf.identityBtn.currentTitle?weakSelf.identityBtn.currentTitle:@"全部",nil];
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
        }
        self.sureBtn.enabled = YES;
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

- (NSArray *)identityArr
{
    if (!_identityArr) {
        _identityArr = @[ @"学生",@"军人",@"其他",@"职场人",@"创业者",@"边工作边创业"];
        //        0:学生；1：军人；2：其他;3:职场人；4:创业者；5：边工作边创业
    }
    return _identityArr;
}

- (NSArray *)ageArr
{
    if (!_ageArr) {
        _ageArr = @[@"20~30",@"30~40",@"40~50",@"50~60",@"60~70"];
        //        20~30 30~40 40~50 50~60 60~70
    }
    return _ageArr;
}

// 保存
- (void)cancleBtnAction
{
    if ([self.hangStr isEqualToString:@""] && [self.placeId isEqualToString:@""]&&[self.ageStr isEqualToString:@""] && [self.identityStr isEqualToString:@""])
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
            placeSearch.cityId = self.placeId;
            placeSearch.cityName = self.placeBtn.titleLabel.text;
            placeSearch.sqlLine = textField.text;
            placeSearch.directTypeName = self.hangStr;
            placeSearch.ageType = self.ageStr;
            placeSearch.name = self.identityStr;
            for (int i = 0; i < self.hangArr.count; i++) {
                if ([self.hangStr isEqualToString:self.hangArr[i]])
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
            if (self.sqliteArr.count != 0)
            {
                [self.sqliteArr removeAllObjects];
            }
            
            self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
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
    self.ageStr = plmodel.ageType;
    self.identityStr = plmodel.name;
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
        placeSearch.ageType = self.ageStr;
        placeSearch.name = self.identityStr;
        for (int i = 0; i < self.hangArr.count; i++) {
            if ([self.hangStr isEqualToString:self.hangArr[i]])
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
        if (self.sqliteArr.count != 0)
        {
            [self.sqliteArr removeAllObjects];
        }
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForTeacherList"] mutableCopy];
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
