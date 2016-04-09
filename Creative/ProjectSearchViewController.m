//
//  ProjectSearchViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/30.
//  Copyright © 2016年 王文静. All rights reserved.
// ***************  项目筛选  ***************

#import "ProjectSearchViewController.h"

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
#import "ShapeViewController.h"
#import "PhaseViewController.h"
#import "PhaseColViewController.h"
#import "ParTenViewController.h"
#import "PartnerTypeViewController.h"
#import "MoneyTypeViewController.h"
#import "PersonNumViewController.h"

#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11

@interface ProjectSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *roadTableView;
    NSArray *arr;
    UIAlertView *customAlertView;
    
}

//@property (nonatomic , strong) CheckSearchView *checkView;

@property (nonatomic , strong) UILabel *natureLab;// 性质
@property (nonatomic , strong) UILabel *shapeLab;// 方向
@property (nonatomic , strong) UILabel *placeLab;// 地方
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UIView *line5;
@property (nonatomic , strong) UIButton *sureBtn;  // 确认
@property (nonatomic , strong) UIButton *cancleBtn; // 保存
@property (nonatomic , strong) UIButton *shapeBtn; // 方向添加按钮
@property (nonatomic , strong) UIButton *placeBtn; // 地方添加按钮
@property (nonatomic , strong) UIButton *placeBtn1; // 地方添加按钮

@property (nonatomic , strong) UIButton *upBtn; // 性质添加按钮
@property (nonatomic , strong) UIButton *downBtn;
@property (nonatomic , strong) UIButton *allBtn;

@property(nonatomic,weak)UICollectionView *col;
@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;


@property (nonatomic , copy) NSString *shapeStr; // 合作，外包

@property (nonatomic , strong) SQLiteBase *searchSqlite;
@property(nonatomic,assign)long long sqliteSearch;
@property (nonatomic , strong) NSMutableArray *sqliteArr;
@property (nonatomic , strong) UIScrollView *sc;
@property (nonatomic , strong) UIView *line6 ;
@property (nonatomic , strong) UIView *downSectionView;

@property (nonatomic , strong) UIView *projectLefView; // 项目方向
@property (nonatomic , assign) BOOL YNLeft;
@property (nonatomic , strong) UIButton *leftBtn;
@property (nonatomic , copy) NSString *hangStr; // 互联网
@property (nonatomic , strong) NSArray *hangArr; //   行业

@property (nonatomic , strong) UIView *phaseView; // 阶段
@property (nonatomic , assign) BOOL YNphase;
@property (nonatomic , strong) UIButton *phaseBtn;
@property (nonatomic , copy) NSString *phaseStr;

@property (nonatomic , strong) UIView *collaborationView; // 合作
@property (nonatomic , assign) BOOL YNcoll;
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


@end

@implementation ProjectSearchViewController

- (UIView *)projectLefView
{
    if (!_projectLefView) {
        _projectLefView = [[UIView alloc]initWithFrame:CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 2, self.view.mj_w, 40)];
        UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 41)];
        leftLab.text = @"项目方向";
        leftLab.textAlignment = NSTextAlignmentCenter;
        leftLab.font = [UIFont systemFontOfSize:17.0];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(leftLab.mj_w, 0, 1, 41)];
        line.backgroundColor = [UIColor grayColor];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, _projectLefView.mj_h, _projectLefView.mj_w, 1)];
        line2.backgroundColor = [UIColor grayColor];
        
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [leftBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        
        
        [leftBtn setTitle:@"项目方向" forState:UIControlStateNormal];//设置title
        [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        leftBtn.layer.borderColor = [UIColor grayColor].CGColor;
        leftBtn.layer.borderWidth = 1.0f;
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn setBackgroundColor:[UIColor whiteColor]];
        leftBtn.layer.cornerRadius = 5;
        leftBtn.clipsToBounds = YES;
        [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5, 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_projectLefView addSubview:leftLab];
        [_projectLefView addSubview:line];
        [_projectLefView addSubview:line2];
        [_projectLefView addSubview:leftBtn];
        
        self.leftBtn = leftBtn;
        
        self.YNLeft = YES;
    }
    return _projectLefView;
}

