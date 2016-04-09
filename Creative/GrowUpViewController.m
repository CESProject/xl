//
//  GrowUpViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/28.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "GrowUpViewController.h"
#import "informationModel.h"
#import "EventTableViewCell.h"
#import "DateEventModel.h"

@interface GrowUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}

@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;
@property (nonatomic , strong) NSMutableArray *infoModelArr;
@property (nonatomic , strong) UIButton *comNextBtn;

@property (nonatomic , strong) NSMutableArray *modelArr;

@end

@implementation GrowUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"成长足迹";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(nextBtnAction:) withTitle:@"提交"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    [self loadServeData];
}

- (void)initView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h - 64 )];
    //    sc.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h - 150) style:UITableViewStylePlain];
    myTableView.rowHeight = 200;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [sc addSubview:myTableView];
    
    UIButton *comNextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    comNextBtn.tag = 302;
    if (self.passNum == 1)
    {
        [comNextBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [comNextBtn addTarget:self action:@selector(passApplyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [comNextBtn setTitle:@"提交" forState:UIControlStateNormal];
        [comNextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [comNextBtn setFrame:CGRectMake(20, myTableView.mj_h + myTableView.mj_y + 10, self.view.mj_w - 40, 30)];
    comNextBtn.layer.masksToBounds = YES;
    comNextBtn.layer.cornerRadius = 4;
    comNextBtn.layer.borderWidth = 1;
    comNextBtn.tintColor = GREENCOLOR;
    comNextBtn.layer.borderColor = GREENCOLOR.CGColor;
    comNextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.comNextBtn = comNextBtn;
    [sc addSubview:comNextBtn];
    
    [self.view addSubview:sc];
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y + 200);
    self.sc = sc;
}

- (void)loadServeData
{
    WEAKSELF;
    self.infoModelArr = [NSMutableArray array];
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZYCHENGZHANGZJ params:@{@"createBy":DEF_USERID } complete:^(BOOL successed, NSDictionary *result)
     {
         NSLog(@"%@",result);
         if (successed)
         {
//             [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
             NSMutableArray *arr = [NSMutableArray array];
             arr = [result[@"lists"][@"content"] mutableCopy];
             if (arr.count != 0)
             {
                 for (NSDictionary *dic in result[@"lists"][@"content"])
                 {
                     informationModel *imodel = [informationModel objectWithKeyValues:dic];
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
                     inmodel.footprintTime = @"";
                     inmodel.incident = @"";
                     [weakSelf.infoModelArr addObject:inmodel];
                 }
             }
             
         }
         [weakSelf initView];
         NSLog(@"%@",result);
     }];
}

- (void)passApplyBtnAction:(UIButton *)sender
{
    WEAKSELF;
    int i = 0;
    for (informationModel *models in self.infoModelArr)
    {
        i ++ ;
        if ([models.footprintTime isEqualToString:@""]||[models.incident isEqualToString:@""])
        {
            if (i == self.infoModelArr.count)
            {
                showAlertView(@"请完善成长足迹信息");
            }
        }
        else
        {
            //            informationModel *models = [self.infoModelArr lastObject];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:models.footprintTime forKey:@"footprintTime"];
            [dic setObject:models.incident forKey:@"incident"];
            if (!models.strID || [models.strID isEqualToString:@""])
            {
                [dic setObject:DEF_USERID forKey:@"createBy"];
                [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYCHENGZHANGZJ params:dic complete:^(BOOL successed, NSDictionary *result) {
                    //
                    if (successed) {
                        
                        if ([result[@"code"] isEqualToString:@"10000"])
                        {
                            models.strID = result[@"id"];
                            [myTableView reloadData];
                            
                            [[HttpManager defaultManager] postRequestToUrl:DEF_APPLYFOREXPERT params:nil complete:^(BOOL successed, NSDictionary *result) {
                                if ([result isKindOfClass:[NSDictionary class]]) {
                                    if ([result[@"code"] isEqualToString:@"10000"])
                                    {
//                                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                                        NSArray * ctrlArray = weakSelf.navigationController.viewControllers;
                                        if (ctrlArray.count > 4)
                                        {
                                            [weakSelf.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
                                        }
                                    }
                                    else if ([result[@"code"] isEqualToString:@"10001"])
                                    {
//                                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                                        if ([result[@"msg"] isEqualToString:@"此信息的状态无法修改"])
                                        {
                                            NSArray * ctrlArray = weakSelf.navigationController.viewControllers;
                                            if (ctrlArray.count > 4)
                                            {
                                                [weakSelf.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            }];
                            
                        }
                        else
                        {
//                            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        }
                        
                    }
                    else
                    {
                        showAlertView(@"添加失败");
                    }
                }];
                break;
                
            }
            else
            {
                [dic setObject:models.strID forKey:@"id"];
                
                [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYJIAOYUJL params:dic complete:^(BOOL successed, NSDictionary *result) {
                    //
                    if (successed)
                    {
                        if (i - 1 < weakSelf.infoModelArr.count - 1)
                        {
                            [weakSelf.infoModelArr removeObjectAtIndex:i - 1];
                            [weakSelf.infoModelArr insertObject:models atIndex:i - 1];
                            
                            [[HttpManager defaultManager] postRequestToUrl:DEF_APPLYFOREXPERT params:nil complete:^(BOOL successed, NSDictionary *result) {
                                if ([result isKindOfClass:[NSDictionary class]]) {
                                    if ([result[@"code"] isEqualToString:@"10000"])
                                    {
//                                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                                        
                                        NSArray * ctrlArray = weakSelf.navigationController.viewControllers;
                                        if (ctrlArray.count > 4)
                                        {
                                            [weakSelf.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
                                        }
                                    }
                                    else if ([result[@"code"] isEqualToString:@"10001"])
                                    {
//                                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                                        if ([result[@"msg"] isEqualToString:@"此信息的状态无法修改"])
                                        {
                                            NSArray * ctrlArray = weakSelf.navigationController.viewControllers;
                                            if (ctrlArray.count > 4)
                                            {
                                                [weakSelf.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
                                            }
                                        }
                                    }
                                }
                            }];
                        }
                        else
                        {
                            
                        }
                    }
                }];
                break;
                
            }
            
        }
        
    }
    /////////////////////
    
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTableViewCell *cell = [EventTableViewCell cellWithTableView:tableView];
    informationModel *model = [self.infoModelArr objectAtIndex:indexPath.row];
    cell.dateText.text = model.footprintTime;
    cell.eventText.text = model.incident;
    cell.addBtn.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [dic setObject:models.footprintTime forKey:@"footprintTime"];
    [dic setObject:models.incident forKey:@"incident"];
    if (!models.strID || [models.strID isEqualToString:@""])
    {
        [dic setObject:DEF_USERID forKey:@"createBy"];
        [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYCHENGZHANGZJ params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed) {
                
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    models.strID = result[@"id"];
                    NSLog(@"%@",models.strID);
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.footprintTime = @"";
                    model.incident = @"";
                    [weakSelf.infoModelArr addObject:model];
                    [myTableView reloadData];
                }
                else
                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
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
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYCHENGZHANGZJ params:dic complete:^(BOOL successed, NSDictionary *result) {
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
                    model.footprintTime = @"";
                    model.incident = @"";
                    [weakSelf.infoModelArr addObject:model];
                    [myTableView reloadData];
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
        [[HttpManager defaultManager] postRequestToUrl:DEF_DELZYCHENGZHANGZJ params:@{@"id":models.strID} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
//                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                if (weakSelf.infoModelArr.count > 1)
                {
                    
                    [weakSelf.infoModelArr removeObjectAtIndex:sender.tag];
                    [myTableView reloadData];
                    
                }
                else
                {
                    [weakSelf.infoModelArr removeAllObjects];
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.footprintTime = @"";
                    model.incident = @"";
                    [weakSelf.infoModelArr addObject:model];
                    [myTableView reloadData];
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
    [dic setObject:models.footprintTime forKey:@"footprintTime"];
    [dic setObject:models.incident forKey:@"incident"];
    if (!models.strID || [models.strID isEqualToString:@""])
    {
        [dic setObject:DEF_USERID forKey:@"createBy"];
        [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYCHENGZHANGZJ params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed) {
                
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    models.strID = result[@"id"];
                    NSLog(@"%@",models.strID);
                    [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    [myTableView reloadData];
                }
                else
                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
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
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYCHENGZHANGZJ params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed)
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    if (sender.tag < weakSelf.infoModelArr.count - 1)
                    {
                        [weakSelf.infoModelArr removeLastObject];
                        [weakSelf.infoModelArr addObject:models];
                        //                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        [myTableView reloadData];
                    }
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
                
            }
        }];
        
        
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
