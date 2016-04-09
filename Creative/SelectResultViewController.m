//
//  SelectResultViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/25.
//  Copyright © 2016年 王文静. All rights reserved.
//
#define BUTTONWIDTH (DEF_SCREEN_WIDTH-40)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-40)/11
#import "SelectResultViewController.h"
#import "MainTableViewCell.h"
#import "Result.h"
#import "ThreeDetailViewController.h"
#import "ProjectTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "ProjectTendViewController.h"
#import "PartnerViewController.h"
#import "ActiveTableViewCell.h"
#import "ActiveDeatailViewController.h"
#import "PlaceTableViewCell.h"
#import "ForPlaDetailViewController.h"
#import "TeacherTableViewCell.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "MoneyTableViewCell.h"
#import "MoneyModel.h"
#import "ForMoeDetailViewController.h"
@interface SelectResultViewController ()<UITableViewDelegate,UITableViewDataSource,TeacherTableViewCellDelegate>
{
}

@end

@implementation SelectResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索结果";
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"back"];
    self.navigationItem.leftBarButtonItems = @[back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    self.tableview = tableview;
    
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.separatorColor = DEF_RGB_COLOR(222, 222, 222);
    [self.view addSubview:tableview];
    [self addHeadView];

}
- (UIView *)addHeadView
{
    if (!self.tableview.tableHeaderView)
    {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, BUTTONHEIGHT+20);
        view.backgroundColor =DEF_RGB_COLOR(247, 247, 247);
        [self.view addSubview:view];
        
        for (int i=0; i<self.titleArr.count; i++)
        {
            UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [Btn setTitle:self.titleArr[i] forState:UIControlStateNormal];//设置title
            [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            Btn.tag = i;
            [Btn setFrame:CGRectMake(10 +(i%3)*(BUTTONWIDTH + 10), 10, BUTTONWIDTH, BUTTONHEIGHT)];
            Btn.layer.borderColor = [UIColor grayColor].CGColor;
            Btn.layer.borderWidth = 1.0f;
            Btn.layer.cornerRadius = 5;
            Btn.layer.masksToBounds = YES;
            [Btn setBackgroundColor:[UIColor whiteColor]];
            [view addSubview:Btn];
        }
        self.tableview.tableHeaderView = view;
}
    
    return self.tableview.tableHeaderView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellNumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.resUrl isEqualToString:DEF_LUYANGJZSEARCH])
    {
        MainTableViewCell *cell = [MainTableViewCell cellWithTabelView:tableView];
        ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
        cell.titleLab.text = listF.name;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        cell.classLab.text =[common checkStrValue:listF.typeName] ;
        cell.detailLab.text = listF.briefDescription;
        if (listF.praiseCount!=0)
        {
            cell.praiseNumLab.text = [NSString stringWithFormat:@"%d",listF.praiseCount];
            [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        }else
        {
            cell.praiseNumLab.text =@"";
            [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
        }
        return cell;
    }else if ([self.resUrl isEqualToString:DEF_PROJECTLIST])
    {
        ProjectTableViewCell *cell = [ProjectTableViewCell cellWithTabelView:tableView];
        ListFriend *listF = self.cellNumArr[indexPath.row];
        cell.titleLab.text = listF.name;
        cell.classLab.text = listF.peName;
        cell.domainLab.text =listF.typeName;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        return cell;
    }else if ([self.resUrl isEqualToString:DEF_ACTIVE])
    {
        ActiveTableViewCell *cell = [ActiveTableViewCell cellWithTabelView:tableView];
        ListFriend *activeM = [self.cellNumArr objectAtIndex:indexPath.row];
        cell.titleLab.text = activeM.theme;
        cell.dateLab.text = [common sectionStrByCreateTime:activeM.createDate];
        cell.addressLab.text = activeM.address;
        cell.unitLab.text = activeM.sponsor;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:activeM.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        return cell;
    }else if ([self.resUrl isEqualToString:DEF_ZHAOPLACE])
    {
        PlaceTableViewCell *cell = [PlaceTableViewCell cellWithTabelView:tableView];
        ListFriend *listModel = [self.cellNumArr objectAtIndex:indexPath.row];
        cell.titleLab.text = listModel.name;
        cell.addressLab.text = listModel.address;
        if (listModel.image) {
            [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listModel.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        }
        return cell;
    }else if ([self.resUrl isEqualToString:DEF_ZDSGJZSEARCH])
    {
        TeacherTableViewCell *cell = [TeacherTableViewCell cellWithTabelView:tableView];
        cell.delegate = self;
        ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listF.imageUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
        cell.nameText.text = listF.userName;
        if (listF.isRelation==0) {
            [cell.addBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            [cell.addBtn setImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        }else
        {
            [cell.addBtn setTitle:@"关注  " forState:UIControlStateNormal];
            [cell.addBtn setImage:[UIImage imageNamed:@"gz"] forState:UIControlStateNormal];
        }
        
        return cell;
    }else if ([self.resUrl isEqualToString:DEF_ZZJGJZSEARCH])
    {
        MoneyTableViewCell *cell = [MoneyTableViewCell cellWithTabelView:tableView];
        MoneyContent *money=[MoneyContent objectWithKeyValues:[self.cellNumArr objectAtIndex:indexPath.row]];
        cell.titleLab.text = money.title;
        cell.dateLab.text = [common sectionStrByCreateTime:money.shelfDate];
        cell.moneyConLab.text = [NSString stringWithFormat:@"%d万",money.investmentAmount];
        cell.typeConLab.text = money.fundTypeName;
        NSMutableString *result = [NSMutableString string];
        for (InvestmentTradeList *inves in money.investmentTradeList)
        {
            [result appendFormat:@"%@ ",inves.name];
        }
        cell.guildConLab.text = result;
        return cell;
    }
    
    return nil;
}

- (void)deliverdDelier:(TeacherTableViewCell *)teachCell
{
    NSIndexPath *inde = [self.tableview indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
    if (listF.isRelation==0)
    {
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,listF.roadId];
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [teachCell.addBtn setTitle:@"关注  " forState:0];
                    listF.isRelation = 1;
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }else
    {
        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,listF.roadId];
        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [teachCell.addBtn setTitle:@"取消关注" forState:0];
                    listF.isRelation = 0;
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }
    
}
- (void)deliverSiXin:(TeacherTableViewCell *)teachCell
{
    NSIndexPath *inde = [self.tableview indexPathForCell:teachCell];
    ListFriend *listF=[self.cellNumArr objectAtIndex:inde.row];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.userInfoId = listF.roadId;
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.resUrl isEqualToString:DEF_LUYANGJZSEARCH])
    {
        return 90;
    }else if ([self.resUrl isEqualToString:DEF_PROJECTLIST])
    {
        return 91;
    }else if ([self.resUrl isEqualToString:DEF_ACTIVE])
    {
        return 121;
    }else if ([self.resUrl isEqualToString:DEF_ZHAOPLACE])
    {
        return 90;
    }else if ([self.resUrl isEqualToString:DEF_ZDSGJZSEARCH])
    {
        return 110;
    }
    else if ([self.resUrl isEqualToString:DEF_ZZJGJZSEARCH])
    {
        
        return 140;
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.resUrl isEqualToString:DEF_LUYANGJZSEARCH])
    {
        ThreeDetailViewController *three = [[ThreeDetailViewController alloc] init];
        three.listFriend = [self.cellNumArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:three animated:YES];
    }else if ([self.resUrl isEqualToString:DEF_PROJECTLIST])
    {
        ListFriend *listF = self.cellNumArr[indexPath.row];
        if ([listF.type isEqualToString:@"0"]) {
            // 投标
            ProjectTendViewController *prejectTendVC = [[ProjectTendViewController alloc]init];
            prejectTendVC.listFd = listF;
            [self.navigationController pushViewController:prejectTendVC animated:YES];
        }
        else if ([listF.type isEqualToString:@"1"])
        {
            // 合作
            PartnerViewController *partnerVc = [[PartnerViewController alloc]init];
            partnerVc.listFd = listF;
            [self.navigationController pushViewController:partnerVc animated:YES];
        }
        else
        {
            // 支持
            ProjectDetailViewController *projectVC = [[ProjectDetailViewController alloc]init];
            if ([listF.type isEqualToString:@"2"])
            {
                projectVC.YNtwo = YES;
            }
            else
            {
                projectVC.YNtwo = NO;
            }
            projectVC.listFried = listF;
            [self.navigationController pushViewController:projectVC animated:YES];
        }

    }else if ([self.resUrl isEqualToString:DEF_ACTIVE])
    {
        ActiveDeatailViewController *acthree = [[ActiveDeatailViewController alloc]init];
        ListFriend *activeM = [self.cellNumArr objectAtIndex:indexPath.row];
        acthree.listFriend = activeM;
        [self.navigationController pushViewController:acthree animated:YES];
    }else if ([self.resUrl isEqualToString:DEF_ZHAOPLACE])
    {
        ForPlaDetailViewController *placeVC = [[ForPlaDetailViewController alloc]init];
        placeVC.listFri = [self.cellNumArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:placeVC animated:YES];
    }else if ([self.resUrl isEqualToString:DEF_ZDSGJZSEARCH])
    {
        TeacherTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        MineViewController *mine = [[MineViewController alloc] init];
        ListFriend *listF=[self.cellNumArr objectAtIndex:indexPath.row];
        mine.listFriend = listF;
        mine.btnTit = cell.addBtn.currentTitle;
        [self.navigationController pushViewController:mine animated:YES];
    }else if ([self.resUrl isEqualToString:DEF_ZZJGJZSEARCH])
    {
        MoneyContent *money=[MoneyContent objectWithKeyValues:[self.cellNumArr objectAtIndex:indexPath.row]];
        ForMoeDetailViewController *moneVC = [[ForMoeDetailViewController alloc]init];
        moneVC.moneyCont = money;
        [self.navigationController pushViewController:moneVC animated:YES];
        
    }

    
}


- (void)backClick
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