- (UIView *)phaseView
{
    if (!_phaseView) {
        _phaseView = [[UIView alloc]initWithFrame:CGRectMake(0, self.projectLefView.mj_h + self.projectLefView.mj_y + 2, self.view.mj_w, 40)];
        UILabel *phaseLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 41)];
        phaseLab.text = @"项目阶段";
        phaseLab.textAlignment = NSTextAlignmentCenter;
        phaseLab.font = [UIFont systemFontOfSize:17.0];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(phaseLab.mj_w, 0, 1, 41)];
        line.backgroundColor = [UIColor grayColor];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, _projectLefView.mj_h, _projectLefView.mj_w, 1)];
        line2.backgroundColor = [UIColor grayColor];
        
        
        UIButton *phaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [phaseBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        [phaseBtn setTitle:@"项目阶段" forState:UIControlStateNormal];//设置title
        [phaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        phaseBtn.layer.borderColor = [UIColor grayColor].CGColor;
        phaseBtn.layer.borderWidth = 1.0f;
        phaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [phaseBtn setBackgroundColor:[UIColor whiteColor]];
        phaseBtn.layer.cornerRadius = 5;
        phaseBtn.clipsToBounds = YES;
       
        [phaseBtn addTarget:self action:@selector(phaseBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [phaseBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5, 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_phaseView addSubview:phaseLab];
        [_phaseView addSubview:line];
        [_phaseView addSubview:line2];
        [_phaseView addSubview:phaseBtn];
        
        self.phaseBtn = phaseBtn;
        
        self.YNphase = YES;
    }
    return _phaseView;
}

- (UIView *)collaborationView
{
    if (!_collaborationView) {
        
        _collaborationView = [[UIView alloc]initWithFrame:CGRectMake(0, self.projectLefView.mj_h + self.projectLefView.mj_y + 2, self.view.mj_w, 209)];
        // 项目阶段
        UILabel *phaseLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 41)];
        phaseLab.text = @"项目阶段";
        phaseLab.textAlignment = NSTextAlignmentCenter;
        phaseLab.font = [UIFont systemFontOfSize:17.0];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(phaseLab.mj_w, 0, 1, _collaborationView.mj_h)];
        line.backgroundColor = [UIColor grayColor];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, phaseLab.mj_h + phaseLab.mj_y, _projectLefView.mj_w, 1)];
        line2.backgroundColor = [UIColor grayColor];
        
        
        UIButton *phaseCOlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [phaseCOlBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        
        [phaseCOlBtn setTitle:@"项目阶段" forState:UIControlStateNormal];//设置title
        [phaseCOlBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        phaseCOlBtn.layer.borderColor = [UIColor grayColor].CGColor;
        phaseCOlBtn.layer.borderWidth = 1.0f;
        phaseCOlBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [phaseCOlBtn setBackgroundColor:[UIColor whiteColor]];
        phaseCOlBtn.layer.cornerRadius = 5;
        phaseCOlBtn.clipsToBounds = YES;
        [phaseCOlBtn addTarget:self action:@selector(phaseColBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [phaseCOlBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5, 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_collaborationView addSubview:phaseLab];
        [_collaborationView addSubview:line];
        [_collaborationView addSubview:line2];
        [_collaborationView addSubview:phaseCOlBtn];
        
        self.phaseCOlBtn = phaseCOlBtn;
        
        // 项目投资
        UILabel *tenderLab = [[UILabel alloc]initWithFrame:CGRectMake(0,phaseLab.mj_h + phaseLab.mj_y + 1, 80, 41)];
        tenderLab.text = @"项目投资";
        tenderLab.textAlignment = NSTextAlignmentCenter;
        tenderLab.font = [UIFont systemFontOfSize:17.0];
        UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(0, tenderLab.mj_h + tenderLab.mj_y, _collaborationView.mj_w, 1)];
        line6.backgroundColor = [UIColor grayColor];
        
        
        UIButton *tenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [tenderBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        [tenderBtn setTitle:@"项目投资" forState:UIControlStateNormal];//设置title
        [tenderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        tenderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        tenderBtn.layer.borderWidth = 1.0f;
        tenderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [tenderBtn setBackgroundColor:[UIColor whiteColor]];
        tenderBtn.layer.cornerRadius = 5;
        tenderBtn.clipsToBounds = YES;
        [tenderBtn addTarget:self action:@selector(tenderBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [tenderBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5,tenderLab.mj_y + 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_collaborationView addSubview:tenderLab];
        [_collaborationView addSubview:line6];
        [_collaborationView addSubview:tenderBtn];
        
        self.tenderBtn = tenderBtn;
        
        // 合伙人
        UILabel *COLLab = [[UILabel alloc]initWithFrame:CGRectMake(0,tenderLab.mj_h + tenderLab.mj_y + 1, 80, 41)];
        COLLab.text = @"召唤合伙人";
        COLLab.textAlignment = NSTextAlignmentCenter;
        COLLab.font = [UIFont systemFontOfSize:15.0];
        UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, COLLab.mj_h + COLLab.mj_y, _collaborationView.mj_w, 1)];
        line3.backgroundColor = [UIColor grayColor];
        
        
        UIButton *COLLBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [COLLBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        [COLLBtn setTitle:@"召唤合伙人" forState:UIControlStateNormal];//设置title
        [COLLBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        COLLBtn.layer.borderColor = [UIColor grayColor].CGColor;
        COLLBtn.layer.borderWidth = 1.0f;
        COLLBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [COLLBtn setBackgroundColor:[UIColor whiteColor]];

        COLLBtn.layer.cornerRadius = 5;
        COLLBtn.clipsToBounds = YES;
        [COLLBtn addTarget:self action:@selector(COLLBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [COLLBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5,COLLab.mj_y + 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_collaborationView addSubview:COLLab];
        [_collaborationView addSubview:line3];
        [_collaborationView addSubview:COLLBtn];
        
        self.COLLBtn = COLLBtn;
        
        // 现有资金
        UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0,COLLab.mj_h + COLLab.mj_y + 1, 80, 41)];
        moneyLab.text = @"现有资金";
        moneyLab.textAlignment = NSTextAlignmentCenter;
        moneyLab.font = [UIFont systemFontOfSize:17.0];
        UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, moneyLab.mj_h + moneyLab.mj_y, _collaborationView.mj_w, 1)];
        line4.backgroundColor = [UIColor grayColor];
        
        UIButton *moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        [moneyBtn setTitle:@"现有资金" forState:UIControlStateNormal];//设置title
        [moneyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        moneyBtn.layer.borderColor = [UIColor grayColor].CGColor;
        moneyBtn.layer.borderWidth = 1.0f;
        moneyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [moneyBtn setBackgroundColor:[UIColor whiteColor]];
        moneyBtn.layer.cornerRadius = 5;
        moneyBtn.clipsToBounds = YES;
        [moneyBtn addTarget:self action:@selector(moneyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [moneyBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5,moneyLab.mj_y + 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_collaborationView addSubview:moneyLab];
        [_collaborationView addSubview:line4];
        [_collaborationView addSubview:moneyBtn];
        
        self.moneyBtn = moneyBtn;
        
        // 参与人数
        UILabel *personLab = [[UILabel alloc]initWithFrame:CGRectMake(0,moneyLab.mj_h + moneyLab.mj_y + 1, 80, 41)];
        personLab.text = @"参与人数";
        personLab.textAlignment = NSTextAlignmentCenter;
        personLab.font = [UIFont systemFontOfSize:17.0];
        UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, personLab.mj_h + personLab.mj_y, _collaborationView.mj_w, 1)];
        line5.backgroundColor = [UIColor grayColor];
        
        
        UIButton *personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [personBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
        [personBtn setTitle:@"参与人数" forState:UIControlStateNormal];//设置title
        [personBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        personBtn.layer.borderColor = [UIColor grayColor].CGColor;
        personBtn.layer.borderWidth = 1.0f;
        personBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personBtn setBackgroundColor:[UIColor whiteColor]];
        personBtn.layer.cornerRadius = 5;
        personBtn.clipsToBounds = YES;
        [personBtn addTarget:self action:@selector(personBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [personBtn setFrame:CGRectMake(line.mj_w + line.mj_x +5,personLab.mj_y + 5, BUTTONWIDTH, BUTTONHEIGHT)];
        
        
        [_collaborationView addSubview:personLab];
        [_collaborationView addSubview:line5];
        [_collaborationView addSubview:personBtn];
        
        self.personBtn = personBtn;
        
        self.YNcoll = YES;
        
    }
    return _collaborationView;
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
    
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"numberOfInformObjects" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatesSel:) name:@"selectLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatesSelShape:) name:@"selectShape" object:nil]; 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateszhongchou:) name:@"zhongchou" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(partnerJieDuan:) name:@"partnerJieDuan" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tenderJieDuan:) name:@"tenderJieDuan" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callPartner:) name:@"callPartner" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moneyTypes:) name:@"moneyTypes" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personNumbers:) name:@"personNumbers" object:nil];
    
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
    
    self.YNcoll = NO;
    self.YNLeft = NO;
    self.YNphase = NO;
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ProjectList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
    
    [self createSubviews];
}

#pragma mark - NSNotification
/// 地区
- (void)updateCol:(NSNotification *)not
{
    self.placeNmae = not.userInfo[@"arr"];
    self.placeId = not.userInfo[@"systemCode"];

    [self.placeBtn setTitle:not.userInfo[@"arr"] forState:UIControlStateNormal];
//    [self.placeBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor orangeColor]];
}
/// 项目方向
- (void)updatesSel:(NSNotification *)not
{
//    [self.leftBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:[UIColor orangeColor]];
    [self.leftBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.hangStr = not.userInfo[@"nature"];
   
}
/// 项目阶段（众筹）
- (void)updateszhongchou:(NSNotification *)not
{
//    [self.phaseBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.phaseBtn setBackgroundColor:[UIColor orangeColor]];
    [self.phaseBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.phaseStr = not.userInfo[@"nature"];
}
/// 项目阶段（合作）
- (void)partnerJieDuan:(NSNotification *)not
{
//    [self.phaseCOlBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.phaseCOlBtn setBackgroundColor:[UIColor orangeColor]];
    [self.phaseCOlBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.tendePhaserStr = not.userInfo[@"nature"];
}

- (void)tenderJieDuan:(NSNotification *)not
{
//    [self.tenderBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.tenderBtn setBackgroundColor:[UIColor orangeColor]];
    [self.tenderBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.tenderStr = not.userInfo[@"nature"];
}

- (void)callPartner:(NSNotification *)not
{
//    [self.COLLBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.COLLBtn setBackgroundColor:[UIColor orangeColor]];
    [self.COLLBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.COLLStr = not.userInfo[@"nature"];
}

- (void)moneyTypes:(NSNotification *)not
{
//    [self.moneyBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.moneyBtn setBackgroundColor:[UIColor orangeColor]];
    [self.moneyBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.moneyStr = not.userInfo[@"nature"];
}

- (void)personNumbers:(NSNotification *)not
{
//    [self.personBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.personBtn setBackgroundColor:[UIColor orangeColor]];
    [self.personBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
        self.personStr = not.userInfo[@"nature"];
}

/// 项目类型
- (void)updatesSelShape:(NSNotification *)not
{
//    [self.shapeBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.shapeBtn setBackgroundColor:[UIColor orangeColor]];
    [self.shapeBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.shapeStr = not.userInfo[@"nature"];
    
    
    
    if ([self.shapeStr isEqualToString:@"外  包"])
    {
        self.tendePhaserStr = @"";
        self.moneyStr = @"";
        self.tenderStr = @"";
        self.personStr = @"";
        self.COLLStr = @"";
        self.phaseStr = @"";
        
        if (self.YNcoll)
        {
            [self.collaborationView removeFromSuperview];
            self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 43, self.view.mj_w, self.view.mj_h - 62);
            self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 90);
            
            [self.phaseCOlBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//            [self.phaseCOlBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.phaseCOlBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.tenderBtn setTitle:@"项目投资" forState:UIControlStateNormal];
//            [self.tenderBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.tenderBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.COLLBtn setTitle:@"召唤合伙人" forState:UIControlStateNormal];
//            [self.COLLBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.COLLBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.moneyBtn setTitle:@"现有资金" forState:UIControlStateNormal];
//            [self.moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.personBtn setTitle:@"参与人数" forState:UIControlStateNormal];
//            [self.personBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.personBtn setBackgroundColor:[UIColor whiteColor]];
            self.YNcoll = NO;
        }
        if (self.YNphase)
        {
            [self.phaseView removeFromSuperview];
            self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 43, self.view.mj_w, self.view.mj_h - 62);
            self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 90);
            
            [self.phaseBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//            [self.phaseBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.phaseBtn setBackgroundColor:[UIColor whiteColor]];
            self.YNphase = NO;
        }
        if (self.YNLeft == NO)
        {
            
            UIView *leftView = self.projectLefView;
            [self.sc addSubview:leftView];
            self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 43, self.view.mj_w, self.view.mj_h - 62);
            self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 90);
            self.YNLeft = YES;
        }
        
        
    }
    else if ([self.shapeStr isEqualToString:@"奖励众筹"]||[self.shapeStr isEqualToString:@"股权众筹"])
    {
        self.tendePhaserStr = @"";
        self.moneyStr = @"";
        self.tenderStr = @"";
        self.personStr = @"";
        self.COLLStr = @"";
       
        if (self.YNcoll)
        {
            [self.collaborationView removeFromSuperview];
           
            [self.phaseCOlBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//            [self.phaseCOlBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.phaseCOlBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.tenderBtn setTitle:@"项目投资" forState:UIControlStateNormal];
//            [self.tenderBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.tenderBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.COLLBtn setTitle:@"召唤合伙人" forState:UIControlStateNormal];
//            [self.COLLBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.COLLBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.moneyBtn setTitle:@"现有资金" forState:UIControlStateNormal];
//            [self.moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.personBtn setTitle:@"参与人数" forState:UIControlStateNormal];
//            [self.personBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.personBtn setBackgroundColor:[UIColor whiteColor]];
             self.YNcoll = NO;
        }
        if (self.YNLeft == NO) {
           
            UIView *leftView = self.projectLefView;
            [self.sc addSubview:leftView];
             self.YNLeft = YES;
            if (self.YNphase == NO)
            {
                
                UIView *phaseView = self.phaseView;
                [self.sc addSubview:phaseView];
                
                self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 83, self.view.mj_w, self.view.mj_h - 62);
                self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 130);
                self.YNphase = YES;
                
            }
        }
        else
        {
            if (self.YNphase == NO)
            {
                
                UIView *phaseView = self.phaseView;
                [self.sc addSubview:phaseView];
                
                self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 83, self.view.mj_w, self.view.mj_h - 62);
                self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 130);
                self.YNphase = YES;
                
            }
        }
        
    }
    else if ([self.shapeStr isEqualToString:@"合  作"])
    {
        self.phaseStr = @"";
        
        if (self.YNphase) {
            self.YNphase = NO;
            [self.phaseView removeFromSuperview];
            [self.phaseBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//            [self.phaseBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.phaseBtn setBackgroundColor:[UIColor whiteColor]];
            
        }
        if (self.YNLeft == NO) {
            self.YNLeft = YES;
            UIView *leftView = self.projectLefView;
            [self.sc addSubview:leftView];
            if (self.YNcoll == NO) {
                self.YNcoll = YES;
                UIView *collaborationView = self.collaborationView;
                [self.sc addSubview:collaborationView];
                
                self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 254, self.view.mj_w, self.view.mj_h - 62);
                self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 290);
            }
        }
        else{
            if (self.YNcoll == NO) {
                self.YNcoll = YES;
                UIView *collaborationView = self.collaborationView;
                [self.sc addSubview:collaborationView];
                
                self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 254, self.view.mj_w, self.view.mj_h - 62);
                self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 290);
            }
        }
        
        
    }
    else
    {
       
        self.hangStr = @"";
        self.tendePhaserStr = @"";
        self.moneyStr = @"";
        self.tenderStr = @"";
        self.personStr = @"";
        self.COLLStr = @"";
        self.phaseStr = @"";
        
        if (self.YNphase) {
            self.YNphase = NO;
            [self.phaseView removeFromSuperview];
            [self.phaseBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//            [self.phaseBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.phaseBtn setBackgroundColor:[UIColor whiteColor]];
            
        }
        if (self.YNcoll) {
            self.YNcoll = NO;
            [self.collaborationView removeFromSuperview];
            [self.phaseCOlBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//            [self.phaseCOlBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.phaseCOlBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.tenderBtn setTitle:@"项目投资" forState:UIControlStateNormal];
//            [self.tenderBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.tenderBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.COLLBtn setTitle:@"召唤合伙人" forState:UIControlStateNormal];
//            [self.COLLBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.COLLBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.moneyBtn setTitle:@"现有资金" forState:UIControlStateNormal];
//            [self.moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
            
            [self.personBtn setTitle:@"参与人数" forState:UIControlStateNormal];
//            [self.personBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.personBtn setBackgroundColor:[UIColor whiteColor]];
        }
        if (self.YNLeft)
        {
            [self.projectLefView removeFromSuperview];
            self.YNLeft = NO;
//            [self.leftBtn setTitle:@"" forState:UIControlStateNormal];
//            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"项目方向" forState:UIControlStateNormal];
            [self.leftBtn setBackgroundColor:[UIColor whiteColor]];
        }
        self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 2, self.view.mj_w, self.view.mj_h - 62);
        self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 50);
    }
}
- (void)createSubviews
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UILabel *shapeLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 40)];
    shapeLab.text = @"项目类型";
    shapeLab.textAlignment = NSTextAlignmentCenter;
    shapeLab.font = [UIFont systemFontOfSize:17.0];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, shapeLab.mj_h + shapeLab.mj_y, self.view.mj_w, 1)];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 =line2;
    
    UILabel *placeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.mj_y+line2.mj_h,  80, 40)];
    placeLab.text = @"地  区";
    placeLab.textAlignment = NSTextAlignmentCenter;
    placeLab.font = [UIFont systemFontOfSize:17.0];
    self.placeLab = placeLab;
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, placeLab.mj_h + placeLab.mj_y, self.view.mj_w, 1)];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(shapeLab.mj_w, 0, 1, 81)];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    UIView *downSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, placeLab.mj_h + placeLab.mj_y + 2, self.view.mj_w, self.view.mj_h - 62)];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(shapeLab.mj_w, 0, 1, downSectionView.mj_h - 110)];
    line5.backgroundColor = [UIColor grayColor];
    self.line5 = line5;
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(0, line5.mj_h + line5.mj_y, self.view.mj_w, 1)];
    line6.backgroundColor = [UIColor grayColor];
    self.line6 = line6;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setFrame:CGRectMake(20, line6.mj_h + line6.mj_y + 20, (self.view.frame.size.width - 60)/2, 30)];
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
    [cancleBtn setFrame:CGRectMake(sureBtn.mj_w +sureBtn.mj_x +20, line6.mj_h + line6.mj_y + 20, (self.view.frame.size.width - 60)/2, 30)];
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
    
    
    UIButton *shapeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shapeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [shapeBtn setTitle:@"项目类型" forState:UIControlStateNormal];//设置title
    [shapeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    shapeBtn.layer.borderColor = [UIColor grayColor].CGColor;
    shapeBtn.layer.borderWidth = 1.0f;
    shapeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shapeBtn setBackgroundColor:[UIColor whiteColor]];
    shapeBtn.layer.cornerRadius = 5;
    shapeBtn.clipsToBounds = YES;
    [shapeBtn addTarget:self action:@selector(shapeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shapeBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, shapeLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
    self.shapeBtn = shapeBtn;
    
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setFrame:CGRectMake(line4.mj_w + line4.mj_x +5, placeLab.mj_y+5, BUTTONWIDTH, BUTTONHEIGHT)];
//    [placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [placeBtn setTitle:@"地区" forState:UIControlStateNormal];//设置title
    [placeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    placeBtn.layer.borderColor = [UIColor grayColor].CGColor;
    placeBtn.layer.borderWidth = 1.0f;
    placeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [placeBtn setBackgroundColor:[UIColor whiteColor]];
    
    [placeBtn addTarget:self action:@selector(placeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    placeBtn.layer.cornerRadius = 5;
    placeBtn.clipsToBounds = YES;
    self.placeBtn = placeBtn;
    
    
    [sc addSubview:shapeLab];
    [sc addSubview:line2];
    [sc addSubview:placeLab];
    [sc addSubview:line3];
    [sc addSubview:line4];
    [downSectionView addSubview:line5];
    [downSectionView addSubview:line6];
    [downSectionView addSubview:sureBtn];
    [downSectionView addSubview:cancleBtn];
    [sc addSubview:shapeBtn];
    [sc addSubview:placeBtn];
    
    
    roadTableView = [[UITableView alloc]initWithFrame:CGRectMake(placeBtn.mj_x,  10, self.view.mj_w - placeBtn.mj_x - 10, downSectionView.mj_h - 72 - placeBtn.mj_y - placeBtn.mj_h) style:UITableViewStylePlain];
    roadTableView.delegate = self;
    roadTableView.dataSource = self;
    roadTableView.rowHeight = 40;
    roadTableView.backgroundColor = [UIColor whiteColor];
    roadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [downSectionView addSubview:roadTableView];
    downSectionView.backgroundColor = [UIColor whiteColor];
    [sc addSubview:downSectionView];
    self.downSectionView = downSectionView;
    
    sc.contentSize = CGSizeMake(0, self.view.mj_h + 50);
    [self.view addSubview:sc];
    self.sc = sc;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alterAction
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
    
    
    [self.placeBtn setTitle:@"地区" forState:UIControlStateNormal];
//    [self.placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.shapeBtn setTitle:@"项目类型" forState:UIControlStateNormal];
//    [self.shapeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.shapeBtn setBackgroundColor:[UIColor whiteColor]];

//    [self.leftBtn setTitle:@"" forState:UIControlStateNormal];
//    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"项目方向" forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.searchSqlite deleteAllDataFromTableName:@"ProjectList"];
    if (self.sqliteArr.count != 0)
    {
        [self.sqliteArr removeAllObjects];
    }
    [roadTableView reloadData];
    
    
    if (self.YNphase) {
        self.YNphase = NO;
        [self.phaseView removeFromSuperview];
        [self.phaseBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//        [self.phaseBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        [self.phaseBtn setBackgroundColor:[UIColor whiteColor]];
        
    }
    if (self.YNcoll) {
        self.YNcoll = NO;
        [self.collaborationView removeFromSuperview];
        [self.phaseCOlBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
//        [self.phaseCOlBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        [self.phaseCOlBtn setBackgroundColor:[UIColor whiteColor]];
        
        [self.tenderBtn setTitle:@"项目投资" forState:UIControlStateNormal];
//        [self.tenderBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        [self.tenderBtn setBackgroundColor:[UIColor whiteColor]];
        
        [self.COLLBtn setTitle:@"召唤合伙人" forState:UIControlStateNormal];
//        [self.COLLBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        [self.COLLBtn setBackgroundColor:[UIColor whiteColor]];
        
        [self.moneyBtn setTitle:@"现有资金" forState:UIControlStateNormal];
//        [self.moneyBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        [self.moneyBtn setBackgroundColor:[UIColor whiteColor]];
        
        [self.personBtn setTitle:@"参与人数" forState:UIControlStateNormal];
//        [self.personBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        [self.personBtn setBackgroundColor:[UIColor whiteColor]];
    }
    if (self.YNLeft) {
        self.YNLeft = NO;
        [self.projectLefView removeFromSuperview];
    }
    
    self.downSectionView.frame = CGRectMake(0, self.placeLab.mj_h + self.placeLab.mj_y + 2, self.view.mj_w, self.view.mj_h - 62);
    self.sc.contentSize = CGSizeMake(0, self.view.mj_h + 50);

    
}

#pragma mark - search ButtonAction
- (void)placeBtnAction
{
    RegionViewController *regionVC = [[RegionViewController alloc]init];
    [self.navigationController pushViewController:regionVC animated:YES];

}

- (void)shapeBtnClick
{
    ShapeViewController *regionVC = [[ShapeViewController alloc] init];
    [self.navigationController pushViewController:regionVC animated:YES];
    
}
- (void)leftBtnAction
{
    SelectViewController *seleVC = [[SelectViewController alloc] init];
    seleVC.passVc = 2;
    seleVC.numArray = [NSMutableArray arrayWithArray:self.hangArr];
    [self.navigationController pushViewController:seleVC animated:YES];

}
// 项目阶段（众筹）
- (void)phaseBtnAction
{
    PhaseViewController *phaseVC = [[PhaseViewController alloc]init];
    phaseVC.numArray = [NSMutableArray arrayWithArray:self.zhongJieArr];
    [self.navigationController pushViewController:phaseVC animated:YES];
}
// 项目阶段（合作）
- (void)phaseColBtnAction
{
    PhaseColViewController *phaseColVc = [[PhaseColViewController alloc]init];
    phaseColVc.numArray = [NSMutableArray arrayWithArray:self.projectJieArr];
    [self.navigationController pushViewController:phaseColVc animated:YES];
}
- (void)tenderBtnAction
{
    ParTenViewController *partenVc = [[ParTenViewController alloc]init];
    partenVc.numArray = [NSMutableArray arrayWithArray:self.tenderArr];
    [self.navigationController pushViewController:partenVc animated:YES];
}
- (void)COLLBtnAction
{
    PartnerTypeViewController *partnerTypeVc = [[PartnerTypeViewController alloc]init];
    partnerTypeVc.numArray = [NSMutableArray arrayWithArray:self.personTypeArr];
    [self.navigationController pushViewController:partnerTypeVc animated:YES];
}
- (void)moneyBtnAction
{
    MoneyTypeViewController *moneyVc = [[MoneyTypeViewController alloc]init];
    moneyVc.numArray = [NSMutableArray arrayWithArray:self.moneyArr];
    [self.navigationController  pushViewController:moneyVc animated:YES];
}
- (void)personBtnAction
{
    PersonNumViewController *pernumVc = [[PersonNumViewController alloc]init];
    pernumVc.numArray = [NSMutableArray arrayWithArray:self.personNumArr];
    [self.navigationController pushViewController:pernumVc animated:YES];
}

- (void)sureBtnAction
{
//    if ([self.shapeBtn.currentTitle isEqualToString:@""]) {
//        [self.shapeBtn setTitle:@"全部" forState:0];
//    }
//    if ([self.placeBtn.currentTitle isEqualToString:@""]) {
//        [self.placeBtn setTitle:@"全部" forState:0];
//    }
    self.sureBtn.enabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 项目类型
    for (int i = 0; i < self.shapeArr.count; i ++) {
        if ([self.shapeStr isEqualToString:self.shapeArr[i]])
        {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"type"];
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
    if (self.YNphase || self.YNLeft || self.YNcoll) {
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
    }
    
//    项目阶段
    if (self.YNcoll)
    {
        /// 项目阶段（合作）
        for (int i = 0; i < self.projectJieArr.count; i ++) {
            if ([self.tendePhaserStr isEqualToString:self.projectJieArr[i]])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"cooperationStage"];
            }
        }
        for (int i = 0; i < self.moneyArr.count; i ++) {
            if ([self.moneyStr isEqualToString:self.moneyArr[i]]) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"existingFundsType"];
            }
        }
        for (int i = 0; i < self.tenderArr.count; i ++) {
            if ([self.tenderStr isEqualToString:self.tenderArr[i]]) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"initMoneyType"];
            }
        }
        for (int i = 0; i < self.personNumArr.count; i ++) {
            if ([self.personStr isEqualToString:self.personNumArr[i]]) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"teamNum"];
            }
        }
        
        for (int i = 0; i < self.personTypeArr.count; i ++)
        {
            if ([self.COLLStr isEqualToString:self.personTypeArr[i]])
            {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"partnerType"];
            }
        }

    }
    else if (self.YNphase)
    {
        /// 项目阶段（众筹）
        for (int i = 0; i < self.zhongJieArr.count; i ++) {
            if ([self.phaseStr isEqualToString:self.zhongJieArr[i]]) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [dic setObject:str forKey:@"cooperationStage"];
            }
        }
    }
    else
    {
        
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
                selectVC.resUrl = weakSelf.selectUrl;
                selectVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.shapeBtn.currentTitle?weakSelf.shapeBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部", nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
        self.sureBtn.enabled = YES;
    }];
}


