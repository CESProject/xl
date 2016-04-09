//
//  LeftSortsViewController.m
//  Creative
//
//  Created by huahongbo on 15/12/28.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "EducationViewController.h"
#import "WaterLayout.h"
#import "LeftCell.h"
#import "TableCell.h"
#import "RoadshowViewController.h"
#import "ProjectViewController.h"
#import "MainViewController.h"
#import "ActiveViewController.h"
#import "SmallSecretaryViewController.h"
#import "ResourceViewController.h"
#import "PersonalCenterViewController.h"
#import "PersonalCenterViewController.h"
#import "PersonalDataViewController.h"
#import "LoginViewController.h"
#import "TheIncubatorViewController.h"
#import "ExperienceViewController.h"
#import "KnowledgeViewController.h"
#define CELLHEIGH (DEF_SCREEN_WIDTH*0.7-15)/2
@interface LeftSortsViewController ()<UITableViewDelegate,UITableViewDataSource,WaterLayoutDelegate>
{
    NSArray *heightarray;
    NSArray *colorarray;
    NSArray *imgarray;
    NSArray *namearray;
    NSArray *celltitArr;
    //记录当前选中的行
    int currentSeclectRow;
}
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    celltitArr =@[@"创新创业首页",@"创新创业教育",@"创新创业体验",@"创新创业孵化",@"个人信息中心"];
    UITableView *tableview = [[UITableView alloc] init];
    self.view.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.separatorColor = DEF_RGB_COLOR(255, 255, 255);
    [self.view addSubview:tableview];
    [self addHeadView];
    
    [self.tableview registerClass:[TableCell class] forCellReuseIdentifier:@"cell"];
}
- (void)addHeadView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH*0.7, DEF_SCREEN_WIDTH/2);
    view.backgroundColor =[UIColor blackColor];
    [self.view addSubview:view];
    
    UIButton *userImage = [UIButton buttonWithType:UIButtonTypeCustom];
    userImage.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2-15);
    userImage.bounds = CGRectMake(0, 0, view.frame.size.height/2, view.frame.size.height/2);
    userImage.layer.cornerRadius = userImage.frame.size.height/2;
    userImage.tag = 10086;
//    [userImage setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"http://192.168.16.7:8080%@",[MyUser userimageDiyBgVo]]] forState:0];
    userImage.clipsToBounds = YES;
    userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    userImage.layer.borderWidth = 3;
    [userImage addTarget: self action:@selector(openPersonal) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:userImage];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:userImage.frame];
    img.clipsToBounds = YES;
    img.layer.borderColor =[UIColor whiteColor].CGColor;
    img.layer.borderWidth = 3;
    img.layer.cornerRadius = userImage.frame.size.height/2;
//    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.16.7:8080/downloadFile/2015-11-17/image/dbdd144e-57d3-40ca-92fb-d16877f75adf-3062-min.jpg"]] placeholderImage:nil];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.16.7:8080%@",[MyUser userimageDiyBgVo]]] placeholderImage:[UIImage imageNamed:@"login (2)"]];
    [view addSubview:img];
    UILabel *la = [[UILabel alloc] init];
    la.center = CGPointMake(view.bounds.size.width/2, [userImage bottom]+30);
    la.bounds = CGRectMake(0, 0, 150, 20);
    la.text = [MyUser userLoginName];
    la.textAlignment = NSTextAlignmentCenter;
    la.font = [UIFont systemFontOfSize:19];
    la.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    la.textColor = DEF_RGB_COLOR(200, 200, 200);
    [view addSubview:la];
    
    self.tableview.tableHeaderView = view;
}
- (void)openPersonal
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    PersonalDataViewController *persVC = [[PersonalDataViewController alloc] init];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:persVC animated:NO];
}
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        WaterLayout *layout = [[WaterLayout alloc] init];
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,DEF_SCREEN_WIDTH*0.7, DEF_SCREEN_HEIGHT)collectionViewLayout:layout];
        cv.delegate   = self;
        cv.dataSource = self;
        
        [cv registerClass:[LeftCell class] forCellWithReuseIdentifier:@"Cell1"];
        cv.backgroundColor = [UIColor blackColor];
        [self.view addSubview:cv];
        
