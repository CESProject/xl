//
//  AddMorePlaceController.m
//  Creative
//
//  Created by Mr Wei on 16/2/3.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "AddMorePlaceController.h"
#import "Result.h"
#import "SelectCell.h"

#define BUTTONWIDTH (DEF_SCREEN_WIDTH-40)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-40)/11
@interface AddMorePlaceController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *regionName;
    NSArray *systemCodeArr;
    NSMutableArray *tableArray;
    NSMutableArray *diquarray;
    NSMutableArray *diquArr;
    
    NSMutableArray *ABCArray;//索引数组
}



@property(nonatomic,strong)NSMutableDictionary *senderDic;
@property (nonatomic , copy) NSMutableString *diquStr;

@end

@implementation AddMorePlaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    regionName = @[@"上海",@"北京",@"广州",@"郑州",@"武汉",@"天津",@"西安",@"南京",@"杭州"];
    systemCodeArr = @[@"1009",@"1001001",@"10119001",@"1016001",@"1017001",@"1002001",@"1029001",@"1010001",@"1011001"];
    diquArr = [NSMutableArray array];
    ABCArray = [[NSMutableArray alloc] init];
    self.title = @"地区";
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"back"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(sureSenderAction) withTitle:@"确定"];
    
    self.navigationItem.leftBarButtonItems = @[back];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    [self reloadTabview];
    
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    self.tableview = tableview;
    
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
    [self.view addSubview:tableview];
    [self addHeadView];
    self.arrTransmit = [NSMutableArray array];
    self.senderDic = [NSMutableDictionary dictionary];
    self.diquStr = [[NSMutableString alloc]init];
}