// 保存
- (void)cancleBtnAction
{
//    if (/* DISABLES CODE */ 1)
//    {
//        showAlertView(@"条件不能同时为空");
//    }
//    else
//    {
    
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
          
            placeSearch.strType = self.shapeStr;
            placeSearch.cityId = self.placeId;
            placeSearch.cityName = self.placeNmae;
            if (self.YNcoll)
            {
            
            placeSearch.partnerType = self.COLLStr;
            placeSearch.teamNum = self.personStr;
            placeSearch.strMoneyType = self.tenderStr;
            placeSearch.existingFundsType = self.moneyStr;
            placeSearch.cooperationStage = self.tendePhaserStr;
                }
            if (self.YNphase)
            {
                placeSearch.cooperationStage = self.phaseStr;
            }
            
          
           
            
            [self.searchSqlite createWithSearchTableName:@"ProjectList" withModel:placeSearch];
            if (self.sqliteArr.count != 0)
            {
                [self.sqliteArr removeAllObjects];
            }
            
            self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
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
//    }
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
//    cell.typeLab.text = plmodel.directTypeName;
//    cell.placeLab.text = plmodel.cityName;

     cell.typeLab.text = plmodel.sqlLine;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    placeModel *plmodel = [placeModel new];
    plmodel = self.sqliteArr[indexPath.row];
    self.placeId = plmodel.cityId;
    self.shapeStr = plmodel.strType;
    if (self.YNcoll)
    {
        
        self.COLLStr = plmodel.partnerType;
        self.personStr = plmodel.teamNum ;
        self.tenderStr = plmodel.strMoneyType ;
        self.moneyStr = plmodel.existingFundsType;
        self.tendePhaserStr = plmodel.cooperationStage;
    }
    if (self.YNphase)
    {
        self.phaseStr = plmodel.cooperationStage;
    }
    [self sureBtnAction];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1)
    {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        
        
        placeModel *placeSearch = [placeModel new];
        placeSearch.sqlLine = nameField.text;
        
        placeSearch.strType = self.shapeStr;
        placeSearch.cityId = self.placeId;
        placeSearch.cityName = self.placeNmae;
        if (self.YNcoll)
        {
            
            placeSearch.partnerType = self.COLLStr;
            placeSearch.teamNum = self.personStr;
            placeSearch.strMoneyType = self.tenderStr;
            placeSearch.existingFundsType = self.moneyStr;
            placeSearch.cooperationStage = self.tendePhaserStr;
        }
        if (self.YNphase)
        {
            placeSearch.cooperationStage = self.phaseStr;
        }
        
        
        
        
        [self.searchSqlite createWithSearchTableName:@"ProjectList" withModel:placeSearch];
        if (self.sqliteArr.count != 0)
        {
            [self.sqliteArr removeAllObjects];
        }
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ProjectList"] mutableCopy];
        [roadTableView reloadData];
        
    }
    
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
        _hangArr = @[@"互联网",@"移动互联网",@"IT",@"电信及增值",@"传媒娱乐",@"能源",@"医疗健康",@"旅行",@"游戏",@"金融",@"教育",@"房地产",@"物流仓库",@"农林牧渔",@"住宿餐饮",@"商品服务",@"消费品",@"文体艺术",@"加工制造",@"节能环保",@"其他"];
        //        00：互联网；01:移动互联网；02：IT;03:电信及增值；04：传媒娱乐；05：能源；06：医疗健康；07：旅行；08：游戏；09：金融；10：教育；11：房地产；12：物流仓库；13：农林牧渔；14：住宿餐饮；15：商品服务；16：消费品；17：文体艺术；18：加工制造；19:节能环保；20：其他；
    }
    return _hangArr;
}
- (NSArray *)moneyArr
{
    if (!_moneyArr) {
        _moneyArr = @[@"50万以下",@"50~100万",@"100~200万",@"200~500万",@"500~1000万",@"1000万以上"];
//        0:50万以下；1:50~100万；2:100~200万；3:200~500万；4：500~1000万；5：1000万以上
    }
    return _moneyArr;
}

