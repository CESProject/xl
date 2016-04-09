//
//  EducationViewController.m
//  Creative
//
//  Created by huahongbo on 15/12/28.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "EducationViewController.h"
#import "EducateTableViewCell.h"
#import "informationModel.h"

#import "GrowUpViewController.h"

@interface EducationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}

@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,assign)CGFloat scHeight;

@property (nonatomic , strong) NSMutableArray *modelArr;
@property (nonatomic , strong) NSMutableArray *infoModelArr;
@property (nonatomic , strong) NSArray *schoolArr;
@property (nonatomic , strong) UIButton *comNextBtn;

@end

@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"教育信息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(nextBtnAction:) withTitle:@"提交"];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    [self loadServeData];
}

- (void)initView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h - 64 )];
    sc.backgroundColor = [UIColor whiteColor];
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h - 150) style:UITableViewStylePlain];
    myTableView.rowHeight = 200;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [sc addSubview:myTableView];
    
    UIButton *comNextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    comNextBtn.tag = 302;
    if (self.passNum == 1) {
        [comNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [comNextBtn addTarget:self action:@selector(passBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    sc.contentSize = CGSizeMake(0,self.view.mj_h + self.view.mj_y);
    self.sc = sc;
}

- (void)loadServeData
{
    WEAKSELF;
    self.infoModelArr = [NSMutableArray array];
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZYJIAOYUJL params:@{@"createBy":DEF_USERID } complete:^(BOOL successed, NSDictionary *result)
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
                     informationModel *imodel = [informationModel objectWithKeyValues:dic];
                     [weakSelf.infoModelArr  addObject:imodel];
                 }
             }
             else
             {
                 NSLog(@"%ld",weakSelf.infoModelArr.count);
                 if (weakSelf.infoModelArr.count == 0) {
                     weakSelf.infoModelArr = [NSMutableArray array];
                     informationModel *inmodel = [informationModel new];
                     inmodel.strID = @"";
                     inmodel.schoolType = @"";
                     inmodel.schoolName = @"";
                     inmodel.entranceYear = @"";
                     inmodel.academyName = @"";
                     [weakSelf.infoModelArr addObject:inmodel];
                 }
             }
             
         }
         [weakSelf initView];
         NSLog(@"%@",result);
     }];
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
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EducateTableViewCell *cell = [EducateTableViewCell cellWithTableView:tableView];
    informationModel *model = [self.infoModelArr objectAtIndex:indexPath.row];
    
    cell.schoolnameText.text = model.schoolName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([model.schoolType isEqualToString:@""] ||!model.schoolType) {
        cell.schooltypeText.text = @"";
    }
    else
    {
        if (self.schoolArr.count - 1 < model.schoolType.intValue) {
            cell.schooltypeText.text = self.schoolArr[5];
        }
        else
        {
         cell.schooltypeText.text = self.schoolArr[model.schoolType.intValue];
        }
    }
    
    cell.sectionText.text = model.academyName;
    cell.dateText1.text = model.entranceYear;
    cell.addBtn.tag = indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.delBtn.tag = indexPath.row;
    [cell.delBtn addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.infmodelcell = model;
    return cell;
}

