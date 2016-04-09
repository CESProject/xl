//
//  SearchActiviteView.m
//  Creative
//
//  Created by Mr Wei on 16/2/24.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "SearchActiviteView.h"
//#import "SelectCell.h"
#import "SelectCellTwo.h"
#import "ListCell.h"

@interface SearchActiviteView ()<UITextFieldDelegate>
{
    UITableView *listTable;
    UIView *leftView1;
    int YnFirst;
}

@property(nonatomic,strong)NSMutableArray *arrTransmit;
@property(nonatomic,strong)NSMutableDictionary *dicCheck;

@property(nonatomic,strong)NSMutableArray *arrTransmitfre;
@property(nonatomic,strong)NSMutableDictionary *dicCheckfre;

@property(nonatomic,strong)NSMutableArray *arrTransmitPl;
@property(nonatomic,strong)NSMutableDictionary *dicCheckpl;

@property(nonatomic,strong)UIView *datePut;
@property(nonatomic,strong)UIView *datePut1;

@property(nonatomic,strong)NSArray *arrDataS;
@property(nonatomic,strong)UIView *picker;
@property(nonatomic,strong)UIPickerView *pick;
@property(nonatomic,copy)NSString *strPicker;
@property(nonatomic,copy)NSString *formatterDate;
@property(nonatomic,copy)NSString *formatterDate1;

@end

@implementation SearchActiviteView

- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
//        _leftTableView.backgroundColor = [UIColor grayColor];
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

- (UIView *)datePut
{
    if (!_datePut)
    {
        _datePut = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h)];
//        _datePut.backgroundColor = [UIColor orangeColor];

        UITextField *tex = [[UITextField alloc]initWithFrame:CGRectMake(10,10, _datePut.frame.size.width - 60,30)];
        tex.borderStyle = UITextBorderStyleRoundedRect;
        tex.delegate = self;
        tex.tag = 101;
         tex.placeholder = @"请选择开始时间";
        [_datePut addSubview:tex];
        self.textField = tex;
        
        UIDatePicker *dat = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,50, _datePut.frame.size.width - 40, _datePut.frame.size.height - 40)];
        dat.datePickerMode = UIDatePickerModeDate;
        [dat addTarget:self action:@selector(datePick:) forControlEvents:UIControlEventValueChanged];
        [_datePut addSubview:dat];
    }
    return _datePut;
}

- (UIView *)datePut1
{
    if (!_datePut1)
    {
        _datePut1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftView1.mj_w , leftView1.mj_h)];
        //        _datePut.backgroundColor = [UIColor orangeColor];
        
        UITextField *tex = [[UITextField alloc]initWithFrame:CGRectMake(10,10, _datePut1.frame.size.width - 60,30)];
        tex.borderStyle = UITextBorderStyleRoundedRect;
        tex.delegate = self;
        tex.tag = 101;
        tex.placeholder = @"请选择结束时间";
        [_datePut1 addSubview:tex];
        self.textField1 = tex;
        
        UIDatePicker *dat = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,50, _datePut1.frame.size.width - 40, _datePut1.frame.size.height - 40)];
        dat.datePickerMode = UIDatePickerModeDate;
        [dat addTarget:self action:@selector(datePick1:) forControlEvents:UIControlEventValueChanged];
        [_datePut1 addSubview:dat];
    }
    return _datePut1;
}
- (void)datePick:(id)pick
{
    UIDatePicker *pc = (UIDatePicker *)pick;
    NSDate *da = pc.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    self.formatterDate = [formatter stringFromDate:da];
    self.textField.text = self.formatterDate;
    [listTable reloadData];
    [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
    [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];//实现点击第一行所调用的方法
}

- (void)datePick1:(id)pick
{
    UIDatePicker *pc = (UIDatePicker *)pick;
    NSDate *da = pc.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    self.formatterDate1 = [formatter stringFromDate:da];
    self.textField1.text = self.formatterDate1;
    
    [listTable reloadData];
    [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
    [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];//实现点击第一行所调用的方法
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAddSubviews];
        self.arrTransmit = [NSMutableArray array];
        self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.typeArr];
        
        self.arrTransmitPl = [NSMutableArray array];
        self.dicCheckpl = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO"] forKeys:self.timeArr];
        
        self.arrTransmitfre = [NSMutableArray array];
        self.dicCheckfre = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO"] forKeys:self.isfreeArr];
        
        self.selectCityArr = [NSMutableArray array];
        self.selectCityCodeArr = [NSMutableArray array];
        self.typeStr = @"";
        self.timeStr = @"";
        self.freeStr = @"";
        self.textField.text = @"";
        self.textField1.text = @"";
        YnFirst = 0;
        
    }
    return self;
}

