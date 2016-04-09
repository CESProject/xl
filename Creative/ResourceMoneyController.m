//
//  ResourceMoneyController.m
//  Creative
//
//  Created by Mr Wei on 16/2/2.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ResourceMoneyController.h"
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
#import "AddMorePlaceController.h"
#import "Result.h"
#import "AddMoreResouceController.h"
#import "SelectResultViewController.h"

#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11

@interface ResourceMoneyController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *roadTableView;
    UIAlertView *customAlertView;
    
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

@implementation ResourceMoneyController

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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCol:) name:@"updateCol" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatesSel:) name:@"updatesSel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(identyResouceNature:) name:@"identyResouceNature" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ageResouceNature:) name:@"ageResouceNature" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moneyResouceNature:) name:@"moneyResouceNature" object:nil];
    
    self.hangStr = @"";
    self.placeNmae = @"";
    self.placeId = @"";
    self.identityStr = @"";
    self.ageStr = @"";
    self.identityStr = @"";
    self.tenderPlStr = @"";
    
    // 创建数据库
    self.searchSqlite = [SQLiteBase ShareSQLiteBaseSave];
    [_searchSqlite createWithSearchTableName:@"ForMoneyList"];
    self.sqliteArr = [NSMutableArray array];
    
    self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForMoneyList"] mutableCopy];
    
    [self createSubviews];
}
#pragma mark - NSNotification
- (void)updatesSel:(NSNotification *)not
{
    //    [self.guildBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.guildBtn setBackgroundColor:[UIColor orangeColor]];
    [self.guildBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    self.hangStr = not.userInfo[@"nature"];
    [self.guildBtn setTitleColor:[UIColor whiteColor] forState:0];
}

- (void)updateCol:(NSNotification *)not
{
    
    self.placeNmae = not.userInfo[@"arr"];
    self.placeId = not.userInfo[@"systemCode"];
    //    [self.placeBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor orangeColor]];
    [self.placeBtn setTitle:not.userInfo[@"arr"] forState:UIControlStateNormal];
    [self.placeBtn setTitleColor:[UIColor whiteColor] forState:0];
    
}

- (void)identyResouceNature:(NSNotification *)not
{
    if ([not.userInfo[@"nature"] isKindOfClass:[NSArray class]])
    {
        NSMutableString *str = [NSMutableString string];
        self.tags = [NSMutableString string];
        self.arrTag = [not.userInfo[@"tags"] copy];
        for (int i = 0; i < self.arrTag.count; i ++)
        {
            if (i == self.arrTag.count - 1) {
                [self.tags appendFormat:@"%@",self.arrTag[i]];
            }
            else
            {
                //            NSLog(@"%@",self.arrTag[i]);
                [self.tags appendFormat:@"%@,",self.arrTag[i]];
            }
        }
        
        self.arr = [not.userInfo[@"nature"] copy];
        for (int i = 0; i < self.arr.count; i ++)
        {
            if (i == self.arr.count - 1) {
                [str appendFormat:@"%@",self.arr[i]];
            }
            else
            {
                [str appendFormat:@"%@,",self.arr[i]];
            }
        }
        CGSize size;
        size = STRING_SIZE_FONT_WIDTH((self.view.mj_w - 60)/3, str, 17.0);
        [self.identityBtn setFrame:CGRectMake(self.line5.mj_w + self.line5.mj_x +5, self.tenderHanLab.mj_y + 5,size.width, BUTTONHEIGHT)];
        //        [self.identityBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.identityBtn setBackgroundColor:[UIColor orangeColor]];
        [self.identityBtn setTitle:str forState:UIControlStateNormal];
        [self.identityBtn setTitleColor:[UIColor whiteColor] forState:0];
        self.identityStr = str;
    }
    else
    {
        [self.identityBtn setFrame:CGRectMake(self.line5.mj_w + self.line5.mj_x +5, self.tenderHanLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
        //        [self.identityBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.identityBtn setBackgroundColor:[UIColor orangeColor]];
        [self.identityBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
        [self.identityBtn setTitleColor:[UIColor whiteColor] forState:0];
        self.identityStr = not.userInfo[@"nature"];
    }
    
    
    
}
- (void)ageResouceNature:(NSNotification *)not
{
    if ([not.userInfo[@"arr"] isKindOfClass:[NSArray class]])
    {
        NSMutableString *str = [NSMutableString string];
        self.placeIDs = [NSMutableString string];
        self.arrResult = [not.userInfo[@"arr"] copy];
        self.arrPlace = [not.userInfo[@"diquName"] copy];
        for (int i = 0; i < self.arrPlace.count; i ++)
        {
            Result *result = self.arrResult[i];
            if (i == self.arrPlace.count - 1) {
                [str appendFormat:@"%@",self.arrPlace[i]];
                [ self.placeIDs appendFormat:@"%@",result.diquCode];
            }
            else
            {
                [str appendFormat:@"%@,",self.arrPlace[i]];
                [ self.placeIDs appendFormat:@"%@,",result.diquCode];
            }
        }
        CGSize size;
        size = STRING_SIZE_FONT_WIDTH((self.view.mj_w - 60)/3, str, 17.0);
        self.tenderPlaBtn.frame = CGRectMake(self.line5.mj_w + self.line5.mj_x +5, self.tenderPlaLab.mj_y + 5,size.width, BUTTONHEIGHT);
        
        //        [self.tenderPlaBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tenderPlaBtn setBackgroundColor:[UIColor orangeColor]];
        [self.tenderPlaBtn setTitle:str forState:UIControlStateNormal];
        [self.tenderPlaBtn setTitleColor:[UIColor whiteColor] forState:0];
        self.tenderPlStr = not.userInfo[@"arr"];
        
    }
    else
    {
        self.tenderPlaBtn.frame = CGRectMake(self.line5.mj_w + self.line5.mj_x +5, self.tenderPlaLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT);
        //        [self.tenderPlaBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.tenderPlaBtn setBackgroundColor:[UIColor orangeColor]];
        [self.tenderPlaBtn setTitle:not.userInfo[@"arr"] forState:UIControlStateNormal];
        [self.tenderPlaBtn setTitleColor:[UIColor whiteColor] forState:0];
        self.tenderPlStr = not.userInfo[@"arr"];
        self.placeIDs = [NSMutableString string];
        [self.placeIDs appendFormat:@"%@",not.userInfo[@"systemCode"]];
    }
}

- (void)moneyResouceNature:(NSNotification *)not
{
    //    [self.tenderBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.tenderBtn setBackgroundColor:[UIColor orangeColor]];
    [self.tenderBtn setTitle:not.userInfo[@"nature"] forState:UIControlStateNormal];
    [self.tenderBtn setTitleColor:[UIColor whiteColor] forState:0];
    self.ageStr = not.userInfo[@"nature"];
}

- (void)createSubviews
{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UILabel *guildLab = [[UILabel alloc]initWithFrame:CGRectMake(0,65, 80, 40)];
    guildLab.text = @"资金类型";
    guildLab.textAlignment = NSTextAlignmentCenter;
    guildLab.font = [UIFont systemFontOfSize:17.0];
    self.guildLab = guildLab;
    
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, guildLab.mj_h + guildLab.mj_y, self.view.mj_w, 1)];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UILabel *areaLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line1.mj_y+line1.mj_h,  80, 40)];
    areaLab.text = @"所在地区";
    areaLab.textAlignment = NSTextAlignmentCenter;
    areaLab.font = [UIFont systemFontOfSize:17.0];
    self.areaLab = areaLab;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, areaLab.mj_h + areaLab.mj_y, self.view.mj_w, 1)];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 =line2;
    
    UILabel *tenderHanLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.mj_y+line2.mj_h,  80, 40)];
    tenderHanLab.text = @"投资行业";
    tenderHanLab.textAlignment = NSTextAlignmentCenter;
    tenderHanLab.font = [UIFont systemFontOfSize:17.0];
    self.tenderHanLab = tenderHanLab;
    
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, tenderHanLab.mj_h + tenderHanLab.mj_y, self.view.mj_w, 1)];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    
    UILabel *tenderPlaLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line3.mj_y+line3.mj_h,  80, 40)];
    tenderPlaLab.text = @"投资地区";
    tenderPlaLab.textAlignment = NSTextAlignmentCenter;
    tenderPlaLab.font = [UIFont systemFontOfSize:17.0];
    self.tenderPlaLab = tenderPlaLab;
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, tenderPlaLab.mj_h + tenderPlaLab.mj_y, self.view.mj_w, 1)];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    UILabel *tenderMonLab = [[UILabel alloc]initWithFrame:CGRectMake(0, line4.mj_y+line4.mj_h,  80, 40)];
    tenderMonLab.text = @"投资金额";
    tenderMonLab.textAlignment = NSTextAlignmentCenter;
    tenderMonLab.font = [UIFont systemFontOfSize:17.0];
    self.tenderMonLab = tenderMonLab;
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(0, tenderMonLab.mj_h + tenderMonLab.mj_y, self.view.mj_w, 1)];
    line6.backgroundColor = [UIColor grayColor];
    self.line6 = line6;
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(guildLab.mj_w, 64, 1, line6.mj_y - 64)];
    line5.backgroundColor = [UIColor grayColor];
    self.line5 = line5;
    
    
    
    
    // 资金类型
    UIButton *guildBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [guildBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, guildLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    //    [guildBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [guildBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [guildBtn setTitle:@"资金类型" forState:UIControlStateNormal];
    guildBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    guildBtn.layer.borderWidth = 1;
    guildBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [guildBtn addTarget:self action:@selector(guildBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    guildBtn.layer.cornerRadius = 5;
    guildBtn.clipsToBounds = YES;
    self.guildBtn = guildBtn;
    
    // 所在地区
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, areaLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    //    [placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [placeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [placeBtn setTitle:@"所在地区" forState:UIControlStateNormal];
    placeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    placeBtn.layer.borderWidth = 1;
    placeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [placeBtn addTarget:self action:@selector(placeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    placeBtn.layer.cornerRadius = 5;
    placeBtn.clipsToBounds = YES;
    self.placeBtn = placeBtn;
    
    UIButton *identityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [identityBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, tenderHanLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    //    [identityBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    [identityBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [identityBtn setTitle:@"投资行业" forState:UIControlStateNormal];
    identityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    identityBtn.layer.borderWidth = 1;
    identityBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [identityBtn addTarget:self action:@selector(identityBtnAction) forControlEvents:UIControlEventTouchUpInside];
    identityBtn.layer.cornerRadius = 5;
    identityBtn.clipsToBounds = YES;
    identityBtn.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.identityBtn = identityBtn;
    
    //    UIScrollView *btnSc = [[UIScrollView alloc]initWithFrame:CGRectMake(line5.mj_w + line5.mj_x +5, tenderPlaLab.mj_y + 5,self.view.mj_w - line5.mj_w - line5.mj_x - 10, BUTTONHEIGHT)];
    UIButton *tenderPlaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tenderPlaBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, tenderPlaLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    [tenderPlaBtn addTarget:self action:@selector(ageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //    [tenderPlaBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    
    
    [tenderPlaBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [tenderPlaBtn setTitle:@"投资地区" forState:UIControlStateNormal];
    tenderPlaBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    tenderPlaBtn.layer.borderWidth = 1;
    tenderPlaBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    tenderPlaBtn.layer.cornerRadius = 5;
    tenderPlaBtn.clipsToBounds = YES;
    tenderPlaBtn.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    
    self.tenderPlaBtn = tenderPlaBtn;
    
    UIButton *tenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tenderBtn setFrame:CGRectMake(line5.mj_w + line5.mj_x +5, tenderMonLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT)];
    [tenderBtn addTarget:self action:@selector(tenderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //    [tenderBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
    
    [tenderBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [tenderBtn setTitle:@"投资金额" forState:UIControlStateNormal];
    tenderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    tenderBtn.layer.borderWidth = 1;
    tenderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    tenderBtn.layer.cornerRadius = 5;
    tenderBtn.clipsToBounds = YES;
    tenderBtn.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.tenderBtn = tenderBtn;
    
    
   
    
    [sc addSubview:tenderPlaLab];
    [sc addSubview:guildLab];
    [sc addSubview:line1];
    [sc addSubview:areaLab];
    [sc addSubview:line2];
    [sc addSubview:tenderHanLab];
    [sc addSubview:line3];
    [sc addSubview:line4];
    [sc addSubview:tenderMonLab];
    [sc addSubview:line6];
    [sc addSubview:line5];
    
    [sc addSubview:guildBtn];
    [sc addSubview:placeBtn];
    [sc addSubview:identityBtn];
    [sc addSubview:tenderPlaBtn];
    [sc addSubview:tenderBtn];
    
    UIView *downSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, tenderMonLab.mj_h + tenderMonLab.mj_y + 1, self.view.mj_w, self.view.mj_h - tenderMonLab.mj_h - tenderMonLab.mj_y +80 )];
    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(line5.mj_x, 0, 1, downSectionView.mj_h - 60 )];
    line7.backgroundColor = [UIColor grayColor];
    self.line7 = line7;
    
    UIView *line8 = [[UIView alloc]initWithFrame:CGRectMake(0, downSectionView.mj_h - 60, self.view.mj_w, 1)];
    line8.backgroundColor = [UIColor grayColor];
    self.line8 = line8;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setFrame:CGRectMake(20, downSectionView.mj_h - 40, (self.view.frame.size.width - 60)/2, 30)];
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
    [cancleBtn setFrame:CGRectMake(sureBtn.mj_w +sureBtn.mj_x +20, downSectionView.mj_h - 40, (self.view.frame.size.width - 60)/2, 30)];
    
    [cancleBtn setTitle:@"保存" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.layer.cornerRadius = 4;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.tintColor = GREENCOLOR;
    cancleBtn.layer.borderColor = GREENCOLOR.CGColor;
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.cancleBtn = cancleBtn;
    //    downSectionView.backgroundColor = [UIColor blueColor];
    [downSectionView addSubview:line7];
    [downSectionView addSubview:line8];
    [downSectionView addSubview:sureBtn];
    [downSectionView addSubview:cancleBtn];
    
    
    
    roadTableView = [[UITableView alloc]initWithFrame:CGRectMake(placeBtn.mj_x, 10, downSectionView.mj_w - placeBtn.mj_x -5 , downSectionView.mj_h - 80) style:UITableViewStylePlain];
    roadTableView.delegate = self;
    roadTableView.dataSource = self;
    roadTableView.rowHeight = 40;
    //    roadTableView.backgroundColor = [UIColor blueColor];
    roadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [downSectionView addSubview:roadTableView];
    
    [sc addSubview:downSectionView];
    sc.contentSize = CGSizeMake(0, self.view.mj_h + 150);
    [self.view addSubview:sc];
    self.sc = sc;
    
}



- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alterAction
{
    self.identityStr = @"";
    self.tenderPlStr = @"";
    
    self.hangStr = @"";
    [self.guildBtn setTitle:@"资金类型" forState:UIControlStateNormal];
    //    [self.guildBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.guildBtn setBackgroundColor:[UIColor whiteColor]];
    [self.guildBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    self.placeNmae = @"";
    self.placeId = @"";
    [self.placeBtn setTitle:@"所在地区" forState:UIControlStateNormal];
    //    [self.placeBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.placeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.placeBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    self.identityStr = @"";
    [self.identityBtn setTitle:@"投资行业" forState:UIControlStateNormal];
    //    [self.identityBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.identityBtn setBackgroundColor:[UIColor whiteColor]];
    [self.identityBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    self.ageStr = @"";
    self.tenderPlaBtn.frame = CGRectMake(self.line5.mj_w + self.line5.mj_x +5, self.tenderPlaLab.mj_y + 5,BUTTONWIDTH, BUTTONHEIGHT);
    [self.tenderPlaBtn setTitle:@"投资地区" forState:UIControlStateNormal];
    //    [self.tenderPlaBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
    [self.tenderPlaBtn setBackgroundColor:[UIColor whiteColor]];
    [self.tenderPlaBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    [self.searchSqlite deleteAllDataFromTableName:@"ForMoneyList"];
    if (self.sqliteArr.count != 0)
    {
        [self.sqliteArr removeAllObjects];
    }
    [roadTableView reloadData];
}
#pragma mark - button Action

- (void)guildBtnAction:(UIButton *)sender
{
    SelectViewController *seleVC = [[SelectViewController alloc] init];
    seleVC.numArray = [NSMutableArray arrayWithArray:self.hangArr];
    seleVC.passVc = 4;
    [self.navigationController pushViewController:seleVC animated:YES];
}

- (void)placeBtnAction
{
    
    RegionViewController *regionVC = [[RegionViewController alloc] init];
    regionVC.passVc = 4;
    [self.navigationController pushViewController:regionVC animated:YES];
}
- (void)identityBtnAction
{
    AddMoreResouceController *resVc = [[AddMoreResouceController alloc]init];
    resVc.passVc = 3;
    resVc.numArray = [NSMutableArray arrayWithArray:self.identityArr];
    [self.navigationController pushViewController:resVc animated:YES];
}
- (void)ageBtnAction
{
    AddMorePlaceController *regionVC = [[AddMorePlaceController alloc] init];
    regionVC.passVc = 4;
    [self.navigationController pushViewController:regionVC animated:YES];
}

- (void)tenderBtnAction
{
    ResouceSelectController *resVc = [[ResouceSelectController alloc]init];
    resVc.passVc = 4;
    resVc.numArray = [NSMutableArray arrayWithArray:self.ageArr];
    [self.navigationController pushViewController:resVc animated:YES];
}



- (void)sureBtnAction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.hangArr.count; i ++)
    {
        if ([self.hangStr isEqualToString:self.hangArr[i]])
        {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"fundType"];//资金类型
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
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [dic setObject:str forKey:@"amountOfMoney"];//投资金额
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
                selectVC.titleArr = [NSMutableArray arrayWithObjects:weakSelf.guildBtn.currentTitle?weakSelf.guildBtn.currentTitle:@"全部",weakSelf.placeBtn.currentTitle?weakSelf.placeBtn.currentTitle:@"全部" ,weakSelf.tenderPlaBtn.currentTitle?weakSelf.tenderPlaBtn.currentTitle:@"全部",nil];
                [weakSelf.navigationController pushViewController:selectVC animated:YES];
            }
        }
    }];
    
}


- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"个人资金",@"企业资金",@"天使投资",@"PE投资",@"小额贷款",@"典当公司",@"担保公司",@"金融租赁",@"投资公司",@"商业银行",@"基金公司",@"证券公司",@"物流仓库",@"信托公司",@"资产管理",@"其他资金"];
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
        _ageArr = @[@"1万~10万",@"10万~50万",@"50万~100万",@"100万~500万",@"500万~1000万",@"1000万~5000万",@"5000万~1亿",@"大于1亿"];
        //        1万~10万 10万~50万 50万~100万 100万~500万 500万~1000万 1000万~5000万 5000万~1亿 大于1亿
    }
    return _ageArr;
}

// 保存
- (void)cancleBtnAction
{
    
    //    if ([self.hangStr isEqualToString:@""] && [self.placeId isEqualToString:@""]&&[self.ageStr isEqualToString:@""] && [self.identityStr isEqualToString:@""])
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
            placeSearch.cityId = self.placeIDs;
            placeSearch.cityName = self.placeNmae;
            placeSearch.directTypeName = self.hangStr;
            placeSearch.ageType = self.ageStr;
            placeSearch.name = self.tags;
            
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
            
            [self.searchSqlite createWithSearchTableName:@"ForMoneyList" withModel:placeSearch];
            if (self.sqliteArr.count != 0)
            {
                [self.sqliteArr removeAllObjects];
            }
            
            self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForMoneyList"] mutableCopy];
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
    cell.typeLab.text = plmodel.sqlLine;
    //    cell.typeLab.text = plmodel.directTypeName;
    //    cell.placeLab.text = plmodel.cityName;
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1)
    {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        
        placeModel *placeSearch = [placeModel new];
        placeSearch.sqlLine = nameField.text;
        placeSearch.cityId = self.placeIDs;
        placeSearch.cityName = self.placeNmae;
        placeSearch.directTypeName = self.hangStr;
        placeSearch.ageType = self.ageStr;
        placeSearch.name = self.tags;
        
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
        
        [self.searchSqlite createWithSearchTableName:@"ForMoneyList" withModel:placeSearch];
        if (self.sqliteArr.count != 0)
        {
            [self.sqliteArr removeAllObjects];
        }
        
        self.sqliteArr = [[self.searchSqlite searchAllDataFromSearchTableName:@"ForMoneyList"] mutableCopy];
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
