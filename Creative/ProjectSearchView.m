//
//  ProjectSearchView.m
//  Creative
//
//  Created by Mr Wei on 16/2/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ProjectSearchView.h"
#import "SelectCell.h"
#import "Result.h"
#import "SelectCellTwo.h"
#import "SelectResultViewController.h"
#import "RegionViewController.h"
#import "ListCell.h"

@interface ProjectSearchView ()<UITextFieldDelegate>
{
    UITableView *listTable;
    UIView *leftView1;
    
    NSArray *regionName;
    NSArray *systemCodeArr;
    NSMutableArray *tableArray;
    NSMutableArray *diquarray;
    NSMutableArray *diquArr;
    
    NSMutableArray *ABCArray;//索引数组
    
    int YnFirst;
}



@property (nonatomic , strong) NSArray *listArr;
@property (nonatomic , strong) NSArray *listArr1;
@property (nonatomic , strong) NSArray *listArr2;
@property (nonatomic , strong) NSArray *listArr3;
@property (nonatomic , strong) NSArray *listArr4;
@property (nonatomic , strong) NSMutableArray *listArr5;

@property (nonatomic , strong) NSArray *shapeArr;
@property (nonatomic , strong) NSArray *moneyArr;
@property (nonatomic , strong) NSArray *personTypeArr;
@property (nonatomic , strong) NSArray *personNumArr;
@property (nonatomic , strong) NSArray *tenderArr; // 项目投资
@property (nonatomic , strong) NSArray *projectJieArr;
@property (nonatomic , strong) NSArray *zhongJieArr;

@end

@implementation ProjectSearchView


// 项目方向
- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = [UIColor grayColor];
        //        [_leftView addSubview:_leftTableView];
    }
    return _leftTableView;
}


