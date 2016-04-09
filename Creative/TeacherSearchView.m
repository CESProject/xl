//
//  TeacherSearchView.m
//  Creative
//
//  Created by Mr Wei on 16/2/24.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "TeacherSearchView.h"

//#import "SelectCell.h"
#import "Result.h"
#import "SelectCellTwo.h"
#import "SelectResultViewController.h"
#import "RegionViewController.h"
#import "ListCell.h"

@interface TeacherSearchView ()<UITextFieldDelegate>
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


@property(nonatomic,strong)NSMutableArray *arrTransmit;
@property(nonatomic,strong)NSMutableDictionary *dicCheck;

@property(nonatomic,strong)NSMutableArray *arrTransmitId;
@property(nonatomic,strong)NSMutableDictionary *dicCheckId;

@property(nonatomic,strong)NSMutableArray *arrTransmitPl;
@property(nonatomic,strong)NSMutableDictionary *dicCheckpl;

@property(nonatomic,strong)NSMutableArray *arrTransmitAg;
@property(nonatomic,strong)NSMutableDictionary *dicCheckAg;

@property (nonatomic , strong) NSArray *listArr;


@end

@implementation TeacherSearchView

- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        //        _leftTableView.backgroundColor = [UIColor grayColor];
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

- (UITableView *)timeTableview
{
    if (!_timeTableview) {
        
        _timeTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _timeTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _timeTableview.dataSource = self;
        _timeTableview.delegate  = self;
        _timeTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _timeTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _timeTableview;
}

- (UITableView *)ageTableview
{
    if (!_ageTableview) {
        
        _ageTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStyleGrouped];
        _ageTableview.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(43, 44, 43);
        
        _ageTableview.dataSource = self;
        _ageTableview.delegate  = self;
        _ageTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _ageTableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
        
    }
    return _ageTableview;
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
        self.arrTransmit = [NSMutableArray array];
        self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.hangArr];
        self.arrTransmitPl = [NSMutableArray array];
        
        self.arrTransmitId = [NSMutableArray array];
        self.dicCheckId = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.identityArr];
        
        self.arrTransmitAg = [NSMutableArray array];
        self.dicCheckAg = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.ageArr];
        
        //        tableArray = [NSMutableArray array];
        //        diquArr = [NSMutableArray array];
        //        ABCArray = [NSMutableArray array];
        self.selectCityArr = [NSMutableArray array];
        self.selectCityCodeArr = [NSMutableArray array];
        
        self.hangStr       = @"";
        self.placeId       = @"";
        self.placeNmae     = @"";
        self.identityStr   = @"";
        self.ageStr        = @"";
        YnFirst = 0;
        
        regionName = @[@"全部",@"上海",@"北京",@"广州",@"郑州",@"武汉",@"天津",@"西安",@"南京",@"杭州",@"查看更多城市"];
        systemCodeArr = @[@"",@"1009",@"1001001",@"10119001",@"1016001",@"1017001",@"1002001",@"1029001",@"1010001",@"1011001",@""];
        
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
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    //        _searchView.alpha = 0.5;
    
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
    [alterBtn addTarget:self action:@selector(removeAllDateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    
    //    self.hangStr       = @"";
    //    self.placeId       = @"";
    //    self.placeNmae     = @"";
    //    self.identityStr   = @"";
    //    self.ageStr        = @"";
    //    YnFirst = 0;
    
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,saveView.mj_y + saveView.mj_h + 1, self.mj_w/ 5 + 40 , self.mj_h - saveView.mj_y - saveView.mj_h - 1) style:UITableViewStylePlain];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:listTable];
    
    leftView1 = [[UIView alloc]initWithFrame:CGRectMake(self.mj_w / 5 + 41, saveView.mj_y + saveView.mj_h + 1, self.mj_w / 5 *4 - 1, self.mj_h - saveView.mj_y - saveView.mj_h - 1)];
    leftView1.backgroundColor = [UIColor whiteColor];
    
    
    [leftView1 addSubview:self.leftTableView];
    [self.leftTableView reloadData];
    
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