- (void)addButtonAction:(UIButton *)sender
{
    WEAKSELF;
    informationModel *models = [self.infoModelArr objectAtIndex:sender.tag];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:models.schoolType forKey:@"schoolType"];
    [dic setObject:models.schoolName forKey:@"schoolName"];
    [dic setObject:models.entranceYear forKey:@"entranceYear"];
    [dic setObject:models.academyName forKey:@"academyName"];
    if (!models.strID || [models.strID isEqualToString:@""])
    {
        [dic setObject:DEF_USERID forKey:@"createBy"];
        [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYJIAOYUJL params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed) {
                
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    models.strID = result[@"id"];
                    NSLog(@"%@",models.strID);
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.schoolType = @"";
                    model.schoolName = @"";
                    model.entranceYear = @"";
                    model.academyName = @"";
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
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYJIAOYUJL params:dic complete:^(BOOL successed, NSDictionary *result) {
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
                    model.schoolType = @"";
                    model.schoolName = @"";
                    model.entranceYear = @"";
                    model.academyName = @"";
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
        [[HttpManager defaultManager] postRequestToUrl:DEF_DELZYJIAOYUJL params:@{@"id":models.strID} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
//                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                if (self.infoModelArr.count > 1)
                {
                    
                    [weakSelf.infoModelArr removeObjectAtIndex:sender.tag];
                    [myTableView reloadData];
                    
                }
                else
                {
                    [weakSelf.infoModelArr removeAllObjects];
                    informationModel *model = [informationModel new];
                    model.strID = @"";
                    model.schoolType = @"";
                    model.schoolName = @"";
                    model.entranceYear = @"";
                    model.academyName = @"";
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
    [dic setObject:models.schoolType forKey:@"schoolType"];
    [dic setObject:models.schoolName forKey:@"schoolName"];
    [dic setObject:models.entranceYear forKey:@"entranceYear"];
    [dic setObject:models.academyName forKey:@"academyName"];
    if (!models.strID ||[models.strID isEqualToString:@""]) {
        
        NSLog(@"%@",dic);
        if ([models.strID isEqualToString:@""] || !models.strID)
        {
            [dic setObject:DEF_USERID forKey:@"createBy"];
            [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYJIAOYUJL params:dic complete:^(BOOL successed, NSDictionary *result) {
                if (successed)
                {
                    if ([result[@"code"] isEqualToString:@"10000"] ) {
                        models.strID = result[@"id"];
                            [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                            [self.navigationController popViewControllerAnimated:YES];
                        [myTableView reloadData];
                    }
                    else
                    {
                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                    }
                }
                else
                {
                    showAlertView(@"提交失败");
                }
            }];
        }
    }
    else
    {
        [dic setObject:models.strID forKey:@"id"];
        
        [[HttpManager defaultManager]postRequestToUrl:DEF_UPDATEZYJIAOYUJL params:dic complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed)
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                if (sender.tag < weakSelf.infoModelArr.count - 1)
                {
                    [weakSelf.infoModelArr removeObjectAtIndex:sender.tag];
                    [weakSelf.infoModelArr insertObject:models atIndex:sender.tag];
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }else
                {
                    
                }
                
            }
        }];
        
        
    }
    
}


- (void)passBtnAction:(UIButton *)sender
{
    WEAKSELF;
    int i = 0;
    for (informationModel *models in self.infoModelArr)
    {
        i ++;
        if ([models.schoolType isEqualToString:@""]||[models.schoolName isEqualToString:@""]||[models.entranceYear isEqualToString:@""]||[models.academyName isEqualToString:@""])
        {
            if (i == self.infoModelArr.count)
            {
                showAlertView(@"请完善教育信息");
            }
        }
        else
        {
//            informationModel *models = [self.infoModelArr lastObject];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:models.schoolType forKey:@"schoolType"];
            [dic setObject:models.schoolName forKey:@"schoolName"];
            [dic setObject:models.entranceYear forKey:@"entranceYear"];
            [dic setObject:models.academyName forKey:@"academyName"];
            if (!models.strID ||[models.strID isEqualToString:@""]) {
                
                NSLog(@"%@",dic);
                
                    [dic setObject:DEF_USERID forKey:@"createBy"];
                    [[HttpManager defaultManager]postRequestToUrl:DEF_ADDZYJIAOYUJL params:dic complete:^(BOOL successed, NSDictionary *result) {
                        if (successed)
                        {
                            if ([result[@"code"] isEqualToString:@"10000"] ) {
                                models.strID = result[@"id"];

                                GrowUpViewController *gropVc = [[GrowUpViewController alloc]init];
                                gropVc.passNum = 1;
                                [weakSelf.navigationController pushViewController:gropVc animated:YES];
                                [myTableView reloadData];
                                
                            }
                            else
                            {
//                                [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                            }
                        }
                        else
                        {
                            showAlertView(@"提交失败");
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
//                        if (i - 1 < weakSelf.infoModelArr.count - 1)
//                        {
                            [weakSelf.infoModelArr removeObjectAtIndex:i - 1];
                            [weakSelf.infoModelArr insertObject:models atIndex:i - 1];
//                            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                            GrowUpViewController *groVc = [[GrowUpViewController alloc]init];
                            groVc.passNum = 1;
                            [weakSelf.navigationController pushViewController:groVc animated:YES];
//                        }
//                        else
//                        {
//                            
//                        }
                    }
                }];
                
                break;
            }
  
        }
    }
   
    
}
- (NSArray *)schoolArr
{
    if (!_schoolArr) {
        _schoolArr = @[@"大学",@"大专",@"高中",@"初中",@"小学",@"其他"];
        //        0：大学；1：大专；2：高中；3：初中；4：小学；5其他
    }
    return _schoolArr;
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