- (UITableView *)mytableview
{
    if (!_mytableview) {
        
        _mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _mytableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _mytableview.dataSource = self;
        _mytableview.delegate  = self;
        _mytableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mytableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _mytableview;
}

/// 合作项目阶段
- (UITableView *)JiePaTableview
{
    if (!_JiePaTableview) {
        
        _JiePaTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _JiePaTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _JiePaTableview.dataSource = self;
        _JiePaTableview.delegate  = self;
        _JiePaTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _JiePaTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _JiePaTableview;
}

/// 众筹项目阶段
- (UITableView *)JieZoTableview
{
    if (!_JieZoTableview) {
        
        _JieZoTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _JieZoTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _JieZoTableview.dataSource = self;
        _JieZoTableview.delegate  = self;
        _JieZoTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _JieZoTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _JieZoTableview;
}

- (UITableView *)tenderTableview
{
    if (!_tenderTableview) {
        
        _tenderTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _tenderTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _tenderTableview.dataSource = self;
        _tenderTableview.delegate  = self;
        _tenderTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tenderTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _tenderTableview;
}

- (UITableView *)personTableview
{
    if (!_personTableview) {
        
        _personTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _personTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _personTableview.dataSource = self;
        _personTableview.delegate  = self;
        _personTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _personTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _personTableview;
}

- (UITableView *)moneyTableview
{
    if (!_moneyTableview) {
        
        _moneyTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _moneyTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _moneyTableview.dataSource = self;
        _moneyTableview.delegate  = self;
        _moneyTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _moneyTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _moneyTableview;
}

- (UITableView *)personNumTableview
{
    if (!_personNumTableview) {
        
        _personNumTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _personNumTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _personNumTableview.dataSource = self;
        _personNumTableview.delegate  = self;
        _personNumTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _personNumTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _personNumTableview;
}

- (void)reloadTabview
{
    WEAKSELF;
    
    [[HttpManager defaultManager]postRequestToUrl:DEF_XITONGZIDIAN params:@{@"systemType":@"HOT_AREA"} complete:^(BOOL successed, NSDictionary *result) {
        //
        //                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:weakSelf.view];
        if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
        {
            diquarray = [result objectForKey:@"objList"];
            for (NSDictionary *dic in diquarray)
            {
                Result *result = [[Result alloc] init];
                result.diquCode = [dic objectForKey:@"systemCode"];
                result.diquName = [dic objectForKey:@"systemName"];
                result.diquTab = [dic objectForKey:@"systemTab"];
                result.diquType = [dic objectForKey:@"systemType"];
                result.diquID = [dic objectForKey:@"id"];
                [diquArr addObject:result];
                
            }
            [weakSelf.mytableview reloadData];
            [weakSelf analysis];
        }
    }];
    
}

- (void)analysis
{
    
    NSMutableArray *ar = [self paiXu];
    tableArray = ar;
    for (int i =0; i<ar.count; i++) {
        
        
        NSArray *tempA = ar[i];
        Result *result = tempA[0];
        ABCArray[i]=[self translation:result.diquName];
    }
    [self.mytableview reloadData];
}

-(NSString *)translation:(NSString *)string
{
    if (!string || string.length<=0) {
        return nil;
    }
    
    NSMutableString *source = [string mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *a = [[source substringToIndex:1] uppercaseString];
    return a;
}
- (NSMutableArray *) paiXu
{
    NSMutableArray *arra = [[NSMutableArray alloc] init];
    NSMutableArray *A = [[NSMutableArray alloc ] init];
    [arra addObject:A];
    NSMutableArray *B = [[NSMutableArray alloc ] init];
    [arra addObject:B];
    
    NSMutableArray *C = [[NSMutableArray alloc ] init];
    [arra addObject:C];
    
    NSMutableArray *D = [[NSMutableArray alloc ] init];
    [arra addObject:D];
    
    NSMutableArray *E = [[NSMutableArray alloc ] init];
    [arra addObject:E];
    
    NSMutableArray *F = [[NSMutableArray alloc ] init];
    [arra addObject:F];
    
    NSMutableArray *G = [[NSMutableArray alloc ] init];
    [arra addObject:G];
    
    NSMutableArray *H = [[NSMutableArray alloc ] init];
    [arra addObject:H];
    
    NSMutableArray *I = [[NSMutableArray alloc ] init];
    [arra addObject:I];
    
    NSMutableArray *J = [[NSMutableArray alloc ] init];
    [arra addObject:J];
    
    NSMutableArray *K = [[NSMutableArray alloc ] init];
    [arra addObject:K];
    
    NSMutableArray *L = [[NSMutableArray alloc ] init];
    [arra addObject:L];
    
    NSMutableArray *M = [[NSMutableArray alloc ] init];
    [arra addObject:M];
    
    NSMutableArray *N = [[NSMutableArray alloc ] init];
    [arra addObject:N];
    
    NSMutableArray *O = [[NSMutableArray alloc ] init];
    [arra addObject:O];
    
    NSMutableArray *P = [[NSMutableArray alloc ] init];
    [arra addObject:P];
    
    NSMutableArray *Q = [[NSMutableArray alloc ] init];
    [arra addObject:Q];
    
    NSMutableArray *R = [[NSMutableArray alloc ] init];
    [arra addObject:R];
    
    NSMutableArray *S = [[NSMutableArray alloc ] init];
    [arra addObject:S];
    
    NSMutableArray *T = [[NSMutableArray alloc ] init];
    [arra addObject:T];
    
    NSMutableArray *U = [[NSMutableArray alloc ] init];
    [arra addObject:U];
    
    NSMutableArray *V = [[NSMutableArray alloc ] init];
    [arra addObject:V];
    
    NSMutableArray *W = [[NSMutableArray alloc ] init];
    [arra addObject:W];
    
    NSMutableArray *X = [[NSMutableArray alloc ] init];
    [arra addObject:X];
    
    NSMutableArray *Y = [[NSMutableArray alloc ] init];
    [arra addObject:Y];
    
    NSMutableArray *Z = [[NSMutableArray alloc ] init];
    [arra addObject:Z];
    
    NSMutableArray *last = [[NSMutableArray alloc] init];
    [arra addObject:last];
    
    for (int i =0 ; i < diquArr.count ; i++) {
        Result *result = [diquArr objectAtIndex:i];
        NSString *str =result.diquName;
        {
            NSMutableString *source = [str mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
            NSString *newStr = [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *car = [newStr substringToIndex:1];
            car = [car uppercaseString];
            
            //找到对应的大数组并添加进去
            if ([car isEqualToString:@"A"]) {
                [A addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"B"]) {
                [B addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"C"]) {
                [C addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"D"]) {
                [D addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"E"]) {
                [E addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"F"]) {
                [F addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"G"]) {
                [G addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"H"]) {
                [H addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"I"]) {
                [I addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"J"]) {
                [J addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"K"]) {
                [K addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"L"]) {
                [L addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"M"]) {
                [M addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"N"]) {
                [N addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"O"]) {
                [O addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"P"]) {
                [P addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"Q"]) {
                [Q addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            if ([car isEqualToString:@"R"]) {
                [R addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"S"]) {
                [S addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"T"]) {
                [T addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"U"]) {
                [U addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"V"]) {
                [V addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"W"]) {
                [W addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"X"]) {
                [X addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"Y"]) {
                [Y addObject:result];
                //                [arr removeObject:people];
                continue;
                
            }
            if ([car isEqualToString:@"Z"]) {
                [Z addObject:result];
                //                [arr removeObject:people];
                continue;
            }
            
        }
    }
    self.dicCheckpl = [NSMutableDictionary dictionary];
    //遍历大数组，剔除没有数据的数组
    for (int i =0; i < arra.count; i++) {
        NSMutableArray *temp = [arra objectAtIndex:i];
        if (temp.count == 0) {
            [arra removeObject:temp];
            [self.dicCheckpl setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",temp]];
        }
    }
    return arra;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAddSubviews];
        
        regionName = @[@"全部",@"上海",@"北京",@"广州",@"郑州",@"武汉",@"天津",@"西安",@"南京",@"杭州",@"查看更多城市"];
        systemCodeArr = @[@"",@"1009",@"1001001",@"10119001",@"1016001",@"1017001",@"1002001",@"1029001",@"1010001",@"1011001",@""];
        
        
        self.arrTransmitZJ = [NSMutableArray array];
        self.dicCheckZJ = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.zhongJieArr];
        
        self.arrTransmitPa = [NSMutableArray array];
        self.dicCheckPa = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO"] forKeys:self.projectJieArr];
        
        self.arrTransmitTen = [NSMutableArray array];
        self.dicCheckTen = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.tenderArr];
        
        self.arrTransmitType = [NSMutableArray array];
        self.dicCheckType = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.personTypeArr];
        
        self.arrTransmitMone = [NSMutableArray array];
        self.dicCheckMone = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.moneyArr];
        
        self.arrTransmit = [NSMutableArray array];
        self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.hangArr];
        
        self.arrTransmitNum = [NSMutableArray array];
        self.dicCheckNum = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.personNumArr];
        
        self.arrTransmitPl = [NSMutableArray array];
        
        
        tableArray = [NSMutableArray array];
        diquArr = [NSMutableArray array];
        ABCArray = [NSMutableArray array];
        self.selectCityArr = [NSMutableArray array];
        self.selectCityCodeArr = [NSMutableArray array];
        self.hangStr   = @"";
        self.zjStr     = @"";
        self.PaStr     = @"";
        self.TenStr    = @"";
        self.TypeStr   = @"";
        self.MoneStr   = @"";
        self.placeId   = @"";
        self.placeNmae = @"";
        self.NumStr    = @"";
        self.shapeStr  = @"";
        YnFirst = 0;
        
        self.listArr5 = [NSMutableArray arrayWithArray:self.listArr ];
        
        self.selectCityArr = [regionName copy];
        self.selectCityCodeArr = [systemCodeArr copy];
        
        [self reloadTabview];
        //        self.senderDic = [NSMutableDictionary dictionary];
        //        self.diquStr = [[NSMutableString alloc]init];
    }
    return self;
}

- (void)createAddSubviews
{
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 50)];
    sectionView.backgroundColor = [UIColor whiteColor];
    sectionView.alpha = 1.0;
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setFrame:CGRectMake(10, 10, 50, 30)];
    cancleBtn.tintColor = [UIColor grayColor];
    
    [sectionView addSubview:cancleBtn];
    
    UIButton *alterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [alterBtn setTitle:@"重置" forState:UIControlStateNormal];
    [alterBtn addTarget:self action:@selector(removeAllDateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [alterBtn setFrame:CGRectMake(sectionView.mj_w /2 - 30 , 10, 50, 30)];
    alterBtn.tintColor = [UIColor grayColor];
    
    [sectionView addSubview:alterBtn];
    
    
    UIButton *surerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [surerBtn setTitle:@"确定" forState:UIControlStateNormal];
    //    [surerBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [surerBtn setFrame:CGRectMake(sectionView.mj_w  - 60 , 10, 50, 30)];
    surerBtn.tintColor = [UIColor grayColor];
    
    self.surerBtn = surerBtn;
    [sectionView addSubview:surerBtn];
    
    [self addSubview:sectionView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y, self.mj_w, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UIView *saveView = [[UIView alloc]initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + 1, self.mj_w, 50)];
    saveView.backgroundColor = [UIColor whiteColor];
    saveView.alpha = 1.0;
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"selects"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.selected = NO;
    saveBtn.frame = CGRectMake(10, 15, 20, 20);
    self.saveBtn = saveBtn;
    [saveView addSubview:saveBtn];
    
    UILabel *saveLab = [[UILabel alloc]initWithFrame:CGRectMake(saveBtn.mj_w + saveBtn.mj_x + 5, saveBtn.mj_y - 5, self.mj_w/ 5 - saveBtn.mj_w - saveBtn.mj_x + 15, 30)];
    saveLab.text = @"保存";
    [saveView addSubview:saveLab];
    
    
    
    UIButton *chaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [chaBtn setTitle:@"查看搜索器" forState:UIControlStateNormal];
    //    [chaBtn addTarget:self action:@selector(chaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [chaBtn setFrame:CGRectMake(saveLab.mj_w + saveLab.mj_x + 20, saveLab.mj_y, self.mj_w - saveLab.mj_w - saveLab.mj_x - 50, 30)];
    
    chaBtn.layer.masksToBounds = YES;
    chaBtn.layer.cornerRadius = 4;
    chaBtn.layer.borderWidth = 1;
    chaBtn.tintColor = GREENCOLOR;
    chaBtn.layer.borderColor = GREENCOLOR.CGColor;
    chaBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    chaBtn.alpha = 1.0;
    self.chaBtn = chaBtn;
    [saveView addSubview:chaBtn];
    
    
    UITextField *saveText = [[UITextField alloc]initWithFrame:CGRectMake(saveLab.mj_w + saveLab.mj_x + 20, saveLab.mj_y, self.mj_w - saveLab.mj_w - saveLab.mj_x - 50, 30)];
    saveText.placeholder = @"请输入搜索器名称";
    saveText.alpha = 0;
    saveText.delegate = self;
    saveText.borderStyle = UITextBorderStyleRoundedRect;
    self.saveText = saveText;
    [saveView addSubview:saveText];
    
    [self addSubview:saveView];
    
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,saveView.mj_y + saveView.mj_h + 1, self.mj_w/ 5 + 40 , self.mj_h - saveView.mj_y - saveView.mj_h - 1) style:UITableViewStylePlain];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:listTable];
    
    leftView1 = [[UIView alloc]initWithFrame:CGRectMake(self.mj_w / 5 + 41, saveView.mj_y + saveView.mj_h + 1, self.mj_w / 5 *4 - 1, self.mj_h - saveView.mj_y - saveView.mj_h - 1)];
    leftView1.backgroundColor = [UIColor whiteColor];
    
    
    [leftView1 addSubview:[UIView new]];
    //    [self.mytableview reloadData];
    
    [self addSubview:leftView1];
    
}

#pragma mark - Button Action
- (void)saveBtnAction:(UIButton *)sender
{
    if (sender.selected)
    {
        sender.selected = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"selects"] forState:UIControlStateNormal];
        self.saveText.alpha = 0;
        self.chaBtn.alpha = 1.0;
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"selecteds"] forState:UIControlStateNormal];
        sender.selected = YES;
        self.saveText.alpha = 1.0;
        self.saveText.text = @"";
        self.chaBtn.alpha = 0;
        
    }
}