- (void)removeAllDateBtnAction:(UIButton *)sender
{
    self.hangStr       = @"";
    self.placeId       = @"";
    self.placeNmae     = @"";
    self.identityStr   = @"";
    self.ageStr        = @"";
    YnFirst = 0;
    
    self.selectCityArr = [regionName copy];
    self.selectCityCodeArr = [systemCodeArr copy];
    
    [self.arrTransmit removeAllObjects];
    self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.hangArr];
    
    [self.leftTableView reloadData];
    
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
    
    [self.mytableview reloadData];
    [self.arrTransmitId removeAllObjects];
    self.dicCheckId = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.identityArr];
    
    [self.timeTableview reloadData];
    [self.arrTransmitAg removeAllObjects];
    self.dicCheckAg = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.ageArr];
    [self.ageTableview reloadData];
    
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
    
    //    if ([tableView isEqual:listTable]) {
    //
    //        return 1;
    //    }
    //    else if([tableView isEqual:self.leftTableView])
    //    {
    //        return 1;
    //    }
    //    else
    //    {
    //       return ABCArray.count;
    return 1;
    //    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if([tableView isEqual:self.mytableview])
    //    {
    //        return 30;
    //    }
    //    else
    //    {
    return 0;
    //    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //    if([tableView isEqual:self.mytableview])
    //    {
    //        if (self.selectCityArr.count > 1) {
    //
    //
    //            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 20)];
    //            lab.backgroundColor = DEF_RGB_COLOR(235, 235, 235);
    //            //    lab.text = [NSString stringWithFormat:@"  %@",ABCArray[section]];
    //            lab.text = @"热门城市";
    //            lab.font = [UIFont systemFontOfSize:14];
    //            lab.textColor = [UIColor blackColor];
    //            return lab;
    //        }
    //        else
    //        {
    //            return [[UIView alloc]init];
    //        }
    //    }
    //    else
    //    {
    return [[UIView alloc]init];
    //    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:listTable]) {
        
        return self.listArr.count;
    }
    else if([tableView isEqual:self.leftTableView])
    {
        return self.hangArr.count;
    }
    else if ([tableView isEqual:self.mytableview])
    {
        return self.selectCityArr.count;
    }
    else if([tableView isEqual:self.timeTableview] )
    {
        return self.identityArr.count;
    }
    else
    {
        return self.ageArr.count;
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
    if ([tableView isEqual:listTable])
    {
        if (indexPath.row == 0)
        {
            YnFirst = 1;
            [self.mytableview removeFromSuperview];
            [self.timeTableview removeFromSuperview];
            [self.ageTableview removeFromSuperview];
            [leftView1 addSubview:self.leftTableView];
            [self.leftTableView reloadData];
        }
        else if (indexPath.row == 1)
        {
            YnFirst = 2;
            [self.leftTableView removeFromSuperview];
            [self.timeTableview removeFromSuperview];
            [self.ageTableview removeFromSuperview];
            [leftView1 addSubview:self.mytableview];
            [self.mytableview reloadData];
        }
        else if(indexPath.row == 2)
        {
            YnFirst = 3;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            [self.ageTableview removeFromSuperview];
            [leftView1 addSubview:self.timeTableview];
            [self.timeTableview reloadData];
        }
        else
        {
            YnFirst = 4;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            [self.timeTableview removeFromSuperview];
            [leftView1 addSubview:self.ageTableview];
            [self.ageTableview reloadData];
        }
    }
    else if([tableView isEqual:self.leftTableView])
    {    // 从事行业
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            [self.arrTransmit removeAllObjects];
            for (int i = 0; i < self.hangArr.count; i ++)
            {
                if ([self.dicCheck[[NSString stringWithFormat:@"%@",self.hangArr[i]]]isEqualToString:@"YES"])
                {
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
    }
    else if([tableView isEqual:self.mytableview])
    {
        // 所在区域
        
        if (self.selectCityArr.count > 1)
        {
            if (indexPath.row != 9)
            {
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
                        //                        [self.arrTransmit removeObject:self.selectCityArr[indexPath.row]];
                        [self.arrTransmitPl removeAllObjects];
                        
                        [self.dicCheckpl setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]];
                        [cell setChecked:NO];
                        [self.mytableview reloadData];
                        [listTable reloadData];
                    }
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
        
    }
    
    else if([tableView isEqual:self.timeTableview])
    {
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.dicCheckId objectForKey:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            
            //            [self.arrTransmitId removeAllObjects];
            for (int i = 0; i < self.identityArr.count; i ++)
            {
                if ([self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            //            [self.arrTransmitId addObject:self.identityArr[indexPath.row]];
            self.identityStr = [NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]];
            [self.timeTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.identityStr = @"";
            //            [self.arrTransmitId removeAllObjects];
            [self.dicCheckId setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.timeTableview reloadData];
            [listTable reloadData];
        }
        
    }
    else
    {
        
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.dicCheckAg objectForKey:[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            
            //            [self.arrTransmitAg removeAllObjects];
            for (int i = 0; i < self.ageArr.count; i ++)
            {
                if ([self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            //            [self.arrTransmitAg addObject:self.ageArr[indexPath.row]];
            self.ageStr = [NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]];
            [self.ageTableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.ageStr = @"";
            //            [self.arrTransmitAg removeAllObjects];
            [self.dicCheckAg setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.ageTableview reloadData];
            [listTable reloadData];
        }
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:listTable])
    {
        ListCell *cell = [ListCell cellWithTabelView:tableView];
        if (indexPath.row == 0)
        {
            if (YnFirst == 0 || YnFirst == 1 )
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];//实现点击第一行所调用的方法
            }
            else if (YnFirst == 2)
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            else if (YnFirst == 3)
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            else if (YnFirst == 4)
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            else
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            if (!self.arrTransmit.count) {
                [cell setChecked:NO];
            }
            else
            {
                if ([self.arrTransmit[indexPath.row] isEqualToString:@"全部"])
                {
                    [cell setChecked:NO];
                }
                else
                {
                    [cell setChecked:YES];
                }
            }
            cell.lblName.text = self.listArr[indexPath.row];
        }
        else if (indexPath.row == 1)
        {
            if (!self.arrTransmitPl.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                if ([self.arrTransmitPl[indexPath.row] isEqualToString:@"全部"])
                {
                    [cell setChecked:NO];
                }
                else
                {
                    [cell setChecked:YES];
                }
            }
            cell.lblName.text =self.listArr[indexPath.row];
        }
        else if (indexPath.row == 2)
        {
            if (!self.arrTransmitId.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                if ([[self.arrTransmitId lastObject] isEqualToString:@"全部"])
                {
                    [cell setChecked:NO];
                }
                else
                {
                    [cell setChecked:YES];
                }
            }
            cell.lblName.text =self.listArr[indexPath.row];
        }
        else
        {
            if (!self.arrTransmitAg.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                if ([[self.arrTransmitAg lastObject] isEqualToString:@"全部"])
                {
                    [cell setChecked:NO];
                }
                else
                {
                    [cell setChecked:YES];
                }
            }
            cell.lblName.text = self.listArr[indexPath.row];
        }
        
        return cell;
    }
    else if([tableView isEqual:self.leftTableView])
    { // 从事行业
        
        
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
    else if([tableView isEqual:self.mytableview])
    {
        // 所在区域
        
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.selectCityArr[indexPath.row];
        if (self.selectCityArr.count == 1)
        {
            
            self.dicCheckpl[[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitPl addObject:self.selectCityArr[indexPath.row]];
            [listTable reloadData];
            
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
    else if ([tableView isEqual:self.timeTableview])
    {
        // 身份
        
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.identityArr[indexPath.row];
        
        if ([[self.dicCheckId objectForKey:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] isEqualToString:@"YES"])
        {
            self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitId addObject:self.identityArr[indexPath.row]];
        }
        else
        {
            self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] = @"NO";
            [self.arrTransmitId removeObject:self.identityArr[indexPath.row]];
            [celll setChecked:NO];
            
        }
        return celll;
    }
    else
    {
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.ageArr[indexPath.row];
        
        if ([[self.dicCheckAg objectForKey:[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitAg addObject:self.ageArr[indexPath.row]];
        }
        else
        {
            self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] = @"NO";
            [self.arrTransmitAg removeObject:self.ageArr[indexPath.row]];
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    
    
}

- (NSArray *)listArr
{
    if (!_listArr) {
        _listArr = @[@"从事行业",@"所在区域",@"身   份",@"年   龄"];
    }
    return _listArr;
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
        _identityArr = @[@"全部",@"学生",@"军人",@"其他",@"职场人",@"创业者",@"边工作边创业"];
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
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