//        [cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
        
        heightarray = @[[NSNumber numberWithInt:CELLHEIGH],[NSNumber numberWithInt:CELLHEIGH],[NSNumber numberWithInt:CELLHEIGH],[NSNumber numberWithInt:(DEF_SCREEN_WIDTH*0.7/2-15)*2+20],[NSNumber numberWithInt:CELLHEIGH],[NSNumber numberWithInt:CELLHEIGH],[NSNumber numberWithInt:CELLHEIGH]];
        colorarray=@[DEF_RGB_COLOR(201,93,242),DEF_RGB_COLOR(99,157,234),DEF_RGB_COLOR(137,185,57),DEF_RGB_COLOR(150,151,44),DEF_RGB_COLOR(89,130,117),DEF_RGB_COLOR(203,120,56),DEF_RGB_COLOR(141,62,154)];
        namearray = @[@"路演厅",@"项目汇",@"活动邦",@"知识库",@"小秘书",@"资源库",@"孵化器"];
        
        [cv registerClass:[LeftCell class] forCellWithReuseIdentifier:@"Cell1"];
        
        cv.hidden = YES;
        self.collectionView = cv;
    }

    return _collectionView;
}
- (UIView *)bottonView
{
    if (!_bottonView)
    {
        UIView *botView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.frame.size.height-50, self.collectionView.frame.size.width, 50)];
        botView.backgroundColor = [UIColor grayColor];
        [self.collectionView addSubview:botView];
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        backImg.image = [UIImage imageNamed:@"back"];
        [botView addSubview:backImg];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake([backBtn right]+20, 5, 70, 40);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [botView addSubview:backBtn];
        botView.hidden = YES;
        self.bottonView = botView;
    }
    return _bottonView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return celltitArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    cell.titleLable.text = celltitArr[indexPath.row];
    cell.titleImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"a-%ld",indexPath.row+8]];

    //判断如果选中的是当前的行背景要显示出来，否则的话隐藏起来
    
    if (currentSeclectRow == indexPath.row)
    {
        cell.backgroundColor = [UIColor blackColor];
    }
    else
    {
        cell.backgroundColor = DEF_RGB_COLOR(43, 44, 43);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TableCell *cell = (TableCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    
    currentSeclectRow = (int)indexPath.row;
    if (indexPath.row == 0)
    {
        self.collectionView.hidden = YES;
        self.bottonView.hidden = YES;
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainViewController *mainVC = [[MainViewController alloc] init];

        [tempAppDelegate openLeftVC:mainVC];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//        [tempAppDelegate.mainNavigationController pushViewController:mainVC animated:NO];
    } else if (indexPath.row == 1)
    {
        [MBProgressHUD showSuccess:@"建设中..." toView:nil];
//        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        ActivityViewController *actVC = [[ActivityViewController alloc] init];
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//        [tempAppDelegate.mainNavigationController pushViewController:actVC animated:NO];
        
    } else if (indexPath.row == 2)
    {
        self.collectionView.hidden = YES;
        self.bottonView.hidden = YES;
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        ExperienceViewController *experienceViewController = [[ExperienceViewController alloc]init];
        [tempAppDelegate openLeftVC:experienceViewController];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        SearchViewController *searvc = [[SearchViewController alloc] init];
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//        [tempAppDelegate.mainNavigationController pushViewController:searvc animated:NO];
    } else if (indexPath.row == 3)
    {
        self.collectionView.hidden = NO;
        self.bottonView.hidden = NO;
    } else if (indexPath.row == 4)
    {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        PersonalCenterViewController *perVC = [[PersonalCenterViewController alloc] init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:perVC animated:NO];
    }else if (indexPath.row == 5)
    {
//        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////         LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [tempAppDelegate loginView];
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//        [tempAppDelegate.mainNavigationController pushViewController:loginVC animated:NO];
    }
    [tableView reloadData];
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return DEF_SCREEN_WIDTH/2;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}

/******************* collectionView *******************/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return heightarray.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LeftCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
    cell1.backgroundColor = [colorarray objectAtIndex:indexPath.row];
    cell1.nameLab.text = namearray[indexPath.item];
    cell1.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"b-%ld",(long)indexPath.item+1]];
    
    return cell1;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(DEF_SCREEN_WIDTH, 50);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            RoadshowViewController *roadVC = [[RoadshowViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:roadVC animated:NO];
        }
            break;
        case 1:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            ProjectViewController *proVC = [[ProjectViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:proVC animated:NO];
        }
            break;
        case 2:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            ActiveViewController *actVC = [[ActiveViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:actVC animated:NO];

        }   break;
        case 3:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            KnowledgeViewController *knowVC = [[KnowledgeViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:knowVC animated:NO];
        }
            break;
        case 4:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            SmallSecretaryViewController *smallVC = [[SmallSecretaryViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:smallVC animated:NO];

        }
            break;
        case 5:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            ResourceViewController *resourceVC = [[ResourceViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:resourceVC animated:NO];
        }
            break;
        case 6:
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            TheIncubatorViewController *theIncubatorVC = [[TheIncubatorViewController alloc] init];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:theIncubatorVC animated:NO];
        }
        default:
            break;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = [[heightarray objectAtIndex:indexPath.row] floatValue];
    
    CGSize size = CGSizeMake(CELLHEIGH, height);
    
    return size;
}
- (void)backClick
{
    self.collectionView.hidden = YES;
    self.bottonView.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.hidden = YES;
    self.bottonView.hidden = YES;
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