- (void)removeAllDateBtnAction
{
    self.hangStr   = @"";
    self.zjStr     = @"";
    self.PaStr     = @"";
    self.TenStr    = @"";
    self.TypeStr   = @"";
    self.MoneStr   = @"";
    self.placeId   = @"";
    self.placeNmae = @"";
    self.NumStr    = @"";
    self.shapeStr  = @"";
    YnFirst = 0;
    
    self.selectCityArr = [regionName copy];
    self.selectCityCodeArr = [systemCodeArr copy];
    
    self.listArr5 = [NSMutableArray arrayWithArray:self.listArr ];
    
    [self.arrTransmitZJ removeAllObjects];
    self.dicCheckZJ = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.zhongJieArr];
    
    [self.arrTransmitPa removeAllObjects];
    self.dicCheckPa = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO"] forKeys:self.projectJieArr];
    
    [self.arrTransmit removeAllObjects];
    [self.leftTableView reloadData];
    self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.hangArr];
    
    [self.arrTransmitTen removeAllObjects];
    self.dicCheckTen = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.tenderArr];
    
    [self.arrTransmitType removeAllObjects];
    self.dicCheckType = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.personTypeArr];
    
    [self.arrTransmitMone removeAllObjects];
    self.dicCheckMone = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.moneyArr];
    
    [self.arrTransmitNum removeAllObjects];
    self.dicCheckNum = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.personNumArr];
    
    [self.arrTransmitPl removeAllObjects];
    
    for (int i = 0; i < self.dicCheckpl.count; i ++)
    {
        NSString *str = [ NSString stringWithFormat:@"%@",[self.dicCheckpl allValues][i]];
        NSString *str1 = [ NSString stringWithFormat:@"%@",[self.dicCheckpl allKeys][i]];
        if ([str isEqualToString:@"YES"])
        {
            self.dicCheckpl[str1] = @"NO";
        }
    }
    
    self.saveBtn.selected = NO;
    [self.saveBtn setBackgroundImage:[UIImage imageNamed:@"selects"] forState:UIControlStateNormal];
    self.saveText.alpha = 0;
    self.chaBtn.alpha = 1.0;
    
    [leftView1 addSubview:[UIView new]];
    
    [self.mytableview removeFromSuperview];
    [self.leftTableView removeFromSuperview];
    [self.JiePaTableview removeFromSuperview];
    [self.JieZoTableview removeFromSuperview];
    [self.tenderTableview removeFromSuperview];
    [self.personTableview removeFromSuperview];
    [self.moneyTableview removeFromSuperview];
    [self.personNumTableview removeFromSuperview];
    
    [self.mytableview reloadData];
    [self.leftTableView reloadData];
    [self.JiePaTableview reloadData];
    [self.JieZoTableview reloadData];
    [self.tenderTableview reloadData];
    [self.personTableview reloadData];
    [self.moneyTableview reloadData];
    [self.personNumTableview reloadData];
    
    [listTable reloadData];
}

