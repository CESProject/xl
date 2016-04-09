//
//  PersonalDataViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonalDataCell.h"
#import "BasicViewController.h"
#import "EducationViewController.h"
#import "JobViewController.h"
#import "GrowUpViewController.h"
#import "AppDelegate.h"
#import "BusinessCardViewController.h"
@interface PersonalDataViewController ()
{
    NSArray *titlePersArr;
    NSArray *imgPersArr;
    NSArray *NameArray;
    NSArray *imgArr;
    NSArray *bacArr;
}
@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    NameArray=@[@"个人信息",@"账号信息"];
    NSArray *persTitl = @[@"基本信息",@"教育信息",@"职业信息",@"成长足迹",@"邮寄地址",@"我的名片"];
    NSArray *numTitl = @[@"个人域名",@"绑定手机",@"修改密码",@"修改邮箱",@"个人账户",@"退出登录"];
    titlePersArr = @[persTitl,numTitl];
    NSArray *one = @[@"g1",@"g2",@"g3",@"g4",@"g5",@"g6"];
    NSArray *too = @[@"zh1",@"zh2",@"zh3",@"zh4",@"zh5",@"zh6"];
    imgArr = @[one,too];
    NSArray *ob = @[DEF_RGB_COLOR(213,159,200),DEF_RGB_COLOR(141,198,191),DEF_RGB_COLOR(214,207,140),DEF_RGB_COLOR(176,211,95),DEF_RGB_COLOR(241,175,159),DEF_RGB_COLOR(239,167,169)];
    NSArray *tob = @[DEF_RGB_COLOR(212,158,200),DEF_RGB_COLOR(150,210,202),DEF_RGB_COLOR(234,226,146),DEF_RGB_COLOR(176,211,95),DEF_RGB_COLOR(241,175,159),DEF_RGB_COLOR(213,241,159)];
    bacArr = @[ob,tob];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate   = self;
    self.collectionView.dataSource = self;
    /**
     *   注册一个 cell 固定写法 指定可重用标示符 因为在创建 cell 的时候需要这个标示符
     */
    [self.collectionView registerClass:[PersonalDataCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}
//返回每个区的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = titlePersArr[section];
    return arr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//返回一个cell
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = titlePersArr[indexPath.section];
    NSArray *imArr =imgArr[indexPath.section];
    NSArray *baArr = bacArr[indexPath.section];
    PersonalDataCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLab.text =arr[indexPath.row];
    [cell.bacBtn setBackgroundColor:baArr[indexPath.row]];
    [cell.bacBtn setImage:[UIImage imageNamed:imArr[indexPath.row]] forState:0];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind==UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerview =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        headerview.backgroundColor=DEF_RGB_COLOR(229, 229, 229);
   
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10,0 , DEF_SCREEN_WIDTH-20, 30)];
        label.textColor = [UIColor grayColor];
        label.font=[UIFont systemFontOfSize:15];
        label.text=[NameArray objectAtIndex:indexPath.section];
        [headerview addSubview:label];
        return headerview;
        
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(DEF_SCREEN_WIDTH, 30);
}
//@return  返回每个 item 的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width/3-20;
    return CGSizeMake(width, width+20);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            BasicViewController *basiVC = [[BasicViewController alloc] init];
            basiVC.passNum = 0;
            [self.navigationController pushViewController:basiVC animated:YES];
        }else if (indexPath.item==1)
        {
            EducationViewController *eduVC =[[EducationViewController alloc] init];
            eduVC.passNum = 0;
            [self.navigationController pushViewController:eduVC animated:YES];
        }
        else if (indexPath.item==2)
        {
            JobViewController *jobVC =[[JobViewController alloc] init];
//            jobVC.passNum = 0;
            [self.navigationController pushViewController:jobVC animated:YES];
        }else if (indexPath.item==3)
        {
            GrowUpViewController *growVC = [[GrowUpViewController alloc] init];
            [self.navigationController pushViewController:growVC animated:YES];
        }else if (indexPath.item==5)
        {
            BusinessCardViewController *busVC = [[BusinessCardViewController alloc] init];
            [self.navigationController pushViewController:busVC animated:YES];
        }
    }else
    {
        if (indexPath.item==5)
        {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [tempAppDelegate loginView];
        }
    }
    
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
