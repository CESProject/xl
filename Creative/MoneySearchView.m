//
//  MoneySearchView.m
//  Creative
//
//  Created by Mr Wei on 16/2/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MoneySearchView.h"

#import "SelectCell.h"
#import "Result.h"
#import "SelectCellTwo.h"
#import "SelectResultViewController.h"
#import "RegionViewController.h"
#import "ListCell.h"

@interface MoneySearchView ()<UITextFieldDelegate>
{
    UITableView *listTable;
    UIView *leftView1;
    
    NSArray *regionName;
    NSArray *systemCodeArr;
    
    NSArray *regionNameMore;
    NSArray *systemCodeArrMore;
    
    NSMutableArray *tableArray;
    NSMutableArray *diquarray;
    NSMutableArray *diquArr;
    
    NSMutableArray *ABCArray;//索引数组
    int YnFirst;
    
}




@property (nonatomic , strong) NSArray *listArr;

@end

@implementation MoneySearchView



- (UITableView *)leftTableView
{
    if (!_leftTableView) {
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
    self.dicCheckMore = [NSMutableDictionary dictionary];
    self.dicCheckpl = [NSMutableDictionary dictionary];
    //遍历大数组，剔除没有数据的数组
    for (int i =0; i < arra.count; i++) {
        NSMutableArray *temp = [arra objectAtIndex:i];
        if (temp.count == 0) {
            [arra removeObject:temp];
            [self.dicCheckpl setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",temp]];
            [self.dicCheckMore setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",temp]];
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
        self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.hangArr];
        self.arrTransmitPl = [NSMutableArray array];
        
        self.Idtags = [NSMutableString string];
        self.placeIDs = [NSMutableString string];
        self.placeNames = [NSMutableString string];
        self.arrTransmitId = [NSMutableArray array];
        self.sendDicId = [NSMutableDictionary dictionary];
        self.dicCheckId = [[NSMutableDictionary alloc]initWithObjects:@[ @"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.identityArr];
        
        self.arrTransmitAg = [NSMutableArray array];
        self.dicCheckAg = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.ageArr];
        
        //        tableArray = [NSMutableArray array];
        //        diquArr = [NSMutableArray array];
        //        ABCArray = [NSMutableArray array];
        self.selectCityArr = [NSMutableArray array];
        self.selectCityCodeArr = [NSMutableArray array];
        self.selectCityArrMore = [NSMutableArray array];
        self.selectCityCodeArrMore = [NSMutableArray array];
        
        self.hangStr       = @"";
        self.placeId       = @"";
        self.placeNmae     = @"";
        self.identityStr   = @"";
        self.ageStr        = @"";
        YnFirst = 0;
        
        self.placeIdArr = [NSMutableArray array];
        self.placeNmaeArr = [NSMutableArray array];
        self.sendDicCheck = [NSMutableDictionary dictionary];
        
        regionName = @[@"全部",@"上海",@"北京",@"广州",@"郑州",@"武汉",@"天津",@"西安",@"南京",@"杭州",@"查看更多城市"];
        systemCodeArr = @[@"",@"1009",@"1001001",@"10119001",@"1016001",@"1017001",@"1002001",@"1029001",@"1010001",@"1011001",@""];
        
        regionNameMore = @[@"上海",@"北京",@"广州",@"郑州",@"武汉",@"天津",@"西安",@"南京",@"杭州",@"查看更多城市"];
        systemCodeArrMore = @[@"1009",@"1001001",@"10119001",@"1016001",@"1017001",@"1002001",@"1029001",@"1010001",@"1011001",@""];
        
        self.selectCityArr = [regionName copy];
        self.selectCityCodeArr = [systemCodeArr copy];
        self.selectCityArrMore = [regionNameMore copy];
        self.selectCityCodeArrMore = [systemCodeArrMore copy];
        
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
    [alterBtn addTarget:self action:@selector(removeAllDateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [alterBtn setFrame:CGRectMake(sectionView.mj_w /2 - 30 , 10, 50, 30)];
    alterBtn.tintColor = [UIColor grayColor];
    
    [sectionView addSubview:alterBtn];
    
    
    UIButton *surerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [surerBtn setTitle:@"确定" forState:UIControlStateNormal];
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
    [self.placeIdArr removeAllObjects];
    [self.sendDicCheck removeAllObjects];
    [self.placeNmaeArr removeAllObjects];
    
    
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
    //    for (NSString *str in self.placeIdArr) {
    //        NSLog(@"%@",str);
    //    }
    [self.placeIdArr removeAllObjects];
    [self.sendDicCheck removeAllObjects];
    [self.placeNmaeArr removeAllObjects];
    
    self.selectCityArr = [regionName copy];
    self.selectCityCodeArr = [systemCodeArr copy];
    self.selectCityArrMore = [regionName copy];
    self.selectCityCodeArrMore = [systemCodeArr copy];
    
    self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.hangArr];
    
    
    [self.arrTransmit removeAllObjects];
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
    //    NSLog(@"%@",[self.sendDicId allValues]);
    [self.sendDicId removeAllObjects];
    self.Idtags = [NSMutableString string];
    self.placeIDs = [NSMutableString string];
    self.placeNames = [NSMutableString string];
    [self.arrTransmitId removeAllObjects];
    self.dicCheckId = [[NSMutableDictionary alloc]initWithObjects:@[ @"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.identityArr];
    
    [self.timeTableview reloadData];
    
    
    for (int i = 0; i < self.dicCheckMore.count; i ++)
    {
        NSString *str = [ NSString stringWithFormat:@"%@",[self.dicCheckMore allValues][i]];
        NSString *str1 = [ NSString stringWithFormat:@"%@",[self.dicCheckMore allKeys][i]];
        if ([str isEqualToString:@"YES"])
        {
            self.dicCheckMore[str1] = @"NO";
        }
    }
    [self.arrTransmitMore removeAllObjects];
    self.dicCheckAg = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.ageArr];
    
    [self.arrTransmitAg removeAllObjects];
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
    //       return ABCArray.count;
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if([tableView isEqual:self.mytableview]|| [tableView isEqual:self.ageTableview])
//    {
//        return 30;
//    }
//    else
//    {
//        return 0;
//    }
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    if([tableView isEqual:self.mytableview] )
//    {
//
//        if (self.selectCityArr.count > 1)
//        {
//            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 20)];
//            lab.backgroundColor = DEF_RGB_COLOR(235, 235, 235);
//            lab.text = @"热门城市";
//            lab.font = [UIFont systemFontOfSize:14];
//            lab.textColor = [UIColor blackColor];
//            return lab;
//        }
//        else
//        {
//            return [[UIView alloc]init];
//        }
//
//
//
//    }
//    else if ([tableView isEqual:self.ageTableview])
//    {
//         if (self.selectCityArrMore.count > 1)
//         {
//            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 20)];
//            lab.backgroundColor = DEF_RGB_COLOR(235, 235, 235);
//             lab.text = @"已选城市";
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
//        return [[UIView alloc]init];
//    }
//}

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
    
    else if ([tableView isEqual:self.ageTableview])
    {
        return self.selectCityArrMore.count;
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
            [self.moneyTableview removeFromSuperview];
            [leftView1 addSubview:self.leftTableView];
            [self.leftTableView reloadData];
        }
        else if (indexPath.row == 1)
        {
            YnFirst = 2;
            [self.leftTableView removeFromSuperview];
            [self.timeTableview removeFromSuperview];
            [self.ageTableview removeFromSuperview];
            [self.moneyTableview removeFromSuperview];
            [leftView1 addSubview:self.mytableview];
            [self.mytableview reloadData];
        }
        else if(indexPath.row == 2)
        {
            YnFirst = 3;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            [self.ageTableview removeFromSuperview];
            [self.moneyTableview removeFromSuperview];
            [leftView1 addSubview:self.timeTableview];
            [self.timeTableview reloadData];
        }
        else if(indexPath.row == 3)
        {
            YnFirst = 4;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            [self.timeTableview removeFromSuperview];
            [self.moneyTableview removeFromSuperview];
            [leftView1 addSubview:self.ageTableview];
            [self.ageTableview reloadData];
        }
        else
        {
            YnFirst = 5;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            [self.timeTableview removeFromSuperview];
            [self.ageTableview removeFromSuperview];
            [leftView1 addSubview:self.moneyTableview];
            [self.moneyTableview reloadData];
        }
        
    }
    else if([tableView isEqual:self.leftTableView])
    { // 资金类型
        
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
        
    }
    else if([tableView isEqual:self.mytableview])
    {
        // 所在地区
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
                    //                        [self.arrTransmit removeObject:self.selectCityArr[indexPath.row]];
                    [self.arrTransmitPl removeAllObjects];
                    
                    [self.dicCheckpl setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.selectCityArr[indexPath.row]]];
                    [cell setChecked:NO];
                    [self.mytableview reloadData];
                    [listTable reloadData];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(passViewControl)])
                {
                    [self.delegate passViewControl];
                }
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(passViewControl)])
            {
                [self.delegate passViewControl];
            }
        }
    }
    else if([tableView isEqual:self.ageTableview])
    {
        // 投资地区
        if (![self.selectCityArrMore[indexPath.row] isEqualToString:@"查看更多城市"])
        {
            //            if (indexPath.row != 9)
            //            {
            SelectCell *cell = (SelectCell *)[tableView cellForRowAtIndexPath:indexPath];
            if ([[self.dicCheckMore objectForKey:[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]] isEqualToString:@"NO"])
            {
                
                
                [self.dicCheckMore removeObjectForKey:[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]];
                [self.arrTransmitMore removeObject:[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]];
                self.dicCheckMore[[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]] = @"YES";
                [cell setChecked:YES];
                [self.arrTransmitMore addObject:self.selectCityArrMore[indexPath.row]];
                [self.placeIdArr addObject: self.selectCityCodeArrMore[indexPath.row]];
                [self.placeNmaeArr addObject:self.selectCityArrMore[indexPath.row]];
                [self.sendDicCheck setObject:@"YES" forKey:self.selectCityArrMore[indexPath.row]];
                [self.ageTableview reloadData];
                
            }
            else
            {
                [self.arrTransmitMore removeObject:self.selectCityArrMore[indexPath.row]];
                [self.dicCheckMore setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]];
                [self.placeIdArr removeObject:self.selectCityCodeArrMore[indexPath.row]];
                [self.placeNmaeArr removeObject:self.selectCityArrMore[indexPath.row]];
                [self.sendDicCheck removeObjectForKey:self.selectCityArrMore[indexPath.row]];
                [cell setChecked:NO];
                [self.ageTableview reloadData];
                
            }
            
            
            
            //            }
            //            else
            //            {
            //
            //                if ([self.delegate respondsToSelector:@selector(passViewMorePlaceControlDic:andArr:)]) {
            ////                    [self.delegate passViewMorePlaceControlDic:self.sendDicCheck andArr:nil];
            //                     [self.delegate passViewMorePlaceControlDic:self.dicCheckMore andArr:self.arrTransmitMore];
            //                }
            //            }
            
            
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(passViewMorePlaceControlDic:andArr:)]) {
                //                [self.delegate passViewMorePlaceControlDic:self.sendDicCheck andArr:nil];
                [self.delegate passViewMorePlaceControlDic:self.dicCheckMore andArr:self.arrTransmitMore];
            }
        }
        [listTable reloadData];
    }
    else if([tableView isEqual:self.timeTableview])
    {
        // 投资行业
        SelectCell *cell = (SelectCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.dicCheckId objectForKey:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            
            [self.arrTransmitId removeObject:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]];
            self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitId addObject:self.identityArr[indexPath.row]];
            [self.timeTableview reloadData];
            
            self.identityStr = [NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]];
            
            [listTable reloadData];
            
        }
        else
        {
            self.identityStr = @"";
            
            [self.arrTransmitId removeObject:self.identityArr[indexPath.row]];
            [self.dicCheckId setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]];
            
            [cell setChecked:NO];
            [self.timeTableview reloadData];
            [listTable reloadData];
            
        }
    }
    else
    {
        
        {
            SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
            if ([[self.dicCheckAg objectForKey:[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] isEqualToString:@"NO"])
            {
                [self.arrTransmitAg removeAllObjects];
                for (int i = 0; i < self.ageArr.count; i ++)
                {
                    if ([self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[i]]]isEqualToString:@"YES"]) {
                        self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[i]]] = @"NO";
                    }
                }
                
                self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] = @"YES";
                [cell setChecked:YES];
                [self.arrTransmitAg addObject:self.ageArr[indexPath.row]];
                self.ageStr = [NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]];
                [self.moneyTableview reloadData];
                [listTable reloadData];
                
            }
            else
            {
                self.ageStr = @"";
                [self.arrTransmitAg removeAllObjects];
                [self.dicCheckAg setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]];
                [cell setChecked:NO];
                [self.moneyTableview reloadData];
                [listTable reloadData];
            }
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
            else if (YnFirst == 5)
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            else
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:6 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            if (!self.arrTransmit.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                if ([[self.arrTransmit lastObject] isEqualToString:@"全部"])
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
                if ([[self.arrTransmitPl lastObject] isEqualToString:@"全部"]) {
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
//                if ([[self.arrTransmitId lastObject] isEqualToString:@"全部"])
//                {
//                    [cell setChecked:NO];
//                }
//                else
//                {
                    [cell setChecked:YES];
//                }
            }
            cell.lblName.text =self.listArr[indexPath.row];
        }
        else if (indexPath.row == 3)
        {
            if (!self.placeIdArr.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                
                [cell setChecked:YES];
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
    {
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.hangArr[indexPath.row];
        
        if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",self.hangArr[indexPath.row]]] isEqualToString:@"YES"])
        {
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
    else if([tableView isEqual:self.ageTableview])
    {
        // 投资地区
        SelectCell *celll = [SelectCell cellWithTabelView:tableView];
        celll.lblName.text = self.selectCityArrMore[indexPath.row];
        
        if ([[self.dicCheckMore objectForKey:[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]] isEqualToString:@"YES"])
        {
            self.dicCheckMore[[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]] = @"YES";
            // 投资地区
            if (![self.selectCityArrMore[indexPath.row] isEqualToString:@"查看更多城市"])
            {
            [celll setChecked:YES];
            }
            else
            {
                [celll setChecked:NO];
            }
            [self.arrTransmitMore addObject:self.selectCityArrMore[indexPath.row]];
            
        }
        else
        {
            self.dicCheckMore[[NSString stringWithFormat:@"%@",self.selectCityArrMore[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        if (indexPath.row == 9)
        {
            celll.btnS.alpha = 0;
        }
        celll.lblName.text = self.selectCityArrMore[indexPath.row];
        return celll;
    }
    else if ([tableView isEqual:self.timeTableview])
    {
        // 投资行业
        SelectCell *celll = [SelectCell cellWithTabelView:tableView];
        //        [self.sendDicId removeAllObjects];
        if ([[self.dicCheckId objectForKey:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] isEqualToString:@"YES"])
        {
            [self.sendDicId setObject:@(indexPath.row) forKey:self.identityArr[indexPath.row]];
            
            self.dicCheckId[[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitId addObject:self.identityArr[indexPath.row]];
        }
        else
        {
            [self.arrTransmitId removeObject:self.identityArr[indexPath.row]];
            [self.dicCheckId setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.identityArr[indexPath.row]]];
            [self.sendDicId removeObjectForKey:self.identityArr[indexPath.row]];
            [celll setChecked:NO];
        }
        celll.lblName.text = self.identityArr[indexPath.row];
        return celll;
    }
    else
    {
        // 投资金额
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.ageArr[indexPath.row];
        
        if ([[self.dicCheckAg objectForKey:[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckAg[[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitAg addObject:self.ageArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheck[[NSString stringWithFormat:@"%@",self.ageArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    
    
}

- (NSArray *)listArr
{
    if (!_listArr) {
        _listArr = @[@"资金类型",@"所在地区",@"投资行业",@"投资地区",@"投资金额"];
    }
    return _listArr;
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
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