- (void)createAddSubviews
{
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
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
    YnFirst = 0;
    self.typeStr = @"";
    self.timeStr = @"";
    self.freeStr = @"";
    self.textField.text = @"";
    self.textField1.text = @"";
    
    [self.arrTransmit removeAllObjects];
    self.dicCheck = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO"] forKeys:self.typeArr];
    [self.leftTableView reloadData];
    
    [self.arrTransmitfre removeAllObjects];
    self.dicCheckfre = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO"] forKeys:self.isfreeArr];
    [self.mytableview reloadData];
    
    [self.arrTransmitPl removeAllObjects];
    self.dicCheckpl = [[NSMutableDictionary alloc]initWithObjects:@[@"YES",@"NO",@"NO",@"NO",@"NO"] forKeys:self.timeArr];
    
    [self.timeTableview reloadData];
    
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
    if ([tableView isEqual:listTable])
    {
//        return 3; // 选择时间
        return 4;
    }
    else if([tableView isEqual:self.leftTableView])
    {
        return self.typeArr.count;
    }
    else if([tableView isEqual:self.mytableview])
    {
        return self.isfreeArr.count;
    }
    else
    {
//        return self.timeArr.count;
        return 0;
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
//            [self.timeTableview removeFromSuperview];

            [self.datePut1 removeFromSuperview];
            [self.datePut removeFromSuperview];
            
            [leftView1 addSubview:self.leftTableView];
            [self.leftTableView reloadData];
            
        }
        else if (indexPath.row == 1)
        {
            YnFirst = 2;
            [self.leftTableView removeFromSuperview];
//            [self.timeTableview removeFromSuperview];

            [self.datePut1 removeFromSuperview];
            [self.datePut removeFromSuperview];

            [leftView1 addSubview:self.mytableview];
            [self.mytableview reloadData];
            
        }
        else if (indexPath.row == 2)
        {
            YnFirst = 3;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            
//            [leftView1 addSubview:self.timeTableview];
//            [self.timeTableview reloadData];   // 选择时间
            [self.datePut1 removeFromSuperview];
            [leftView1 addSubview:self.datePut];
        }
        else
        {
            YnFirst = 4;
            [self.leftTableView removeFromSuperview];
            [self.mytableview removeFromSuperview];
            //            [leftView1 addSubview:self.timeTableview];
            //            [self.timeTableview reloadData];   // 选择时间
            
            [self.datePut removeFromSuperview];
            [leftView1 addSubview:self.datePut1];
        }
    }
    else if([tableView isEqual:self.leftTableView])
    {
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            
            [self.arrTransmit removeAllObjects];
            for (int i = 0; i < self.typeArr.count; i ++)
            {
                if ([self.dicCheck[[NSString stringWithFormat:@"%@",self.typeArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheck[[NSString stringWithFormat:@"%@",self.typeArr[i]]] = @"NO";
                }
            }
            
            self.dicCheck[[NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmit addObject:self.typeArr[indexPath.row]];
            self.typeStr = [NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]];
            [self.leftTableView reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.typeStr = @"";
            [self.arrTransmit removeAllObjects];
            [self.dicCheck setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.leftTableView reloadData];
            [listTable reloadData];
        }

    }
    else if([tableView isEqual:self.mytableview])
    {
        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.dicCheckfre objectForKey:[NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]]] isEqualToString:@"NO"])
        {
            
            [self.arrTransmitfre removeAllObjects];
            for (int i = 0; i < self.isfreeArr.count; i ++)
            {
                if ([self.dicCheckfre[[NSString stringWithFormat:@"%@",self.isfreeArr[i]]]isEqualToString:@"YES"]) {
                    self.dicCheckfre[[NSString stringWithFormat:@"%@",self.isfreeArr[i]]] = @"NO";
                }
            }
            
            self.dicCheckfre[[NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]]] = @"YES";
            [cell setChecked:YES];
            [self.arrTransmitfre addObject:self.isfreeArr[indexPath.row]];
            self.freeStr = [NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]];
            [self.mytableview reloadData];
            [listTable reloadData];
            
        }
        else
        {
            self.freeStr = @"";
            [self.arrTransmitfre removeAllObjects];
            [self.dicCheckfre setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]]];
            [cell setChecked:NO];
            [self.mytableview reloadData];
            [listTable reloadData];
        }

    }
    else
    {
         // 选择时间
//        SelectCellTwo *cell = (SelectCellTwo *)[tableView cellForRowAtIndexPath:indexPath];
//        
//        if ([[self.dicCheckpl objectForKey:[NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]]] isEqualToString:@"NO"])
//        {
//            
//            [self.arrTransmitPl removeAllObjects];
//            for (int i = 0; i < self.timeArr.count; i ++)
//            {
//                if ([self.dicCheckpl[[NSString stringWithFormat:@"%@",self.timeArr[i]]]isEqualToString:@"YES"]) {
//                    self.dicCheckpl[[NSString stringWithFormat:@"%@",self.timeArr[i]]] = @"NO";
//                }
//            }
//            
//            self.dicCheckpl[[NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]]] = @"YES";
//            [cell setChecked:YES];
//            [self.arrTransmitPl addObject:self.timeArr[indexPath.row]];
//            self.timeStr = [NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]];
//            [self.timeTableview reloadData];
//            [listTable reloadData];
//            
//        }
//        else
//        {
//            self.timeStr = @"";
//            [self.arrTransmitPl removeAllObjects];
//            [self.dicCheckpl setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]]];
//            [cell setChecked:NO];
//            [self.timeTableview reloadData];
//            [listTable reloadData];
//        }
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
                                 [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
            }
            else if (YnFirst == 3)
            {
                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];//实现点击第一行所调用的方法
            }