- (NSArray *)personTypeArr
{
    if (!_personTypeArr) {
        _personTypeArr = @[@"技术合伙人",@"营销合伙人",@"产品合伙人",@"运营合伙人",@"设计合伙人",@"其他合伙人"];
        //0：技术合伙人；1:营销合伙人；2：产品合伙人；3：运营合伙人；4：设计合伙人；5：其他合伙人
    }
    return _personTypeArr;
}
- (NSArray *)personNumArr
{
    if (!_personNumArr) {
        _personNumArr = @[@"5人以下",@"5~10人",@"10~20人",@"20~50人",@"50人以上"];
//        	5人以下 5~10人 10~20人 20~50人 50人以上
    }
    return _personNumArr;
}

- (NSArray *)tenderArr
{
    if (!_tenderArr) {
        _tenderArr = @[@"等待投资",@"个人出资",@"天使投资",@"A  轮",@"B  轮",@"C  轮"];
//        等待投资 个人出资 天使投资 A轮 B轮 C轮

    }
    return _tenderArr;
}
- (NSArray *)projectJieArr
{
    if (!_projectJieArr) {
        _projectJieArr = @[@"有个好主意",@"产品开发中",@"上线运营"];
        //有个好主意 产品开发中 上线运营
    }
    return _projectJieArr;
}
- (NSArray *)zhongJieArr
{
    if (!_zhongJieArr) {
        _zhongJieArr = @[@"概念阶段",@"研发中",@"已正式发布",@"已经盈利"];
        //概念阶段 研发中 已正式发布 已经盈利
    }
    return _zhongJieArr;
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
