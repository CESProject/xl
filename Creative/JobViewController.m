//
//  JobViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/27.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "JobViewController.h"
#import "informationModel.h"
#import "CareerTableViewCell.h"

/// pickview 的高度
#define hPickViewHeight 50

@interface JobViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *comTableView;
}

@property (nonatomic , strong) NSMutableArray *modelArr;
@property (nonatomic , strong) NSMutableArray *infoModelArr;

@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;
@property (nonatomic , strong) UIButton *nextBtn;
@property (nonatomic , strong) UIButton *comNextBtn;

@end

@implementation JobViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"职业信息";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //    [self initView];
    [self loadServeData];
    
}

- (void)loadServeData
{
    WEAKSELF;
    self.infoModelArr = [NSMutableArray array];
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZYZHIYEXX params:@{@"createBy":DEF_USERID } complete:^(BOOL successed, NSDictionary *result)
     {
         if (successed)
         {
//             [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
             NSMutableArray *arr = [NSMutableArray array];
             arr = [result[@"lists"][@"content"] mutableCopy];
             if (arr.count != 0)
             {
                 for (NSDictionary *dic in result[@"lists"][@"content"])
                 {
                     NSString *str1 = dic[@"workEndDate"];
                     NSString *str2 = dic[@"workStartDate"];
                     informationModel *imodel = [informationModel objectWithKeyValues:dic];
                     imodel.workEndDate = [common sectionStrByCreateTime:str1.doubleValue];
                     imodel.workStartDate = [common sectionStrByCreateTime:str2.doubleValue];
                     [weakSelf.infoModelArr  addObject:imodel];
                 }
             }
             else
             {
//                 NSLog(@"%ld",weakSelf.infoModelArr.count);
                 if (weakSelf.infoModelArr.count == 0) {
                     weakSelf.infoModelArr = [NSMutableArray array];
                     informationModel *inmodel = [informationModel new];
                     inmodel.strID = @"";
                     inmodel.provinceId = @"";
                     inmodel.provinceName = @"";
                     inmodel.cityId = @"";
                     inmodel.cityName = @"";
                     inmodel.organizationName = @"";
                     inmodel.workStartDate = @"";
                     inmodel.workEndDate = @"";
                     inmodel.position = @"";
                     [weakSelf.infoModelArr addObject:inmodel];
                 }
             }
             
         }
         [weakSelf initView];
         NSLog(@"%@",result);
     }];
}

- (void)initView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h)];
    sc.backgroundColor = [UIColor whiteColor];
    
    
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.mj_w, self.view.bounds.size.height - 160) style:UITableViewStylePlain];
    comTableView.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    comTableView.dataSource = self;
    comTableView.delegate  = self;
    comTableView.rowHeight = 230;
    comTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [sc addSubview:comTableView];
    
    UIButton *comNextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    comNextBtn.tag = 302;
   
    [comNextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [comNextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [comNextBtn setFrame:CGRectMake(20, comTableView.mj_h + comTableView.mj_y + 10, self.view.mj_w - 40, 30)];
    comNextBtn.layer.masksToBounds = YES;
    comNextBtn.layer.cornerRadius = 4;
    comNextBtn.layer.borderWidth = 1;
    comNextBtn.tintColor = GREENCOLOR;
    comNextBtn.layer.borderColor = GREENCOLOR.CGColor;
    comNextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.comNextBtn = comNextBtn;
    [sc addSubview:comNextBtn];
    
    sc.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    sc.userInteractionEnabled = YES;
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 350);
    self.sc = sc;
    [self.view addSubview:sc];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoModelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CareerTableViewCell *cell = [CareerTableViewCell cellWithTableView:tableView];
    informationModel *model = [self.infoModelArr objectAtIndex:indexPath.row];
    cell.proviceText.text = model.provinceName;
    cell.cityText.text = model.cityName;
    cell.sectionText.text = model.organizationName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    NSLog(@"%@",model.strID);
    if ([model.workStartDate isEqualToString:@""]||[model.workStartDate isEqualToString:@"(null)"]|| !model.workStartDate)
    {
        cell.dateText1.text = @"";
    }
    else
    {
        NSArray *arr1 = [model.workStartDate componentsSeparatedByString:@" "];
        cell.dateText1.text = arr1[0];
    }
    
    if ([model.workEndDate isEqualToString:@""]||[model.workEndDate isEqualToString:@"(null)"]|| !model.workEndDate)
    {
        cell.dateText2.text = @"";
    }
    else
    {
        NSArray *arr2 = [model.workEndDate componentsSeparatedByString:@" "];
        cell.dateText2.text = arr2[0];
    }
    
    cell.branchText.text = model.position;
    cell.addBtn.tag = indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.delBtn.tag = indexPath.row;
    [cell.delBtn addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.infoModel = model;
    
    return cell;
    
}

- (void)addButtonAction:(UIButton *)sender
{
    WEAKSELF;
    informationModel *models = [self.infoModelArr objectAtIndex:sender.tag];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:models.provinceId forKey:@"provinceId"];
    [dic setObject:models.provinceName forKey:@"provinceName"];
    [dic setObject:models.cityId forKey:@"cityId"];
    [dic setObject:models.cityName forKey:@"cityName"];
    [dic setObject:models.organizationName forKey:@"organizationName"];
    [dic setObject:models.workStartDate forKey:@"workStartDate"];
    [dic setObject:models.workEndDate forKey:@"workEndDate"];
    [dic setObject:models.position forKey:@"position"];
    
    if (!models.strID || [models.strID isEqualToString:@""])
    {
        [dic setObject:models.workStartDate forKey:@"workStartDate"];
        [dic setObject:models.workEndDate forKey:@"workEndDate"];
        [dic setObject:DEF_USERID forKey:@"createBy"];
        [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYZHIYEXX params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed) {
//                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    
                    models.strID = result[@"id"];
                    NSLog(@"%@",models.strID);
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.provinceId = @"";
                    model.provinceName = @"";
                    model.cityId = @"";
                    model.cityName = @"";
                    model.organizationName = @"";
                    model.workStartDate = @"";
                    model.workEndDate = @"";
                    model.position = @"";
                    [weakSelf.infoModelArr addObject:model];
                    [comTableView reloadData];
                }
            }
            else
            {
                showAlertView(@"添加失败");
            }
        }];
        
    }
    else
    {
        [dic setObject:models.strID forKey:@"id"];
        NSArray *arr1 = [models.workStartDate componentsSeparatedByString:@" "];
        NSArray *arr2 = [models.workEndDate componentsSeparatedByString:@" "];
        [dic setObject:arr1[0] forKey:@"workStartDate"];
        [dic setObject:arr2[0] forKey:@"workEndDate"];
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYZHIYEXX params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed)
            {
                if (sender.tag < weakSelf.infoModelArr.count - 1)
                {
                    [weakSelf.infoModelArr removeObjectAtIndex:sender.tag];
                    [weakSelf.infoModelArr insertObject:models atIndex:sender.tag];
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
                else
                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.provinceId = @"";
                    model.provinceName = @"";
                    model.cityId = @"";
                    model.cityName = @"";
                    model.organizationName = @"";
                    model.workStartDate = @"";
                    model.workEndDate = @"";
                    model.position = @"";
                    [weakSelf.infoModelArr addObject:model];
                    [comTableView reloadData];
                }
            }
        }];
        
        
    }
    
}