//            else
//            {
//                [listTable selectRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
//                //                [self tableView:listTable didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];//实现点击第一行所调用的方法
//            }
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
            cell.lblName.text = @"分 类";
        }
        else if (indexPath.row == 1)
        {
            if (!self.arrTransmitfre.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                if ([[self.arrTransmitfre lastObject] isEqualToString:@"全部"])
                {
                    [cell setChecked:NO];
                }
                else
                {
                [cell setChecked:YES];
                }
            }
            cell.lblName.text = @"费 用";
        }
        else if(indexPath.row == 2)
        {
            if (!self.textField.text || [self.textField.text isEqualToString:@""])
//                (!self.arrTransmitPl.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                [cell setChecked:YES];
            }
            cell.lblName.text = @"开始时间";
        }
        else
        {
            if (!self.textField1.text || [self.textField1.text isEqualToString:@""])
//                (!self.arrTransmitPl.count)
            {
                [cell setChecked:NO];
            }
            else
            {
                [cell setChecked:YES];
            }
            cell.lblName.text = @"结束时间";
        }
        
        return cell;
    }
    else if([tableView isEqual:self.leftTableView])
    {
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.typeArr[indexPath.row];
        
        if ([[self.dicCheck objectForKey:[NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheck[[NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmit addObject:self.typeArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheck[[NSString stringWithFormat:@"%@",self.typeArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else if([tableView isEqual:self.mytableview])
    {
        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
        celll.lblName.text = self.isfreeArr[indexPath.row];
        
        if ([[self.dicCheckfre objectForKey:[NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]]] isEqualToString:@"YES"]) {
            self.dicCheckfre[[NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]]] = @"YES";
            [celll setChecked:YES];
            [self.arrTransmitfre addObject:self.isfreeArr[indexPath.row]];
            
        }
        else
        {
            self.dicCheckfre[[NSString stringWithFormat:@"%@",self.isfreeArr[indexPath.row]]] = @"NO";
            [celll setChecked:NO];
            
        }
        
        return celll;
    }
    else
    {
         // 选择时间
//        SelectCellTwo *celll = [SelectCellTwo cellWithTabelView:tableView];
//        celll.lblName.text = self.timeArr[indexPath.row];
//        
//        
//        if ([[self.dicCheckpl objectForKey:[NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]]] isEqualToString:@"YES"]) {
//            self.dicCheckpl[[NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]]] = @"YES";
//            [celll setChecked:YES];
//            [self.arrTransmitPl addObject:self.timeArr[indexPath.row]];
//            
//        }
//        else
//        {
//            self.dicCheckpl[[NSString stringWithFormat:@"%@",self.timeArr[indexPath.row]]] = @"NO";
//            [celll setChecked:NO];
//            
//        }
//
//        return celll;

        return nil;
    }
    
}

- (NSArray *)typeArr
{
    if (!_typeArr) {
        _typeArr = @[@"全部",@"大赛",@"座谈会",@"培训会",@"户外活动",@"其他",@"路演"];
        //        0:大赛；1：座谈会；2：培训会；3：户外活动；4：其他；5：路演
    }
    return _typeArr;
}
- (NSArray *)timeArr
{
    if (!_timeArr) {
        _timeArr = @[@"全部",@"今天",@"近三天",@"近一周",@"近一个月"];
        //        1：今天 2：近三天 3：近一周 4： 近一个月
    }
    return _timeArr;
}

- (NSArray *)isfreeArr
{
    if (!_isfreeArr) {
        _isfreeArr = @[@"全部",@"免费",@"收费"];

    }
    return _isfreeArr;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 101 || textField.tag == 102)
    {
        
        textField.inputView = [[UIView alloc]init];
    }
    return YES;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