- (void)cancleBtnAction:(UIButton *)sender
{
    [self.superview removeFromSuperview];
}
#pragma mark - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == listTable)
    {
        return self.listArr5.count;
    }
    else if(tableView == self.leftTableView)
    {// 项目方向
        return self.hangArr.count;
    }
    else if(tableView == self.JiePaTableview)
    { //合作 项目阶段
        return self.projectJieArr.count;
    }
    else if(tableView == self.JieZoTableview)
    { //众筹 项目阶段
        return self.zhongJieArr.count;
    }
    else if(tableView == self.tenderTableview)
    {
        return self.tenderArr.count;
    }
    else if(tableView == self.personTableview)
    {// 召唤合伙人
        return self.personTypeArr.count;
    }
    else if(tableView == self.moneyTableview)
    {
        return self.moneyArr.count;
    }
    else if(tableView == self.personNumTableview)
    {
        return self.personNumArr.count;
    }
    else
    {
        return self.selectCityArr.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == listTable)
    {
        // 左侧的 tabview菜单
        NSLog(@"%@",self.listArr5[indexPath.row]);
        if ([self.listArr5[indexPath.row] isEqualToString:@"返 回"])
        {
            YnFirst = 0;
            
            self.listArr5 = [NSMutableArray arrayWithArray:self.listArr ];
            [listTable reloadData];
            [self removeAllDateBtnAction]; // 重置
        }
        else
        {
            
            YnFirst = (int)indexPath.row;
            if (indexPath.row == 0)
            {
                if ([self.listArr5[0] isEqualToString:@"全 部"
                     ])
                {
                    self.shapeStr = self.listArr5[indexPath.row];
                    self.listArr5 = [NSMutableArray arrayWithArray:self.listArr1 ];
                    [listTable reloadData];
                    if ([self.listArr5[0] isEqualToString:@"地 区"])
                    {
                        if (YnFirst == 0)
                        {
                            [self selectTableView:listTable];
//                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                        }
                        else
                        {
                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                        }
                    }
                }
                
                [self removeAllViewSaddTableView:self.mytableview];
            }
            else if(indexPath.row == 1)
            {
                if ([self.listArr5[indexPath.row] isEqualToString:@"外  包"])
                {
                    YnFirst = 0;
                    self.shapeStr = self.listArr5[indexPath.row];
                    self.listArr5 = [NSMutableArray arrayWithArray:self.listArr3];
                    [listTable reloadData];
                    [self removeAllViewSaddTableView:self.mytableview];
                    if ([self.listArr5[0] isEqualToString:@"地 区"])
                    {
                        if (YnFirst == 0)
                        {
                            [self selectTableView:listTable];
//                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                            
                            [self removeAllViewSaddTableView:self.mytableview];
                        }
                        else
                        {
                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                        }
                    }
                }
                else
                {
                    [self removeAllViewSaddTableView:self.leftTableView];
                }
            }
            else if (indexPath.row == 2)
            {
                if ([self.listArr5[indexPath.row] isEqualToString:@"合  作"
                     ])
                {
                    YnFirst = 0;
                    self.shapeStr = self.listArr5[indexPath.row];
                    self.listArr5 = [NSMutableArray arrayWithArray:self.listArr4 ];
                    [listTable reloadData];
                    if ([self.listArr5[0] isEqualToString:@"地 区"])
                    {
                        if (YnFirst == 0)
                        {
                            [self selectTableView:listTable];
//                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                            [self removeAllViewSaddTableView:self.mytableview];
                        }
                        else
                        {
                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                        }
                    }
                }
                else
                {
                    if (self.listArr5.count == 8 && [self.listArr5[indexPath.row] isEqualToString:@"项目阶段"
                                                     ])
                    {
                        [self removeAllViewSaddTableView:self.JiePaTableview];
                    }
                    else
                    {
                        [self removeAllViewSaddTableView:self.JieZoTableview];
                    }
                }
            }
            else if (indexPath.row == 3)
            {
                if ([self.listArr5[indexPath.row] isEqualToString:@"股权众筹"
                     ]||[self.listArr5[indexPath.row] isEqualToString:@"奖励众筹"
                         ])
                {
                    YnFirst = 0;
                    self.shapeStr = self.listArr5[indexPath.row];
                    self.listArr5 = [NSMutableArray arrayWithArray:self.listArr2 ];
                    [listTable reloadData];
                    if ([self.listArr5[0] isEqualToString:@"地 区"])
                    {
                        if (YnFirst == 0)
                        {
                            [self selectTableView:listTable];
//                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                            [self removeAllViewSaddTableView:self.mytableview];
                            
                        }
                        else
                        {
                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                        }
                    }
                }
                else
                {
                    if (self.listArr5.count == 8 && [self.listArr5[indexPath.row] isEqualToString:@"项目投资"
                                                     ])
                    {
                        [self removeAllViewSaddTableView:self.tenderTableview];
                    }
                }
            }
            else if (indexPath.row == 4)
            {
                if ([self.listArr5[indexPath.row] isEqualToString:@"股权众筹"
                     ]||[self.listArr5[indexPath.row] isEqualToString:@"奖励众筹"
                         ])
                {
                    YnFirst = 0;
                    self.shapeStr = self.listArr5[indexPath.row];
                    self.listArr5 = [NSMutableArray arrayWithArray:self.listArr2 ];
                    [listTable reloadData];
                    if ([self.listArr5[0] isEqualToString:@"地 区"])
                    {
                        if (YnFirst == 0)
                        {
                            [self selectTableView:listTable];
//                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                            [self removeAllViewSaddTableView:self.mytableview];
                            
                        }
                        else
                        {
                            [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                        }
                    }
                }
                else
                {
                    if (self.listArr5.count == 8 && [self.listArr5[indexPath.row] isEqualToString:@"召唤合伙人"
                                                     ])
                    {
                        
                        [self removeAllViewSaddTableView:self.personTableview];
                    }
                }
            }
            else if (indexPath.row == 5)
            {
                if (self.listArr5.count == 8 && [self.listArr5[indexPath.row] isEqualToString:@"现有资金"
                                                 ])
                {
                    
                    [self removeAllViewSaddTableView:self.moneyTableview];
                }
            }
            else if (indexPath.row == 6)
            {
                if (self.listArr5.count == 8 && [self.listArr5[indexPath.row] isEqualToString:@"参与人数"
                                                 ])
                {
                    
                    [self removeAllViewSaddTableView:self.personNumTableview];
                }
            }
            
        }
        
    }
    else if(tableView == self.leftTableView)
    {
        // 项目方向
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmit removeAllObjects];
            for (int i = 0; i < self.hangArr.count; i ++)
            {
                if ([self.dicCheck[[NSString stringWithFormat:@"%@",self.hangArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheck[[NSString stringWithFormat:@"%@",self.hangArr[i]]] = @"NO";
                }
            }
            
            self.dicCheck[[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmit addObject:self.hangArr[indexPath.row]];
            self.hangStr = [NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]];
            [self.leftTableView reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.hangStr = @"";
            [self.arrTransmit removeAllObjects];
            [self.dicCheck setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.leftTableView reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if(tableView == self.JieZoTableview)
    {
         //众筹 项目阶段
        self.PaStr = @"";
        [self.arrTransmitPa removeAllObjects];
        self.dicCheckPa = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO"] forKeys:self.projectJieArr];
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheckZJ objectForKey:[NSString stringWithFormat:@"%@",self.zhongJieArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmitZJ removeAllObjects];
            for (int i = 0; i < self.zhongJieArr.count; i ++)
            {
                if ([self.dicCheckZJ[[NSString stringWithFormat:@"%@",self.zhongJieArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckZJ[[NSString stringWithFormat:@"%@",self.zhongJieArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckZJ[[NSString stringWithFormat:@"%@",self.zhongJieArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitZJ addObject:self.zhongJieArr[indexPath.row]];
            self.zjStr = [NSString stringWithFormat:@"%@",self.zhongJieArr[indexPath.row]];
            [self.JieZoTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.zjStr = @"";
            [self.arrTransmitZJ removeAllObjects];
            [self.dicCheckZJ setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.JieZoTableview reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if(tableView == self.JiePaTableview)
    {
         //合作 项目阶段
        self.zjStr = @"";
        [self.arrTransmitZJ removeAllObjects];
        self.dicCheckZJ = [[NSMutableDictionary alloc]initWithObjects:@[@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.zhongJieArr];
        
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheckPa objectForKey:[NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmitPa removeAllObjects];
            for (int i = 0; i < self.projectJieArr.count; i ++)
            {
                if ([self.dicCheckPa[[NSString stringWithFormat:@"%@",self.projectJieArr[i]]]isEqualToString:@"YES"])
                {
                    self.dicCheckPa[[NSString stringWithFormat:@"%@",self.projectJieArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckPa[[NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitPa addObject:self.projectJieArr[indexPath.row]];
            self.PaStr = [NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]];
            [self.JiePaTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.PaStr = @"";
            [self.arrTransmitPa removeAllObjects];
            [self.dicCheckPa setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.JiePaTableview reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if(tableView == self.tenderTableview)
    {
        // 项目投资
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheckTen objectForKey:[NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmitTen removeAllObjects];
            for (int i = 0; i < self.tenderArr.count; i ++)
            {
                if ([self.dicCheckTen[[NSString stringWithFormat:@"%@",self.tenderArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckTen[[NSString stringWithFormat:@"%@",self.tenderArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckTen[[NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitTen addObject:self.tenderArr[indexPath.row]];
            self.TenStr = [NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]];
            [self.tenderTableview reloadData];
            [listTable reloadData];
        }
        else
        {
            self.TenStr = @"";
            [self.arrTransmitTen removeAllObjects];
            [self.dicCheckTen setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.tenderTableview reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if(tableView == self.personTableview)
    {
        // 召唤合伙人
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheckType objectForKey:[NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmitType removeAllObjects];
            for (int i = 0; i < self.personTypeArr.count; i ++)
            {
                if ([self.dicCheckType[[NSString stringWithFormat:@"%@",self.personTypeArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckType[[NSString stringWithFormat:@"%@",self.personTypeArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckType[[NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitType addObject:self.personTypeArr[indexPath.row]];
            self.TypeStr = [NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]];
            [self.personTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.TypeStr = @"";
            [self.arrTransmitType removeAllObjects];
            [self.dicCheckType setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.personTableview reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if(tableView == self.moneyTableview)
    {
        // 现有资金
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheckMone objectForKey:[NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmitMone removeAllObjects];
            for (int i = 0; i < self.moneyArr.count; i ++)
            {
                if ([self.dicCheckMone[[NSString stringWithFormat:@"%@",self.moneyArr[i]]]isEqualToString:@"YES"])
                {
                    self.dicCheckMone[[NSString stringWithFormat:@"%@",self.moneyArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckMone[[NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitMone addObject:self.moneyArr[indexPath.row]];
            self.MoneStr = [NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]];
            [self.moneyTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.MoneStr = @"";
            [self.arrTransmitMone removeAllObjects];
            [self.dicCheckMone setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.moneyTableview reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if(tableView == self.personNumTableview)
    {
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        if ([[self.dicCheckNum objectForKey:[NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmitNum removeAllObjects];
            for (int i = 0; i < self.personNumArr.count; i ++)
            {
                if ([self.dicCheckNum[[NSString stringWithFormat:@"%@",self.personNumArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckNum[[NSString stringWithFormat:@"%@",self.personNumArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckNum[[NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitNum addObject:self.personNumArr[indexPath.row]];
            self.NumStr = [NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]];
            [self.personNumTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.NumStr = @"";
            [self.arrTransmitNum removeAllObjects];
            [self.dicCheckNum setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.personNumTableview reloadData];
            [listTable reloadData];
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        // 地区
        if (self.selectCityArr.count > 1)
        {
            if (indexPath.row != 9)
            {
                SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
                if ([[self.dicCheckpl objectForKey:[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] isEqualToString:@"NO"])
                {
                    [self.arrTransmitPl removeAllObjects];
                    for (int i = 0; i < self.selectCityArr.count; i ++)
                    {
                        if ([self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[i]]]isEqualToString:@"YES"]) {
                            self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[i]]] = @"NO";
                        }
                    }
                    
                    self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] = @"YES";
                    [cell setChecked:YES];
                    [self.arrTransmitPl addObject:self.selectCityArr[indexPath.row]];
                    
                    self.placeId = [NSString stringWithFormat:@"%@",self.selectCityCodeArr[indexPath.row]];
                    self.placeNmae = [NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]];
                    
                    [self.mytableview reloadData];
                    [listTable reloadData];
                }
                else
                {
                    self.placeId = @"";
                    self.placeNmae = @"";
                    [self.arrTransmitPl removeAllObjects];
                    
                    [self.dicCheckpl setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]];
                    [cell setChecked:NO];
                    [self.mytableview reloadData];
                    [listTable reloadData];
                }
            }
            else
            {
                
                if ([self.delegate respondsToSelector:@selector(passViewControl)]) {
                    [self.delegate passViewControl];
                }
            }
            
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(passViewControl)]) {
                [self.delegate passViewControl];
            }
        }
        [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == listTable)
    {
        ListCell *cell = [ListCell cellWithTabelView:tableView];
        if (indexPath.row == 0)
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"地 区"
                 ])
            {
                if (self.arrTransmitPl.count)
                {
                    if ([[self.arrTransmitPl lastObject] isEqualToString:@"全 部"])
                    {
                         [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
            
        }
        else if (indexPath.row == 1)
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"项目方向"
                 ])
            {
                if (self.arrTransmit.count)
                {
                    if ([[self.arrTransmit lastObject] isEqualToString:@"全 部"])
                    {
                        [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
        }
        else if (indexPath.row == 2)
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"项目阶段"
                 ])
            {
                if (self.arrTransmitPa.count || self.arrTransmitZJ.count)
                {
                    if ([[self.arrTransmitPa lastObject] isEqualToString:@"全 部"])
                    {
                        [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
        }
        else if (indexPath.row == 3)
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"项目投资"
                 ])
            {
                if (self.arrTransmitTen.count)
                {
                    if ([[self.arrTransmitTen lastObject] isEqualToString:@"全 部"])
                    {
                        [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
        }
        else if (indexPath.row == 4)
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"召唤合伙人"
                 ])
            {
                if (self.arrTransmitType.count)
                {
                    if ([[self.arrTransmitType lastObject] isEqualToString:@"全 部"])
                    {
                        [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
        }
        else if (indexPath.row == 5)
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"现有资金"
                 ])
            {
                if (self.arrTransmitMone.count)
                {
                    if ([[self.arrTransmitMone lastObject] isEqualToString:@"全 部"])
                    {
                        [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
        }
        else
        {
            if ([self.listArr5[indexPath.row] isEqualToString:@"参与人数"
                 ])
            {
                if (self.arrTransmitNum.count)
                {
                    if ([[self.arrTransmitNum lastObject] isEqualToString:@"全 部"])
                    {
                        [cell setChecked:NO];
                    }
                    else
                    {
                    [cell setChecked:YES];
                    }
                }
                else
                {
                    [cell setChecked:NO];
                }
            }
            else
            {
                [cell setChecked:NO];
            }
        }
        cell.lblName.text = self.listArr5[indexPath.row];
        return cell;
    }
    else if(tableView == self.leftTableView)
    {
        // 项目方向
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.hangArr[indexPath.row];
        
        if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheck[[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmit addObject:self.hangArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheck[[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else if(tableView == self.JiePaTableview)
    {
        //合作 项目阶段
        if ([self.listArr5[0] isEqualToString:@"地 区"])
        {
            if (YnFirst == 0)
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            }
            else
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
            
        }
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.projectJieArr[indexPath.row];
        
        if ([[self.dicCheckPa objectForKey:[NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckPa[[NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitPa addObject:self.projectJieArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckPa[[NSString stringWithFormat:@"%@",self.projectJieArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else if(tableView == self.JieZoTableview)
    {
         //众筹 项目阶段
        if ([self.listArr5[0] isEqualToString:@"地 区"])
        {
            if (YnFirst == 0)
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            }
            else
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
            
        }
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.zhongJieArr[indexPath.row];
        
        if ([[self.dicCheckZJ objectForKey:[NSString stringWithFormat:@"%@",self.zhongJieArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckZJ[[NSString stringWithFormat:@"%@",self.zhongJieArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitZJ addObject:self.zhongJieArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckZJ[[NSString stringWithFormat:@"%@",self.zhongJieArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else if(tableView == self.tenderTableview)
    {
        if ([self.listArr5[0] isEqualToString:@"地 区"])
        {
            if (YnFirst == 0)
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            }
            else
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
            
        }
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.tenderArr[indexPath.row];
        
        if ([[self.dicCheckTen objectForKey:[NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckTen[[NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitTen addObject:self.tenderArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckTen[[NSString stringWithFormat:@"%@",self.tenderArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        return celll;
    }
    else if(tableView == self.personTableview)
    {
        // 召唤合伙人
        if ([self.listArr5[0] isEqualToString:@"地 区"])
        {
            if (YnFirst == 0)
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            }
            else
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
            
        }
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.personTypeArr[indexPath.row];
        
        if ([[self.dicCheckType objectForKey:[NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckType[[NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitType addObject:self.personTypeArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckType[[NSString stringWithFormat:@"%@",self.personTypeArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else if(tableView == self.moneyTableview)
    {
        //        if ([self.listArr5[0] isEqualToString:@"地 区"])
        //        {
        //            if (YnFirst == 0)
        //            {
        //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
        ////                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        //                [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        //            }
        //            else
        //            {
        //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        //            }
        //
        //        }
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.moneyArr[indexPath.row];
        
        if ([[self.dicCheckMone objectForKey:[NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckMone[[NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitMone addObject:self.moneyArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckMone[[NSString stringWithFormat:@"%@",self.moneyArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else if(tableView == self.personNumTableview)
    {
        if ([self.listArr5[0] isEqualToString:@"地 区"])
        {
            if (YnFirst == 0)
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            }
            else
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
            
        }
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.personNumArr[indexPath.row];
        
        if ([[self.dicCheckNum objectForKey:[NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckNum[[NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitNum addObject:self.personNumArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckNum[[NSString stringWithFormat:@"%@",self.personNumArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else
    {
        if ([self.listArr5[0] isEqualToString:@"地 区"])
        {
            if (YnFirst == 0)
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            }
            else
            {
                //                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:YnFirst inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
            
        }
        
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.selectCityArr[indexPath.row];
        if (self.selectCityArr.count == 1)
        {
            
            self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitPl addObject:self.selectCityArr[indexPath.row]];
            //            [listTable reloadData];
            
        }
        else
        {
            
            if ([[self.dicCheckpl objectForKey:[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] isEqualToString:@"YES"]) {
                self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] = @"YES";
                [celll setChecked:YES];
                [self.arrTransmitPl addObject:self.selectCityArr[indexPath.row]];
            }
            else
            {
                self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] = @"NO";
                [celll setChecked:NO];
                
            }
        }
        return celll;
    }
}

/// tableview 设置选中第一行
- (void)selectTableView:(UITableView *)table
{
    [table selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//设置选中第一行（默认有蓝色背景）
}

- (void)removeAllViewSaddTableView:(UITableView *)table
{
    //    [table selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    //    [self tableView:table didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [self.leftTableView removeFromSuperview];
    [self.mytableview removeFromSuperview];
    [self.JiePaTableview removeFromSuperview];
    [self.JieZoTableview removeFromSuperview];
    [self.tenderTableview removeFromSuperview];
    [self.moneyTableview removeFromSuperview];
    [self.personNumTableview removeFromSuperview];
    [leftView1 addSubview:table];
    [table reloadData];
}

- (NSArray *)hangArr
{
    if (!_hangArr) {
        _hangArr = @[@"全部",@"互联网", @"移动互联网",@"电信及增值",@"传媒娱乐", @"能源", @"医疗健康", @"旅游" ,@"游戏", @"金融", @"教育", @"房地产", @"物流仓库", @"农林牧渔", @"住宿餐饮", @"商品服务" ,@"消费品", @"文体艺术" ,@"加工制造", @"节能环保", @"其他" ,@"IT"];
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

- (NSArray *)shapeArr
{
    if (!_shapeArr) {
        _shapeArr = @[@"全 部",@"外  包",@"合  作",@"股权众筹",@"奖励众筹"];
    }
    return _shapeArr;
}


- (NSArray *)listArr
{
    if (!_listArr) {
        _listArr = @[@"全 部",@"外  包",@"合  作",@"股权众筹",@"奖励众筹"];
        //  @[@"项目类型",@"地 区"];
    }
    return _listArr;
}
- (NSArray *)listArr1
{
    if (!_listArr1) {
        _listArr1 = @[@"地 区",@"返 回"];
    }
    return _listArr1;
}

- (NSArray *)listArr3
{// 外包
    if (!_listArr3) {
        _listArr3 = @[@"地 区",@"项目方向",@"返 回"];
    }
    return _listArr3;
}

- (NSArray *)listArr4
{
    if (!_listArr4)
    {
        _listArr4 = @[@"地 区",@"项目方向",@"项目阶段",@"项目投资",@"召唤合伙人",@"现有资金",@"参与人数",@"返 回"];
    }
    return _listArr4;
}

- (NSArray *)listArr2
{
    if (!_listArr2) {
        _listArr2 = @[@"地 区",@"项目方向",@"项目阶段",@"返 回"];
    }
    return _listArr2;
}

@end