- (void)delButtonAction:(UIButton *)sender
{
    WEAKSELF;
    informationModel *models = [self.infoModelArr objectAtIndex:sender.tag];
    if (models.strID && ![models.strID isEqualToString:@""]) {
        [[HttpManager defaultManager] postRequestToUrl:DEF_DELZYZHIYEXX params:@{@"id":models.strID} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
//                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                if (weakSelf.infoModelArr.count > 1)
                {
                    
                    [weakSelf.infoModelArr removeObjectAtIndex:sender.tag];
                    [comTableView reloadData];
                    
                }
                else
                {
                    [weakSelf.infoModelArr removeAllObjects];
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.provinceId = @"";
                    model.provinceName = @"";
                    model.cityId = @"";
                    model.cityName = @"";
                    model.organizationName = @"";
                    model.workStartDate = @"";
                    model.workEndDate = @"";
                    model.position = @"";
                    [weakSelf.infoModelArr addObject:model];
                    [comTableView reloadData];
                }
                
            }
            else
            {
                showAlertView(@"删除失败");
            }
        }];
    }
    
}

/**
 * 提交
 */
- (void)nextBtnAction:(UIButton *)sender
{
    WEAKSELF;
    informationModel *models = [self.infoModelArr lastObject];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:models.provinceId forKey:@"provinceId"];
    [dic setObject:models.provinceName forKey:@"provinceName"];
    [dic setObject:models.cityId forKey:@"cityId"];
    [dic setObject:models.cityName forKey:@"cityName"];
    [dic setObject:models.organizationName forKey:@"organizationName"];
    
    [dic setObject:models.position forKey:@"position"];
    if ([models.strID isEqualToString:@""] || !models.strID)
    {
        [dic setObject:DEF_USERID forKey:@"createBy"];
        [dic setObject:models.workStartDate forKey:@"workStartDate"];
        [dic setObject:models.workEndDate forKey:@"workEndDate"];
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYZHIYEXX params:dic complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    models.strID = result[@"id"];
                    NSLog(@"%@",models.strID);
                    [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    [comTableView reloadData];
                }
                else
                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
            else
            {
                showAlertView(@"提交失败");
            }
        }];
    }
    else
    {
        [dic setObject:models.strID forKey:@"id"];
        NSArray *arr1 = [models.workStartDate componentsSeparatedByString:@" "];
        NSArray *arr2 = [models.workEndDate componentsSeparatedByString:@" "];
        [dic setObject:arr1[0] forKey:@"workStartDate"];
        [dic setObject:arr2[0] forKey:@"workEndDate"];
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYZHIYEXX params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed)
            {
//                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    if (sender.tag < weakSelf.infoModelArr.count - 1)
                    {
                        [weakSelf.infoModelArr removeObjectAtIndex:sender.tag];
                        [weakSelf.infoModelArr insertObject:models atIndex:sender.tag];
                    }
                    else
                    {
                        
                    }
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
            
        }];
        
        
    }
}



- (void)keyboardShow:(NSNotification *)not
{
    
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
    if (ff.height < self.scHeight + keyboardH) {
        ff.height += keyboardH;
        self.sc.contentSize = ff;
        //        CGPoint position = CGPointMake(0, keyboardH);
        //        [self.sc setContentOffset:position animated:YES];
    }
    
}
- (void)keyboardHide:(NSNotification *)not
{
    
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
    ff.height -= keyboardH;
    self.sc.contentSize = ff;
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