- (void)sureSenderAction
{
    
    //    for (NSString *str in [self.senderDic allValues])
    //    {
    //        [self.diquStr appendFormat:@"%@",str];
    //    }
    for (int i = 0; i < self.dicCheck.count; i ++) {
        NSString *str = [NSString stringWithFormat:@"%@",[self.dicCheck allValues][i]];
        if ([str isEqualToString:@"YES"]) {
            [ self.senderDic setObject:[self.dicCheck allKeys][i] forKey:@(i)];
        }
    }
   
    
    NSDictionary *dic = @{
                          @"arr":self.arrTransmit,
                          @"diquName":[self.senderDic allValues]
                          };
    NSLog(@"%@",[self.senderDic allValues]);
    if (self.passVc == 4)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ageResouceNature" object:nil userInfo:dic];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)reloadTabview
{
    WEAKSELF;
    //    [MHNetworkManager postReqeustWithURL:DEF_XITONGZIDIAN params:@{@"systemType":@"HOT_AREA"} successBlock:^(NSDictionary *returnData) {
    //
    //    } failureBlock:^(NSError *error) {
    //    } showHUD:YES];
    
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
            [weakSelf.tableview reloadData];
            [weakSelf analysis];
        }
    }];
    
}
- (void)addHeadView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 50);//BUTTONHEIGHT*3+100
    view.backgroundColor =DEF_RGB_COLOR(247, 247, 247);
    [self.view addSubview:view];
    
    UILabel *la = [[UILabel alloc] init];
    la.frame = CGRectMake(15, 20, 100, 25);
    la.text = @"热门城市";
    la.font = [UIFont systemFontOfSize:18];
    la.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    la.textColor = DEF_RGB_COLOR(139, 139, 139);
    [view addSubview:la];
    
    for (int i=0; i<regionName.count; i++)
    {
        CGRect frame;
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:regionName[i] forState:UIControlStateNormal];//设置title
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        Btn.tag = i;
        frame.size.width = BUTTONWIDTH;//设置按钮坐标及大小
        frame.size.height = BUTTONHEIGHT;
        frame.origin.x = 10 +(i%3)*(BUTTONWIDTH + 10);
        frame.origin.y = 55 +(i/3)*(BUTTONHEIGHT + 10);
        [Btn setFrame:frame];
        Btn.layer.borderColor = [UIColor grayColor].CGColor;
        Btn.layer.borderWidth = 1.0f;
        Btn.layer.cornerRadius = 5;
        Btn.layer.masksToBounds = YES;
        Btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn addTarget:self action:@selector(selectBthClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:Btn];
    }
    
    self.tableview.tableHeaderView = view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arra = tableArray[section];
    return arra.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ABCArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCell *celll = [SelectCell cellWithTabelView:tableView];
    NSArray *arra = tableArray[indexPath.section];
    Result *result = arra[indexPath.row];
    NSString *city = result.diquName;
    celll.lblName.text = city;
    
    
    if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",result.diquName]] isEqualToString:@"YES"])
    {
        self.dicCheck[[NSString stringWithFormat:@"%@",result.diquName]] = @"YES";
        [celll setChecked:YES];
        [self.arrTransmit addObject:result];
//        NSString *str = [NSString stringWithFormat:@"%@",result.diquName];
//        [self.senderDic  setObject:str forKey:indexPath];
        
        
    }
    else
    {
        /*
//        if (!self.reDicCheck.count||self.reDicCheck.count != 0) {
//            if ([[self.reDicCheck objectForKey:[NSString stringWithFormat:@"%@",result.diquName]] isEqualToString:@"YES"])
//            {
//                [self.reDicCheck removeObjectForKey:[NSString stringWithFormat:@"%@",result.diquName]];
//                self.dicCheck[[NSString stringWithFormat:@"%@",result.diquName]] = @"YES";
//                [celll setChecked:YES];
//                [self.arrTransmit addObject:result];
//                NSString *str = [NSString stringWithFormat:@"%@",result.diquName];
//                [self.senderDic  setObject:str forKey:indexPath];
//            }
//            else
//            {
////                self.dicCheck[[NSString stringWithFormat:@"%@",result.diquName]] = @"NO";
////                [celll setChecked:NO];
////                [self.arrTransmit removeObject:result];
////                [self.senderDic removeObjectForKey:indexPath];
//            }
//        }
//        else
//        {
        */
            self.dicCheck[[NSString stringWithFormat:@"%@",result.diquName]] = @"NO";
            [celll setChecked:NO];
            [self.arrTransmit removeObject:result];
        
//            [self.senderDic removeObjectForKey:indexPath];
//        }
    }
    
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 20)];
    lab.backgroundColor = DEF_RGB_COLOR(235, 235, 235);
    lab.text = [NSString stringWithFormat:@"  %@",ABCArray[section]];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor blackColor];
    return lab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arra = tableArray[indexPath.section];
    Result *result = arra[indexPath.row];
    //    NSString *city = result.diquName;
    //    //    NSString *city = arra[indexPath.row];
    //
    //    NSDictionary *dic = @{
    //                          @"arr":city,
    //                          @"id":result.diquID,
    //                          @"systemCode":result.diquCode
    //                          };
    //    if (self.passVc == 4)
    //    {
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"ageResouceNature" object:nil userInfo:dic];
    //    }
    //        [self.navigationController popViewControllerAnimated:YES];
    
    SelectCell *cell = (SelectCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",result.diquName]] isEqualToString:@"NO"])
    {
      
        
        self.dicCheck[[NSString stringWithFormat:@"%@",result.diquName]] = @"YES";
        [cell setChecked:YES];
        [self.tableview reloadData];
//        [self.arrTransmit addObject:result.diquName];
        
    }else {
        
       
//                [self.arrTransmit removeObject:result];
        [self.dicCheck setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",result.diquName]];
        //        [self.senderDic removeObjectForKey:indexPath];
                [cell setChecked:NO];
        [self.tableview reloadData];
    }
}
- (void)selectBthClick:(UIButton *)button
{
    NSDictionary *dic = @{
                          @"arr":button.titleLabel.text,
                          @"systemCode":systemCodeArr[button.tag]
                          };
    if (self.passVc == 4)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ageResouceNature" object:nil userInfo:dic];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)analysis
{
    
    NSMutableArray *ar = [self paiXu];
    tableArray = ar;
    for (int i =0; i<ar.count; i++) {
        
        
        NSArray *tempA = ar[i];
        Result *result = tempA[0];
        ABCArray[i]=[self translation:result.diquName];
    }
    [self.tableview reloadData];
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
//    self.dicCheck = [NSMutableDictionary dictionary];
    //遍历大数组，剔除没有数据的数组
    for (int i =0; i < arra.count; i++) {
        NSMutableArray *temp = [arra objectAtIndex:i];
        if (temp.count == 0) {
            [arra removeObject:temp];
//            [self.dicCheck setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",temp]];
        }
    }
    return arra;
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
